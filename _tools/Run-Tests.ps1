<#
.SYNOPSIS
  The mod's own test suite. Runs without RimWorld, in a few seconds.

.DESCRIPTION
  This repository holds one mod and no longer sits inside the monorepo, so the checkers that live
  under its scripts/ are not next to it any more. They are still the deeper instruments, and the
  field walk below is a compact version of Check-XmlFields.ps1 brought in here rather than
  depended on: a detached repository has to be able to test itself.

  This mod ships no assembly, so there is no mod C# to instantiate. What takes its place is the
  vanilla side: the suite loads Assembly-CSharp by reflection and asks the game's own classes what
  this mod is allowed to assume. Three of its tests go further and read A Dog Said... Animal
  Prosthetics 2 off disk, because the patch's whole behaviour is decided by that mod's data.

  Four groups:

    About and images   the identity that must never change, the two pictures, and the textures
    The defs           parses, every element a real 1.6 field, every class, parent and def
                       reference resolving, no collision with the game's own names
    The rules          the sentences the documents state as fact, each computed from the game or
                       from A Dog Said 2 rather than trusted
    Translations       every French key pointing at something real, in folders spelled the way
                       the classes are

  The third group is the point of having a suite at all:

    - "the predicate matched every RecipeDef in the document" is not asserted, it is run: the old
      form and the new one are both executed against A Dog Said 2's own file and their counts
      compared. A test that only checked the new form would pass on a file with three recipes in
      it and prove nothing.
    - "the guard is silent without A Dog Said 2" is run against a document that has no ADS_Cat1.
    - "the same operations as vanilla's husky" is computed from ADS 2's three category lists,
      not from this mod's prose.
    - "wildness stopped being a field" is asked of RaceProperties by reflection, and the clamp
      that makes the damage small is read off the Wildness StatDef in the game's data.
    - "MayRequire on an Operation is read by nothing" is asked of Verse.PatchOperation. If a
      future release adds the field, this is what says the comment in the patch is now wrong.
    - "14 against plain leather's 16" walks LeatherBase, because Leather_Plain declares no
      statBases of its own and the number is inherited.

  The suite writes with Write-Output and never Write-Host: the output has to survive being piped
  into a file or a variable, which Write-Host does not.

  Exit code 0 when everything passes, 1 otherwise.

  EVERY TEST HERE HAS BEEN SEEN TO FAIL. A suite that goes green on its first run has proved
  nothing. Six of these failed on the real files at the first run - the two pictures were still
  full-resolution renders, PawnKindDef parents were not being indexed, the tautology test was
  comparing the wrong thing, the README check was reading a Unicode minus as mojibake and the
  puppy key was being looked for without its field suffix. The rest were woken by faults
  introduced into copies of the mod in a scratch directory, never into the real files, in twelve
  batches whose members target disjoint tests:

    packageId, loadBefore, a PublishedFileId.txt, a miscased texPath,
    a Dessicated _north added                     -> the five About and image tests
    an element that is no field, a bad ParentName,
    a leatherDef pointing nowhere                 -> field walk, parent, reference
    Leather_Dalmatian renamed Leather_Dog         -> the collision test, and four cascades
    <wildness> back under <race>, <Wildness> gone
    from statBases, animalType removed            -> the three rules tests about the animal
    MayRequire on the Operation, a <nomatch>      -> the MayRequire and patch-shape tests
    the match predicate rewritten to the old form -> the tautology test, and the categories test
    the guard xpath widened to any RecipeDef      -> the guard test
    insulation 16, market value 300               -> the leather margin, the document drift
    DefInjected/ThingDef renamed thingdef,
    the puppy label edited                        -> the folder spelling, the puppy key
    a French key pointed at a def that is gone    -> the key test and the coverage test
    Class="PatchOperationConditionel"             -> the Class test
    the race def truncated mid-element            -> the parse test, and six cascades

  One batch rewrote the mutation harness rather than confirming a test. Replacing
  <animalType>Canine</animalType> with <wildness>0</wildness> and then <Wildness>0</Wildness> with
  something else turned BOTH into that something else: PowerShell's -replace is case insensitive,
  and <wildness> and <Wildness> are different elements. The harness uses -creplace now.

.EXAMPLE
  powershell -NoProfile -File _tools/Run-Tests.ps1

.EXAMPLE
  # From Git Bash, where the machine's execution policy refuses a script file:
  powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1
#>

