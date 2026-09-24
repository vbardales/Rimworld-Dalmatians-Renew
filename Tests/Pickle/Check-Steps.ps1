<#
  Offline check of the Pickle suite. It needs no game and no Pickle run, and it settles what a run
  would otherwise settle at the cost of a whole launch: a step that exists nowhere, a step that two
  patterns claim, a pattern nothing uses, a requirement no pass map can satisfy.

    powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1

  What it reads
    - Source/*.cs                       the steps this suite declares
    - RimWorks.Pickle*.dll              the steps Pickle itself ships, by reflection
    - PickleTools/*/Source/*.cs         the shared tool steps the pass maps stage
    - Mod/Pickle/Features/*.feature     every step line of every scenario
    - wsl-deps.*.map                    the passes

  What it does not prove: that a step does what its sentence says. That is the run's job.
#>
param(
    [string]$Pickle = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Mods\Pickle-local\Assemblies',
    [string]$Managed = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed'
)

$ErrorActionPreference = 'Stop'
$suite = $PSScriptRoot
$root = (Resolve-Path (Join-Path $suite '..\..\..')).Path
$bad = 0

$searchDirs = @($Pickle, $Managed)
[AppDomain]::CurrentDomain.add_AssemblyResolve({
    param($sender, $e)
    $n = ($e.Name -split ',')[0]
    foreach ($d in $searchDirs) {
        $p = Join-Path $d "$n.dll"
        if (Test-Path $p) { return [Reflection.Assembly]::LoadFrom($p) }
    }
    return $null
}.GetNewClosure())
foreach ($n in 'Cucumber.Messages', 'CucumberExpressions', 'Gherkin', 'RimWorks.Pickle.Core', 'RimWorks.Pickle', 'RimWorks.Pickle.Vanilla') {
    $path = Join-Path $Pickle "$n.dll"
    if (-not (Test-Path $path)) { throw "$n.dll not found under $Pickle" }
    [Reflection.Assembly]::LoadFrom($path) | Out-Null
}
$core = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GetName().Name -eq 'RimWorks.Pickle.Core' }
$registry = [Activator]::CreateInstance($core.GetType('RimWorks.Pickle.Core.Steps.PickleParameterTypeRegistry'))

function Get-Declared([string[]]$files, [string]$origin) {
    foreach ($file in $files) {
        $text = [IO.File]::ReadAllText($file)
        foreach ($m in [regex]::Matches($text, '\[(?:Given|When|Then)\("((?:[^"\\]|\\.)*)"')) {
            [pscustomobject]@{ Origin = $origin; File = (Split-Path $file -Leaf); Pattern = $m.Groups[1].Value -replace '\\\\', '\' -replace '\\"', '"' }
        }
    }
}

$patterns = @()
$patterns += Get-Declared (Get-ChildItem (Join-Path $suite 'Source') -Filter *.cs | ForEach-Object FullName) 'local'
$localCount = $patterns.Count
if ($localCount -eq 0) { throw 'no local step patterns found' }

foreach ($n in 'RimWorks.Pickle.Vanilla', 'RimWorks.Pickle') {
    $asm = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GetName().Name -eq $n }
    try { $types = $asm.GetTypes() } catch [Reflection.ReflectionTypeLoadException] { $types = $_.Exception.Types | Where-Object { $_ } }
    foreach ($t in $types) {
        foreach ($m in $t.GetMethods()) {
            # A method whose attributes cannot load is not a step; skip it rather than stop.
            try { $attrs = $m.GetCustomAttributes($false) } catch { continue }
            foreach ($a in $attrs) {
                if ($a.GetType().Name -in 'GivenAttribute', 'WhenAttribute', 'ThenAttribute') {
                    $patterns += [pscustomobject]@{ Origin = 'pickle'; File = $t.Name; Pattern = $a.Pattern }
                }
            }
        }
    }
}

# Shared tools: only the ones a pass map stages are in play, and each is a folder under PickleTools.
$mapLines = foreach ($map in Get-ChildItem $suite -Filter 'wsl-deps.*.map') {
    foreach ($raw in [IO.File]::ReadAllLines($map.FullName)) {
        $line = $raw.Trim()
        if ($line -eq '' -or $line.StartsWith('#')) { continue }
        $parts = $line -split '\s+', 2
        [pscustomobject]@{ Map = $map.Name; Package = $parts[0]; Target = $parts[1] }
    }
}
$toolDirs = $mapLines | Where-Object { $_.Target -like 'path:PickleTools/*' } |
    ForEach-Object { (Join-Path $root ($_.Target.Substring(5) -replace '/', '\')) -replace '\\Mod$', '' } | Sort-Object -Unique
foreach ($dir in $toolDirs) {
    $sources = Get-ChildItem $dir -Recurse -Filter *.cs -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '\\(obj|bin|\.build)\\' } | ForEach-Object FullName
    $patterns += Get-Declared $sources 'tool'
}

$compiled = @()
foreach ($p in $patterns) {
    try {
        $compiled += [pscustomobject]@{ Origin = $p.Origin; File = $p.File; Pattern = $p.Pattern; Regex = (New-Object CucumberExpressions.CucumberExpression($p.Pattern, $registry)).Regex; Used = $false }
    }
    catch {
        if ($p.Origin -eq 'local') { Write-Host "INVALID $($p.File): $($p.Pattern)" -ForegroundColor Red; $bad++ }
    }
}

foreach ($g in ($patterns | Where-Object Origin -eq 'local' | Group-Object Pattern | Where-Object Count -gt 1)) {
    Write-Host "DUPLICATE local pattern: $($g.Name)" -ForegroundColor Red; $bad++
}

# Steps the runner plays itself, taken from the features Pickle ships as its own tests.
function Normalize([string]$s) { ($s -replace '"[^"]*"', '{string}') -replace '\b\d+(\.\d+)?\b', '{int}' }
$engine = New-Object System.Collections.Generic.HashSet[string]
$engineUsed = @()
$pickleRoot = Split-Path $Pickle -Parent
foreach ($f in Get-ChildItem (Join-Path $pickleRoot 'Pickle\Features') -Filter *.feature -ErrorAction SilentlyContinue) {
    foreach ($raw in [IO.File]::ReadAllLines($f.FullName)) {
        if ($raw.Trim() -match '^(Given|When|Then|And|But)\s+(.+)$') { [void]$engine.Add((Normalize $Matches[2].Trim())) }
    }
}

# Every step line of every feature, and the tags that gate it.
$tags = New-Object System.Collections.Generic.HashSet[string]
$lines = 0
$features = Get-ChildItem (Join-Path $suite 'Mod\Pickle\Features') -Filter *.feature
$parser = New-Object Gherkin.Parser
$scenarios = 0
foreach ($feature in $features) {
    # Pickle's own parser: a feature that does not parse would drop out at startup and take its
    # scenarios with it, while the rest of the suite still loads.
    try { [void]$parser.Parse((New-Object IO.StreamReader($feature.FullName))) }
    catch { Write-Host "SYNTAX $($feature.Name): $($_.Exception.Message)" -ForegroundColor Red; $bad++; continue }
    $text = [IO.File]::ReadAllLines($feature.FullName)
    $plain = @($text | Where-Object { $_ -match '^\s*Scenario:' }).Count
    $outlines = @($text | Where-Object { $_ -match '^\s*Scenario Outline:' }).Count
    $rows = @($text | Where-Object { $_ -match '^\s*\|' }).Count
    # Each Examples table has one header row; a scenario outline plays once per remaining row.
    $scenarios += $plain + $rows - $outlines
    foreach ($raw in $text) {
        $line = $raw.Trim()
        if ($line.StartsWith('@')) { foreach ($t in ($line -split '\s+')) { [void]$tags.Add($t) } }
        if ($line -notmatch '^(Given|When|Then|And|But)\s+(.+)$') { continue }
        $step = $Matches[2].Trim()
        $lines++
        $hits = @($compiled | Where-Object { $_.Regex.IsMatch($step) })
        if ($hits.Count -eq 0) {
            # The runner's own entry steps (loading a fixture, save and reload) are not declared by
            # an attribute this script can reflect. Pickle's shipped features play them, so a line
            # that reads exactly like one of theirs is accepted, and listed so it stays visible.
            if ($engine.Contains((Normalize $step))) { $engineUsed += $step; continue }
            Write-Host "UNDEFINED $($feature.Name): $step" -ForegroundColor Red; $bad++
        }
        elseif ($hits.Count -gt 1) {
            Write-Host "AMBIGUOUS $($feature.Name): $step" -ForegroundColor Red
            $hits | ForEach-Object { Write-Host "    $($_.Origin) $($_.File): $($_.Pattern)" -ForegroundColor DarkRed }
            $bad++
        }
        else { $hits[0].Used = $true }
    }
}

foreach ($c in ($compiled | Where-Object { $_.Origin -eq 'local' -and -not $_.Used })) {
    Write-Host "UNUSED local pattern: $($c.Pattern)" -ForegroundColor Yellow; $bad++
}

# Requirements: every @requires:<packageId> must be a package some pass map stages.
$staged = @($mapLines | ForEach-Object { $_.Package.ToLowerInvariant() })
foreach ($tag in ($tags | Where-Object { $_ -like '@requires:*' })) {
    $id = $tag.Substring(10).ToLowerInvariant()
    if ($staged -notcontains $id) { Write-Host "REQUIREMENT no pass map stages $id ($tag)" -ForegroundColor Red; $bad++ }
}

# Maps: a path entry must exist and carry the packageId the line names; an id entry needs an id.
foreach ($m in $mapLines) {
    if ($m.Target -like 'path:*') {
        $dir = Join-Path $root ($m.Target.Substring(5) -replace '/', '\')
        $about = Join-Path $dir 'About\About.xml'
        if (-not (Test-Path $about)) { Write-Host "MAP $($m.Map): $($m.Target) has no About.xml" -ForegroundColor Red; $bad++; continue }
        $declared = ([xml](Get-Content $about -Raw)).ModMetaData.packageId
        if ($declared -ne $m.Package) { Write-Host "MAP $($m.Map): line names $($m.Package) but $($m.Target) is $declared" -ForegroundColor Red; $bad++ }
    }
    elseif ($m.Target -notmatch '^\d+$') { Write-Host "MAP $($m.Map): $($m.Package) has no numeric Workshop id" -ForegroundColor Red; $bad++ }
}

foreach ($e in ($engineUsed | Sort-Object -Unique)) { Write-Host "RUNNER STEP  $e" -ForegroundColor DarkGray }
Write-Host "$localCount local patterns, $($patterns.Count - $localCount) from Pickle and the staged tools; $lines feature step lines in $($features.Count) files; $($mapLines.Count) map lines; $scenarios scenarios to play across all passes."
if ($bad -gt 0) { Write-Host "$bad problem(s)" -ForegroundColor Red; exit 1 }
Write-Host 'EVERY STEP IS DEFINED ONCE, EVERY LOCAL PATTERN IS USED, EVERY REQUIREMENT AND MAP RESOLVES' -ForegroundColor Green