param(
    [string]$ModRoot  = (Split-Path -Parent $PSScriptRoot),
    [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
    [string]$Managed  = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed',
    [string]$AdsRoot  = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\3238353862'
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------------------------
# Harness
# ---------------------------------------------------------------------------------------------

$script:ran     = 0
$script:failed  = 0
$script:skipped = 0

# A test body writes its problems to the pipeline and stays silent when it has none. No assertion
# vocabulary: one test that lists every offending element beats ten that stop at the first.
function It([string]$name, [scriptblock]$body) {
    $script:ran++
    $problems = @()
    try   { $problems = @(& $body | Where-Object { $_ }) }
    catch { $problems = @("threw: $($_.Exception.Message)") }

    if ($problems.Count -eq 0) {
        Write-Output "  ok    $name"
    } else {
        $script:failed++
        Write-Output "  FAIL  $name"
        foreach ($p in $problems) { Write-Output "          $p" }
    }
}

# A test that cannot run here is not a passing test. It is counted apart and says why.
function ItSkip([string]$name, [string]$why) {
    $script:skipped++
    Write-Output "  skip  $name"
    Write-Output "          $why"
}

function Section([string]$name) { Write-Output ''; Write-Output $name }

# ---------------------------------------------------------------------------------------------
# What the mod ships
# ---------------------------------------------------------------------------------------------

$modDir   = Join-Path $ModRoot 'Mod'
$defFiles = @(Get-ChildItem (Join-Path $modDir 'Defs') -Recurse -Filter *.xml)

# Parsed once: a malformed file is reported by the first test and would otherwise throw in every
# other one. $null for a file that does not parse.
$docs = @{}
foreach ($f in $defFiles) {
    try { $x = New-Object System.Xml.XmlDocument; $x.Load($f.FullName); $docs[$f.FullName] = $x }
    catch { $docs[$f.FullName] = $null }
}

# Element names are read with .LocalName, never .Name: PowerShell's XML adapter shadows .Name with
# a "Name" attribute where one exists.
function Get-DefNodes {
    foreach ($f in $defFiles) {
        $x = $docs[$f.FullName]
        if ($null -eq $x -or $null -eq $x.DocumentElement) { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) { if ($n.NodeType -eq 'Element') { $n } }
    }
}

$defNodes = @(Get-DefNodes)

# defName -> the kinds of def that carry it. A list, not a single value: the ThingDef and the
# PawnKindDef deliberately share CCPDalmatian, the way every vanilla animal does.
$modDefs = @{}
foreach ($n in $defNodes) {
    $dn = [string]$n.defName
    if ([string]::IsNullOrWhiteSpace($dn)) { continue }
    if (-not $modDefs.ContainsKey($dn)) { $modDefs[$dn] = @() }
    $modDefs[$dn] += $n.LocalName
}

function Get-ModDef([string]$type, [string]$defName) {
    foreach ($n in $defNodes) {
        if ($n.LocalName -eq $type -and [string]$n.defName -eq $defName) { return $n }
    }
    return $null
}

# Taken by kind and not by name wherever a test is about the name itself: a test that looks a def
# up by defName has nothing in hand when the fault introduced IS the defName.
$thingNodes = @($defNodes | Where-Object { $_.LocalName -eq 'ThingDef' })
$kindNodes  = @($defNodes | Where-Object { $_.LocalName -eq 'PawnKindDef' })
$dogNode     = Get-ModDef 'ThingDef' 'CCPDalmatian'
$leatherNode = Get-ModDef 'ThingDef' 'Leather_Dalmatian'
$kindNode    = $(if ($kindNodes.Count -gt 0) { $kindNodes[0] })

$patchFile = Join-Path $modDir 'Patches\ADSPatch.xml'
$patchDoc  = $null
if (Test-Path $patchFile) {
    try { $patchDoc = New-Object System.Xml.XmlDocument; $patchDoc.Load($patchFile) } catch { $patchDoc = $null }
}

$aboutFile = Join-Path $modDir 'About\About.xml'
$aboutDoc  = $null
if (Test-Path $aboutFile) {
    try { $aboutDoc = New-Object System.Xml.XmlDocument; $aboutDoc.Load($aboutFile) } catch { $aboutDoc = $null }
}

# ---------------------------------------------------------------------------------------------
# The game's classes, by reflection
# ---------------------------------------------------------------------------------------------
#
# Assembly-CSharp is resolvable but not fully loadable outside RimWorld - it references Unity
# assemblies that are not all there - so GetTypes() always throws. The exception still carries
# every type it did resolve. The guard against asking twice for the same name is the one from the
# monorepo's Check-XmlFields.ps1: an unresolvable name asked twice recurses to a stack overflow
# instead of erroring.

$script:probed = @{}
$script:asmResolver = [System.ResolveEventHandler]{
    param($sender, $e)
    if ($null -eq $script:probed) { return $null }
    $short = $e.Name.Split(',')[0]
    if ($script:probed.ContainsKey($short)) { return $null }
    $script:probed[$short] = $true
    $p = Join-Path $Managed "$short.dll"
    if (Test-Path $p) { return [System.Reflection.Assembly]::LoadFrom($p) }
    return $null
}
[System.AppDomain]::CurrentDomain.add_AssemblyResolve($script:asmResolver)

function Get-AssemblyTypes([string]$path) {
    $a = [System.Reflection.Assembly]::LoadFrom($path)
    try     { return $a.GetTypes() }
    catch [System.Reflection.ReflectionTypeLoadException] { return $_.Exception.Types | Where-Object { $_ } }
    catch   { return $_.Exception.InnerException.Types | Where-Object { $_ } }
}

$byName  = @{}
$asmPath = Join-Path $Managed 'Assembly-CSharp.dll'
if (Test-Path $asmPath) {
    foreach ($t in @(Get-AssemblyTypes $asmPath)) {
        if (-not $byName.ContainsKey($t.Name)) { $byName[$t.Name] = $t }
        if ($t.FullName -and -not $byName.ContainsKey($t.FullName)) { $byName[$t.FullName] = $t }
    }
}
$defType = $byName['Verse.Def']

$BF = [System.Reflection.BindingFlags]::Public    -bor `
      [System.Reflection.BindingFlags]::NonPublic -bor `
      [System.Reflection.BindingFlags]::Instance  -bor `
      [System.Reflection.BindingFlags]::DeclaredOnly

# GetFields on a derived type does not return private fields of its base types, and RimWorld has
# plenty. Walk the chain by hand, and index a renamed field under its [LoadAlias] too: the loader
# looks the aliases up, so such an element is honoured, not dropped.
$fieldCache = @{}
function Get-FieldsRecursive([Type]$t) {
    if ($fieldCache.ContainsKey($t)) { return $fieldCache[$t] }
    $d = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') {
        foreach ($f in $cur.GetFields($BF)) {
            if (-not $d.ContainsKey($f.Name)) { $d[$f.Name] = $f }
            foreach ($a in $f.CustomAttributes) {
                if ($a.AttributeType.Name -ne 'LoadAliasAttribute') { continue }
                foreach ($arg in $a.ConstructorArguments) {
                    $alias = [string]$arg.Value
                    if ($alias -and -not $d.ContainsKey($alias)) { $d[$alias] = $f }
                }
            }
        }
        $cur = $cur.BaseType
    }
    $fieldCache[$t] = $d
    return $d
}

# A type that implements LoadDataFromXmlCustom is invisible to field reflection: RimWorld hands it
# the raw node and it reads whatever it likes. StatModifier and SimpleCurve, the two this mod
# writes, are among them. What can still be asserted under one is that every child is a leaf: an
# <li> carrying element children is the dictionary form, which no RimWorld version accepts and
# which aborts the WHOLE def rather than the one field.
$customLoaderCache = @{}
function Test-CustomLoader([Type]$t) {
    if (-not $t) { return $false }
    if ($customLoaderCache.ContainsKey($t)) { return $customLoaderCache[$t] }
    $r = $null -ne $t.GetMethod('LoadDataFromXmlCustom', $BF -bxor [System.Reflection.BindingFlags]::DeclaredOnly)
    $customLoaderCache[$t] = $r
    return $r
}

function Resolve-Wrapper([Type]$t) {
    while ($t -and $t.IsGenericType) {
        $g = $t.GetGenericTypeDefinition()
        if ($g -eq [System.Nullable`1] -or $g.Name -eq 'SlateRef`1') { $t = $t.GetGenericArguments()[0] }
        else { break }
    }
    return $t
}

$script:fieldProblems = New-Object System.Collections.ArrayList
$script:defRefs       = New-Object System.Collections.ArrayList

function Add-DefRef([Type]$t, [string]$name, [string]$where) {
    if ([string]::IsNullOrWhiteSpace($name)) { return }
    [void]$script:defRefs.Add(@{ Type = $t.Name; Name = $name.Trim(); Where = $where })
}

function Test-LoaderShape($container, [string]$path, [Type]$elem) {
    foreach ($child in $container.ChildNodes) {
        if ($child.NodeType -ne 'Element' -or $child.LocalName -ne 'li') { continue }
        foreach ($grand in $child.ChildNodes) {
            if ($grand.NodeType -ne 'Element') { continue }
            [void]$script:fieldProblems.Add("$path/li/$($grand.LocalName)  -- $($elem.Name) is loaded by LoadDataFromXmlCustom; an <li> with children is the dictionary form, which RimWorld throws on")
            break
        }
    }
}

# statBases keys its children by defName rather than by field, so the field walk cannot follow it -
# but the names are still references worth resolving, and Wildness is one of them.
$keyedByDefName = @{ 'StatModifier' = 'StatDef' }

function Walk($node, [Type]$t, [string]$path) {
    if (-not $t) { return }
    $fields = Get-FieldsRecursive $t
    foreach ($child in $node.ChildNodes) {
        if ($child.NodeType -ne 'Element') { continue }
        $n = $child.LocalName
        if ($n -eq 'li') { continue }

        $f = $null
        if ($fields.ContainsKey($n)) { $f = $fields[$n] }
        else { foreach ($k in $fields.Keys) { if ($k -ieq $n) { $f = $fields[$k]; break } } }
        if (-not $f) { [void]$script:fieldProblems.Add("$path/$n  -- no field '$n' on $($t.Name)"); continue }

        $ft = Resolve-Wrapper $f.FieldType
        if ($defType -and $defType.IsAssignableFrom($ft)) { Add-DefRef $ft $child.InnerText "$path/$n"; continue }
        if ($ft.IsPrimitive -or $ft -eq [string] -or $ft.IsEnum) { continue }

        if ($ft.IsGenericType -and $ft.GetGenericTypeDefinition() -eq [System.Collections.Generic.List`1]) {
            $elem = Resolve-Wrapper $ft.GetGenericArguments()[0]
            if ($defType -and $defType.IsAssignableFrom($elem)) {
                foreach ($li in $child.ChildNodes) {
                    if ($li.NodeType -eq 'Element') { Add-DefRef $elem $li.InnerText "$path/$n/li" }
                }
                continue
            }
            if ($elem.IsPrimitive -or $elem -eq [string] -or $elem.IsEnum) { continue }
            if (Test-CustomLoader $elem) {
                Test-LoaderShape $child "$path/$n" $elem
                if ($keyedByDefName.ContainsKey($elem.Name)) {
                    $kt = $byName[$keyedByDefName[$elem.Name]]
                    foreach ($k in $child.ChildNodes) {
                        if ($k.NodeType -eq 'Element' -and $k.LocalName -ne 'li') { Add-DefRef $kt $k.LocalName "$path/$n" }
                    }
                }
                continue
            }
            foreach ($li in $child.ChildNodes) {
                if ($li.NodeType -ne 'Element') { continue }
                $lt = $elem
                $cls = $li.GetAttribute('Class')
                if ($cls) { $short = $cls.Split('.')[-1]; if ($byName.ContainsKey($short)) { $lt = $byName[$short] } }
                Walk $li $lt "$path/$n/li"
            }
            continue
        }

        if (Test-CustomLoader $ft) {
            Test-LoaderShape $child "$path/$n" $ft
            if ($keyedByDefName.ContainsKey($ft.Name)) {
                $kt = $byName[$keyedByDefName[$ft.Name]]
                foreach ($k in $child.ChildNodes) {
                    if ($k.NodeType -eq 'Element' -and $k.LocalName -ne 'li') { Add-DefRef $kt $k.LocalName "$path/$n" }
                }
            }
            continue
        }

        $sub = $ft
        $cls = $child.GetAttribute('Class')
        if ($cls) { $short = $cls.Split('.')[-1]; if ($byName.ContainsKey($short)) { $sub = $byName[$short] } }
        Walk $child $sub "$path/$n"
    }
}

if ($byName.Count -gt 0) {
    foreach ($n in $defNodes) {
        $dt = $byName[$n.LocalName]
        if (-not $dt) { [void]$script:fieldProblems.Add("unknown def type <$($n.LocalName)>"); continue }
        Walk $n $dt "$($n.LocalName)/$($n.defName)"
    }
}

# ---------------------------------------------------------------------------------------------
# The game's data, indexed in one pass
# ---------------------------------------------------------------------------------------------
#
# Strings only, never the XML nodes: a node keeps its whole document alive, and there are some
# fifteen hundred of them under Data.

$vanilla   = @{}   # def type -> set of defName
$templates = @{}   # def type -> Name= -> @{ Parent; Stats }
$thingInfo = @{}   # ThingDef defName -> @{ Parent; Stats }
$statInfo  = @{}   # StatDef defName  -> @{ MinValue; ShowIfUndefined; DefaultBaseValue }
$canines   = @()   # every def in the game that declares <animalType>Canine</animalType>

function Read-StatBases($n) {
    $d = @{}
    $sb = $n.SelectSingleNode('statBases')
    if ($sb) {
        foreach ($c in $sb.ChildNodes) {
            if ($c.NodeType -eq 'Element' -and $c.LocalName -ne 'li') { $d[$c.LocalName] = $c.InnerText }
        }
    }
    return $d
}

foreach ($dir in (Get-ChildItem $GameData -Directory)) {
    $defsRoot = Join-Path $dir.FullName 'Defs'
    if (-not (Test-Path $defsRoot)) { continue }
    foreach ($f in Get-ChildItem $defsRoot -Recurse -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($null -eq $x.DocumentElement -or $x.DocumentElement.LocalName -ne 'Defs') { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) {
            if ($n.NodeType -ne 'Element') { continue }
            $type   = $n.LocalName
            $dnNode = $n.SelectSingleNode('defName')
            $nm     = $n.GetAttribute('Name')
            if ($dnNode) {
                if (-not $vanilla.ContainsKey($type)) { $vanilla[$type] = @{} }
                $vanilla[$type][$dnNode.InnerText] = $true
            }
            # Abstract templates are indexed for EVERY def type, not just ThingDef: the animal is
            # a ThingDef on AnimalThingBase and a PawnKindDef on AnimalKindBase, and only the
            # first of those two lives among the ThingDefs.
            if ($nm) {
                if (-not $templates.ContainsKey($type)) { $templates[$type] = @{} }
                $templates[$type][$nm] = @{ Parent = $n.GetAttribute('ParentName'); Stats = (Read-StatBases $n) }
            }
            if ($type -eq 'ThingDef') {
                $info = @{ Parent = $n.GetAttribute('ParentName'); Stats = (Read-StatBases $n) }
                if ($dnNode) { $thingInfo[$dnNode.InnerText] = $info }
                $at = $n.SelectSingleNode('race/animalType')
                if ($at -and $at.InnerText.Trim() -eq 'Canine') {
                    $canines += $(if ($dnNode) { $dnNode.InnerText } else { "$nm (abstract)" })
                }
            }
            if ($type -eq 'StatDef' -and $dnNode) {
                $mv = $n.SelectSingleNode('minValue')
                $si = $n.SelectSingleNode('showIfUndefined')
                $db = $n.SelectSingleNode('defaultBaseValue')
                $statInfo[$dnNode.InnerText] = @{
                    MinValue         = $(if ($mv) { $mv.InnerText } else { $null })
                    ShowIfUndefined  = $(if ($si) { $si.InnerText } else { $null })
                    DefaultBaseValue = $(if ($db) { $db.InnerText } else { $null })
                }
            }
        }
    }
}

# The value a ThingDef ends up with for one stat, walking ParentName up the vanilla templates.
# Leather_Plain declares no statBases at all, so this is the only way to know what the game gives
# it - and the number the documents quote is the answer.
function Resolve-Stat($info, [string]$stat) {
    $hops = 0
    while ($info -and $hops -lt 12) {
        if ($info.Stats.ContainsKey($stat)) { return $info.Stats[$stat] }
        if (-not $info.Parent) { return $null }
        $info = $templates['ThingDef'][$info.Parent]
        $hops++
    }
    return $null
}

function Test-Template([string]$type, [string]$name) {
    return ($templates.ContainsKey($type) -and $templates[$type].ContainsKey($name))
}

function Test-VanillaDef([string]$type, [string]$name) {
    return ($vanilla.ContainsKey($type) -and $vanilla[$type].ContainsKey($name))
}

# ---------------------------------------------------------------------------------------------
# A Dog Said... Animal Prosthetics 2, read off disk
# ---------------------------------------------------------------------------------------------

$adsCatFile = Join-Path $AdsRoot '1.6\Defs\AnimalCategories\Animal_Categories.xml'
$adsDoc     = $null
if (Test-Path $adsCatFile) {
    try { $adsDoc = New-Object System.Xml.XmlDocument; $adsDoc.Load($adsCatFile) } catch { $adsDoc = $null }
}

# ---------------------------------------------------------------------------------------------

Write-Output 'Dalmatians Renew - test suite'
Write-Output "  mod        $ModRoot"
Write-Output "  game data  $GameData"
$templateCount = 0
foreach ($k in $templates.Keys) { $templateCount += $templates[$k].Count }
Write-Output ("  indexed    {0} def types and {1} abstract templates from the game, {2} game classes" -f `
              $vanilla.Count, $templateCount, $byName.Count)
Write-Output ("  defs       {0} file(s), {1} def(s), {2} def reference(s) collected" -f `
              $defFiles.Count, $defNodes.Count, $script:defRefs.Count)
Write-Output ("  A Dog Said {0}" -f $(if ($adsDoc) { 'found, 1.6 categories read' } else { 'not installed at the given path' }))
if ($byName.Count -eq 0) { Write-Output '  NOTE       Assembly-CSharp could not be loaded; the reflection tests will fail' }

# =============================================================================================
Section 'About and images'
# =============================================================================================

It 'the identity is the one the repository and the Workshop know' {
    if (-not $aboutDoc) { 'About/About.xml does not parse'; return }
    $r = $aboutDoc.DocumentElement
    $want = @{
        packageId = 'nelim.dalmatiansrenew'
        name      = 'Dalmatians Renew'
        url       = 'https://github.com/vbardales/Rimworld-Dalmatians-Renew'
    }
    foreach ($k in $want.Keys) {
        $node = $r.SelectSingleNode($k)
        $got  = $(if ($node) { $node.InnerText.Trim() } else { '<missing>' })
        if ($got -cne $want[$k]) { "About.xml <$k> is '$got', expected '$($want[$k])'" }
    }
    $v = @($r.SelectNodes('supportedVersions/li') | ForEach-Object { $_.InnerText.Trim() })
    if ($v.Count -ne 1 -or $v[0] -ne '1.6') { "supportedVersions is [$($v -join ', ')], expected [1.6]" }
}

It 'the load order and the incompatibility are declared' {
    if (-not $aboutDoc) { 'About/About.xml does not parse'; return }
    $r  = $aboutDoc.DocumentElement
    $lb = @($r.SelectNodes('loadBefore/li') | ForEach-Object { $_.InnerText.Trim() })
    if ($lb -notcontains 'SamBucher.ADogSaidAnimalProsthetics2') {
        "loadBefore does not name SamBucher.ADogSaidAnimalProsthetics2; it has [$($lb -join ', ')]. " +
        'Without it the category lists are written after A Dog Said 2 has already copied them.'
    }
    $iw = @($r.SelectNodes('incompatibleWith/li') | ForEach-Object { $_.InnerText.Trim() })
    if ($iw -notcontains 'cucumpear.dalmatians') {
        "incompatibleWith does not name cucumpear.dalmatians; it has [$($iw -join ', ')]"
    }
}

It 'no PublishedFileId.txt travels with the port' {
    $p = Join-Path $modDir 'About\PublishedFileId.txt'
    if (Test-Path $p) { 'About/PublishedFileId.txt is present; it names the original authors Workshop item' }
}

It 'Preview.png is 896 x 504 and under 900 KB' {
    $p = Join-Path $modDir 'About\Preview.png'
    if (-not (Test-Path $p)) { 'About/Preview.png is missing'; return }
    Add-Type -AssemblyName System.Drawing
    $img = [System.Drawing.Image]::FromFile($p)
    try {
        if ($img.Width -ne 896 -or $img.Height -ne 504) { "Preview.png is $($img.Width) x $($img.Height), expected 896 x 504" }
    } finally { $img.Dispose() }
    $kb = [math]::Round((Get-Item $p).Length / 1KB)
    if ($kb -gt 900) { "Preview.png weighs $kb KB, over the 900 KB the showcase rules allow" }
}

It 'ModIcon.png is 128 x 128 and weighs what the other icons weigh' {
    $p = Join-Path $modDir 'About\ModIcon.png'
    if (-not (Test-Path $p)) { 'About/ModIcon.png is missing'; return }
    Add-Type -AssemblyName System.Drawing
    $img = [System.Drawing.Image]::FromFile($p)
    try {
        if ($img.Width -ne 128 -or $img.Height -ne 128) {
            "ModIcon.png is $($img.Width) x $($img.Height), expected 128 x 128; the full-resolution render belongs in Art/"
        }
    } finally { $img.Dispose() }
    $kb = [math]::Round((Get-Item $p).Length / 1KB)
    if ($kb -gt 40) { "ModIcon.png weighs $kb KB; the icons in this family run 15 to 35 KB" }
}

# Test-Path finds Dalmatian_east.png when the def asks for dalmatian_east: the fault that hides
# behind it is invisible on Windows and fatal on Linux, so each segment is compared case
# sensitively against what the directory actually holds.
function Test-TexturePath([string]$rel) {
    $dir  = Join-Path $modDir 'Textures'
    $segs = $rel -split '/'
    for ($i = 0; $i -lt $segs.Count - 1; $i++) {
        $hit = @(Get-ChildItem -LiteralPath $dir -Directory | Where-Object { $_.Name -ceq $segs[$i] })
        if ($hit.Count -eq 0) { return "Textures/$rel  -- no directory named exactly '$($segs[$i])'" }
        $dir = $hit[0].FullName
    }
    $leaf  = $segs[-1]
    $files = @(Get-ChildItem -LiteralPath $dir -File -Filter '*.png' | ForEach-Object { [IO.Path]::GetFileNameWithoutExtension($_.Name) })
    $rots  = @($files | Where-Object { $_ -ceq $leaf -or $_ -cmatch "^$([regex]::Escape($leaf))_(north|south|east|west)$" })
    if ($rots.Count -eq 0) {
        $near = @($files | Where-Object { $_ -like "$leaf*" })
        return "Textures/$rel  -- nothing there. The directory holds [$($near -join ', ')]"
    }
    return $null
}

It 'every texPath resolves, case for case' {
    $seen = @{}
    foreach ($n in $defNodes) {
        foreach ($t in $n.SelectNodes('.//texPath')) {
            $rel = $t.InnerText.Trim()
            if ($seen.ContainsKey($rel)) { continue }
            $seen[$rel] = $true
            Test-TexturePath $rel
        }
    }
}

It 'the living animal has three rotations and the dessicated corpse has the one known gap' {
    $dir = Join-Path $modDir 'Textures\Things\Pawn\Animal\Dalmatian'
    if (-not (Test-Path $dir)) { 'the animal texture directory is missing'; return }
    $files = @(Get-ChildItem -LiteralPath $dir -File -Filter '*.png' | ForEach-Object { [IO.Path]::GetFileNameWithoutExtension($_.Name) })

    $live = @($files | Where-Object { $_ -cmatch '^Dalmatian_(north|south|east|west)$' } | Sort-Object)
    if ("$live" -cne 'Dalmatian_east Dalmatian_north Dalmatian_south') {
        "the living animal ships [$($live -join ', ')]; expected east, north and south, with west mirrored by the game"
    }

    # Not a fault to fix: Graphic_Multi rotates the east view for the faces it has not got, and
    # completing it would mean drawing rather than porting. The test exists so that the day a
    # rotation IS added, the documents that describe the gap are updated with it.
    $dead = @($files | Where-Object { $_ -cmatch '^Dessicated_Dalmatian_(north|south|east|west)$' } | Sort-Object)
    if ("$dead" -cne 'Dessicated_Dalmatian_east') {
        "the dessicated corpse ships [$($dead -join ', ')]; the documents say east alone, so they need updating"
    }
}

# =============================================================================================
Section 'The defs'
# =============================================================================================

It 'every def file parses' {
    foreach ($f in $defFiles) { if ($null -eq $docs[$f.FullName]) { "$($f.Name) does not parse" } }
    if (-not $patchDoc) { 'Patches/ADSPatch.xml does not parse or is missing' }
    if (-not $aboutDoc) { 'About/About.xml does not parse or is missing' }
}

It 'the three defs the mod is made of are all there' {
    foreach ($pair in @(,@('ThingDef','CCPDalmatian')), @(,@('PawnKindDef','CCPDalmatian')), @(,@('ThingDef','Leather_Dalmatian'))) {
        $t = $pair[0][0]; $d = $pair[0][1]
        if (-not (Get-ModDef $t $d)) { "no $t named $d" }
    }
    if ($defNodes.Count -ne 3) { "the mod declares $($defNodes.Count) defs, expected 3" }
}

It 'every element maps to a real 1.6 field' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp could not be loaded'; return }
    $script:fieldProblems
}

It 'every Class attribute names a type the game has' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp could not be loaded'; return }
    $nodes = @()
    foreach ($f in $defFiles) { $x = $docs[$f.FullName]; if ($x) { $nodes += @($x.SelectNodes('//*[@Class]')) } }
    if ($patchDoc) { $nodes += @($patchDoc.SelectNodes('//*[@Class]')) }
    foreach ($n in $nodes) {
        $cls   = $n.GetAttribute('Class')
        $short = $cls.Split('.')[-1]
        if (-not $byName.ContainsKey($cls) -and -not $byName.ContainsKey($short)) {
            "Class=`"$cls`" on <$($n.LocalName)> names no type in Assembly-CSharp"
        }
    }
}

It 'every ParentName resolves to a template the game ships' {
    foreach ($n in $defNodes) {
        $p = $n.GetAttribute('ParentName')
        if (-not $p) { "<$($n.LocalName)> $($n.defName) declares no ParentName"; continue }
        if (-not (Test-Template $n.LocalName $p)) {
            "ParentName='$p' on $($n.defName) matches no abstract $($n.LocalName) in the game"
        }
    }
}

It 'every def reference points at something that exists' {
    if ($script:defRefs.Count -eq 0) { 'no def references were collected, which cannot be right'; return }
    foreach ($r in $script:defRefs) {
        $t = $r.Type; $n = $r.Name
        if ($modDefs.ContainsKey($n) -and $modDefs[$n] -contains $t) { continue }
        if (Test-VanillaDef $t $n) { continue }
        "$($r.Where) -> $t '$n' is defined nowhere in the game or in this mod"
    }
}

It 'no defName of this mod collides with one the game already uses' {
    foreach ($dn in $modDefs.Keys) {
        foreach ($t in $modDefs[$dn]) {
            if (Test-VanillaDef $t $dn) { "$t '$dn' is also defined by the game itself" }
        }
    }
}

# =============================================================================================
Section 'The rules this mod rests on'
# =============================================================================================

It 'wildness is no longer a field of RaceProperties, and the def writes none' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp could not be loaded'; return }
    $rp = $byName['RaceProperties']
    if (-not $rp) { 'Verse.RaceProperties not found'; return }
    if ((Get-FieldsRecursive $rp).ContainsKey('wildness')) {
        'RaceProperties has a field named wildness again; the port note about it is now wrong'
    }
    foreach ($n in $defNodes) {
        foreach ($w in $n.SelectNodes('.//race/wildness')) {
            "<wildness> is back under <race> on $($n.defName); the loader drops it and the animal loads without it"
        }
    }
}

It 'Wildness is a stat, and the clamp that made the old fault survivable is real' {
    if (-not $statInfo.ContainsKey('Wildness')) { 'the game declares no StatDef named Wildness'; return }
    $s = $statInfo['Wildness']
    if ($s.MinValue -ne '0') {
        "Wildness minValue is '$($s.MinValue)', not 0. The documents say a wildness of 0 survived the " +
        'old broken form because the stat floors at zero; that is no longer true.'
    }
    if ($s.ShowIfUndefined -ne 'false') {
        "Wildness showIfUndefined is '$($s.ShowIfUndefined)', not false. The documents say the value " +
        'vanished from the information card for that reason.'
    }
    $sb = $dogNode.SelectSingleNode('statBases/Wildness')
    if (-not $sb) { 'the dalmatian declares no <Wildness> under statBases' }
    elseif ($sb.InnerText.Trim() -ne '0') { "the dalmatian declares Wildness $($sb.InnerText), expected 0" }
}

It 'animalType Canine is a value the game has, and the dogs that carry it are the documented ones' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp could not be loaded'; return }
    $at = $byName['AnimalType']
    if (-not $at -or -not $at.IsEnum) { 'Verse.AnimalType is not an enum in this build'; return }
    $names = @([Enum]::GetNames($at))
    if ($names -notcontains 'Canine') { "AnimalType has [$($names -join ', ')] and no Canine" }

    $td = $byName['TraitDef']
    if ($td -and -not (Get-FieldsRecursive $td).ContainsKey('disableHostilityFromAnimalType')) {
        'TraitDef.disableHostilityFromAnimalType is gone; it is the one consumer the documents name'
    }

    $mine = $dogNode.SelectSingleNode('race/animalType')
    if (-not $mine -or $mine.InnerText.Trim() -ne 'Canine') { 'the dalmatian does not declare animalType Canine' }

    foreach ($dog in @('Husky','LabradorRetriever','YorkshireTerrier')) {
        if ($canines -notcontains $dog) { "$dog no longer declares animalType Canine in the game's data" }
    }
}

It 'MayRequire on an Operation is still read by nothing' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp could not be loaded'; return }
    $po = $byName['PatchOperation']
    if (-not $po) { 'Verse.PatchOperation not found'; return }
    $f = Get-FieldsRecursive $po
    foreach ($n in @('mayRequire','MayRequire')) {
        if ($f.ContainsKey($n)) {
            "PatchOperation now has a field '$n'. The comment in ADSPatch.xml says the attribute is " +
            'inert on an operation, and that is no longer the case.'
        }
    }
    if ($patchDoc -and @($patchDoc.SelectNodes('//Operation[@MayRequire]')).Count -gt 0) {
        'an <Operation> in the patch carries MayRequire, which nothing reads; the guard must be the xpath'
    }
}

It 'the patch guards on a PatchOperationConditional and adds the dalmatian' {
    if (-not $patchDoc) { 'the patch does not parse'; return }
    $ops = @($patchDoc.SelectNodes('/Patch/Operation'))
    if ($ops.Count -ne 1) { "the patch has $($ops.Count) operations, expected 1"; return }
    if ($ops[0].GetAttribute('Class') -ne 'PatchOperationConditional') {
        "the operation is $($ops[0].GetAttribute('Class')), expected PatchOperationConditional"
    }
    if (@($patchDoc.SelectNodes('//nomatch')).Count -gt 0) {
        'the conditional declares a <nomatch>; without A Dog Said 2 that branch would run'
    }
    $added = @($patchDoc.SelectNodes('//match/value/li') | ForEach-Object { $_.InnerText.Trim() })
    if ("$added" -cne 'CCPDalmatian') { "the patch adds [$($added -join ', ')], expected CCPDalmatian alone" }
}

if (-not $adsDoc) {
    ItSkip 'the predicate is a real test and not a tautology' "A Dog Said 2 not found at $AdsRoot"
    ItSkip 'the guard selects nothing when A Dog Said 2 is absent' "A Dog Said 2 not found at $AdsRoot"
    ItSkip 'the dalmatian joins the categories vanilla dogs are already in' "A Dog Said 2 not found at $AdsRoot"
} else {

It 'the predicate is a real test and not a tautology' {
    # A Dog Said 2's category file holds exactly the three defs the patch wants, so run against
    # that file alone both forms select three and the comparison proves nothing. The three are
    # therefore put in a document with strangers beside them - Core's own surgery recipes - which
    # is the situation the patch actually meets, since RimWorld applies patches to one combined
    # document.
    $doc = New-Object System.Xml.XmlDocument
    [void]$doc.AppendChild($doc.CreateElement('Defs'))
    foreach ($n in $adsDoc.SelectNodes('/Defs/RecipeDef')) {
        [void]$doc.DocumentElement.AppendChild($doc.ImportNode($n, $true))
    }
    $strangers = 0
    foreach ($f in Get-ChildItem (Join-Path $GameData 'Core\Defs\RecipeDefs') -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        foreach ($n in $x.SelectNodes('/Defs/RecipeDef')) {
            [void]$doc.DocumentElement.AppendChild($doc.ImportNode($n, $true))
            $strangers++
        }
    }
    if ($strangers -lt 10) { "only $strangers vanilla recipes were gathered; the comparison needs strangers to be worth anything"; return }

    # The predicate the patch ships, minus its trailing step, so that what is counted is the defs
    # it would write into rather than the recipeUsers lists it would find there.
    $xp     = ($patchDoc.SelectSingleNode('//match/xpath')).InnerText
    $pred   = ($xp -replace '/recipeUsers\s*$', '') -replace '\s+', ' '
    $broken = [regex]::Replace($pred, '\[\s*@Name\s*=\s*', '[@Name = ') -replace 'or\s+@Name\s*=\s*', 'or '

    $hit = @($doc.SelectNodes($pred))
    $bad = @($doc.SelectNodes($broken))
    $all = @($doc.SelectNodes('/Defs/RecipeDef'))

    if ($hit.Count -ne 3) { "the patch predicate selects $($hit.Count) of $($all.Count) recipes, expected the 3 ADS_Cat defs" }
    foreach ($n in $hit) {
        if ($n.GetAttribute('Name') -notmatch '^ADS_Cat[123]$') { "the patch predicate also selects $($n.GetAttribute('Name'))" }
    }
    # The old form, run rather than described: in XPath 1.0 a bare non-empty string literal is
    # true, so every branch after the first turns the whole predicate into a constant.
    if ($bad.Count -ne $all.Count) {
        "the XPath 1.0 quirk this port exists to fix no longer reproduces: the broken form " +
        "[$broken] selects $($bad.Count) of $($all.Count), so this test proves nothing"
    }
}

It 'the guard selects nothing when A Dog Said 2 is absent' {
    $xp = ($patchDoc.SelectSingleNode('/Patch/Operation/xpath')).InnerText
    $empty = New-Object System.Xml.XmlDocument
    $empty.LoadXml('<Defs><RecipeDef Name="SomeoneElsesCategory" Abstract="True"><recipeUsers><li>Husky</li></recipeUsers></RecipeDef></Defs>')
    $n = @($empty.SelectNodes($xp))
    if ($n.Count -ne 0) { "the guard xpath selects $($n.Count) nodes in a document with no ADS_Cat1; it would fire without A Dog Said 2" }
    if (@($adsDoc.SelectNodes($xp)).Count -ne 1) { 'the guard xpath does not find ADS_Cat1 in A Dog Said 2 itself' }
}

It 'the dalmatian joins the categories vanilla dogs are already in' {
    $mine = @($patchDoc.SelectNodes('//match/xpath') | ForEach-Object { $_.InnerText }) -join ' '
    foreach ($cat in @('ADS_Cat1','ADS_Cat2','ADS_Cat3')) {
        if ($mine -notmatch [regex]::Escape("@Name=`"$cat`"")) { "the patch does not name $cat" }
        $users = @($adsDoc.SelectNodes("/Defs/RecipeDef[@Name=`"$cat`"]/recipeUsers/li") | ForEach-Object { $_.InnerText.Trim() })
        foreach ($dog in @('Husky','LabradorRetriever','YorkshireTerrier')) {
            if ($users -notcontains $dog) { "A Dog Said 2 no longer puts $dog in $cat; the claim of parity with vanilla's dogs is stale" }
        }
        if ($users -contains 'CCPDalmatian') { "$cat already lists CCPDalmatian; A Dog Said 2 now ships its own patch for this animal" }
    }
}

}

It 'the leather is colder than plain leather by the margin the documents quote' {
    $mine = $leatherNode.SelectSingleNode('statBases/StuffPower_Insulation_Cold')
    if (-not $mine) { 'the dalmatian leather declares no StuffPower_Insulation_Cold'; return }
    $got = [double]$mine.InnerText

    # Leather_Plain declares no statBases of its own: the number comes from LeatherBase, and the
    # documents quote it. Read rather than copied, so a rebalance in a future RimWorld is caught.
    if (-not $thingInfo.ContainsKey('Leather_Plain')) { 'the game has no Leather_Plain'; return }
    $plain = Resolve-Stat $thingInfo['Leather_Plain'] 'StuffPower_Insulation_Cold'
    if ($null -eq $plain) { 'plain leather has no cold insulation anywhere up its parent chain'; return }

    if ($got -ne 14)            { "the dalmatian leather insulates $got, and the documents say 14" }
    if ([double]$plain -ne 16)  { "plain leather now insulates $plain, and the documents say 16" }
    if ($got -ge [double]$plain) { "the dalmatian leather ($got) no longer insulates less than plain leather ($plain)" }
}

It 'the numbers in the documents are the numbers in the defs' {
    $readme = Join-Path $ModRoot 'README.md'
    if (-not (Test-Path $readme)) { 'README.md is missing'; return }
    # -Encoding UTF8 is not optional: on PowerShell 5.1, Get-Content on a file with no BOM reads
    # the system codepage, and every character the prose writes above U+007F arrives as mojibake.
    $text = Get-Content $readme -Raw -Encoding UTF8

    $checks = @(
        @{ Path = 'statBases/MarketValue';       Node = $dogNode; Want = '250';  Say = 'market value 250' },
        @{ Path = 'race/baseBodySize';           Node = $dogNode; Want = '0.70'; Say = 'body size 0.70' },
        @{ Path = 'race/lifeExpectancy';         Node = $dogNode; Want = '12';   Say = 'life expectancy 12' },
        @{ Path = 'race/gestationPeriodDays';    Node = $dogNode; Want = '25';   Say = 'gestation 25 days' },
        @{ Path = 'statBases/ComfyTemperatureMin'; Node = $dogNode; Want = '-30'; Say = 'comfortable to -30' }
    )
    foreach ($c in $checks) {
        $n = $c.Node.SelectSingleNode($c.Path)
        $got = $(if ($n) { $n.InnerText.Trim() } else { '<missing>' })
        if ($got -ne $c.Want) { "the def says $($c.Path) = $got, and the documents say $($c.Say)" }
        # The prose writes a real minus sign, U+2212, where the def writes a hyphen. Normalising
        # both is the difference between a drift check and a typography check.
        # [char]0x2212 and not `u{2212}: the `u escape is PowerShell 6, and this runs on 5.1,
        # where it is a literal backtick-u and the replacement quietly never matches.
        $flat = $text -replace ([regex]::Escape([string][char]0x2212)), '-'
        if ($flat -notmatch [regex]::Escape($c.Want)) { "README.md does not mention $($c.Want) anywhere; it claims $($c.Say)" }
    }
}

# =============================================================================================
Section 'Translations'
# =============================================================================================

$frRoot = Join-Path $modDir 'Languages\French\DefInjected'

It 'the language folders are spelled the way the game spells them' {
    $langs = Join-Path $modDir 'Languages'
    if (-not (Test-Path $langs)) { 'no Languages folder'; return }
    foreach ($d in Get-ChildItem -LiteralPath $langs -Directory) {
        if ($d.Name -cne 'French') { "Languages/$($d.Name) is not spelled the way the game spells it" }
    }
    if (-not (Test-Path $frRoot)) { 'Languages/French/DefInjected is missing'; return }
    foreach ($d in Get-ChildItem -LiteralPath $frRoot -Directory) {
        if (-not $byName.ContainsKey($d.Name)) { "DefInjected/$($d.Name) names no def class"; continue }
        if ($byName[$d.Name].Name -cne $d.Name) {
            "DefInjected/$($d.Name) is miscased; the class is $($byName[$d.Name].Name), and Linux is case sensitive"
        }
    }
}

It 'every French key points at a def this mod defines' {
    if (-not (Test-Path $frRoot)) { 'Languages/French/DefInjected is missing'; return }
    foreach ($f in Get-ChildItem -LiteralPath $frRoot -Recurse -Filter *.xml) {
        $type = Split-Path (Split-Path $f.FullName -Parent) -Leaf
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { "$($f.Name) does not parse"; continue }
        foreach ($k in $x.DocumentElement.ChildNodes) {
            if ($k.NodeType -ne 'Element') { continue }
            $defName = $k.LocalName.Split('.')[0]
            if (-not ($modDefs.ContainsKey($defName) -and $modDefs[$defName] -contains $type)) {
                "$type/$($k.LocalName) -- no $type named $defName in this mod"
            }
        }
    }
}

It 'the puppy life stage is keyed by its label, which is what makes the key hold' {
    if (-not (Test-Path $frRoot)) { 'Languages/French/DefInjected is missing'; return }
    $f = Join-Path $frRoot 'PawnKindDef\Races_Animal_Dalmatian.xml'
    if (-not (Test-Path $f)) { 'the PawnKindDef translation file is missing'; return }
    $x = New-Object System.Xml.XmlDocument
    $x.Load($f)
    $keys = @($x.DocumentElement.ChildNodes | Where-Object { $_.NodeType -eq 'Element' } | ForEach-Object { $_.LocalName })

    # The game keys list elements by their label, slugified, not by index. So the English label is
    # load-bearing: edit it and the French key stops matching, in silence.
    $label = $kindNode.SelectSingleNode('lifeStages/li/label')
    if (-not $label) { 'the PawnKindDef declares no life-stage label'; return }
    $slug   = $label.InnerText.Trim().ToLower() -replace '\s+', '_'
    $prefix = "$($kindNode.defName).lifeStages.$slug."
    $hits   = @($keys | Where-Object { $_.StartsWith($prefix, [StringComparison]::Ordinal) })
    if ($hits.Count -eq 0) {
        "no French key under '$prefix'. The English label is '$($label.InnerText)', and the life-stage " +
        "keys present are [$(($keys | Where-Object { $_ -like '*lifeStages*' }) -join ', ')]"
    }
    if ($hits -notcontains "$($prefix)label") { "no '$($prefix)label'; the singular is the one key the stage cannot do without" }
}

It 'the translation covers the labels and descriptions the mod writes' {
    if (-not (Test-Path $frRoot)) { 'Languages/French/DefInjected is missing'; return }
    $have = @{}
    foreach ($f in Get-ChildItem -LiteralPath $frRoot -Recurse -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        foreach ($k in $x.DocumentElement.ChildNodes) {
            if ($k.NodeType -eq 'Element') { $have[$k.LocalName] = $true }
        }
    }
    foreach ($n in $defNodes) {
        $dn = [string]$n.defName
        foreach ($field in @('label','description')) {
            $node = $n.SelectSingleNode($field)
            if (-not $node) { continue }
            if (-not $have.ContainsKey("$dn.$field")) { "<$($n.LocalName)> $dn writes a $field that French does not translate" }
        }
    }
}

# ---------------------------------------------------------------------------------------------

Write-Output ''
Write-Output ("{0} test(s), {1} failed, {2} skipped" -f $script:ran, $script:failed, $script:skipped)
exit $(if ($script:failed -gt 0) { 1 } else { 0 })
