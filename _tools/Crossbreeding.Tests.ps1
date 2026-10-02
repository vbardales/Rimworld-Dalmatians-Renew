# Runs inside Run-Tests.ps1, after WhaleysDogs.Tests.ps1 (uses New-VerseOperation and $defNodes).
# The two crossing patches are applied with the game's own patch classes to a fixture of the mod's defs
# plus vanilla's three domestic dogs. PatchOperationFindMod cannot run offline (no ModLister), so the
# patch inside its <match> is what gets applied, and the guard is tested for what it names.
Section 'Optional crossing patches (Dogs mate, Better Crossbreeding)'
$dogs = @('Husky','LabradorRetriever','YorkshireTerrier')
$workshop = Split-Path -Parent $WhaleysRoot
$dogsMateDefs = Join-Path $workshop '2441132298\1.6\Defs\CompatibleSpecies\Canidae.xml'

function New-CrossFixture([bool]$withDogsMate) {
    $xml = New-Object System.Xml.XmlDocument
    $xml.LoadXml('<Defs/>')
    foreach ($node in $defNodes) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($node,$true)) }
    foreach ($f in Get-ChildItem (Join-Path $GameData 'Core\Defs') -Recurse -Filter *.xml) {
        if (-not (Select-String -LiteralPath $f.FullName -Pattern '<defName>(Husky|LabradorRetriever|YorkshireTerrier)</defName>' -Quiet)) { continue }
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        foreach ($n in $x.SelectNodes('/Defs/ThingDef | /Defs/PawnKindDef')) {
            if ($dogs -contains [string]$n.defName) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($n,$true)) }
        }
    }
    if ($withDogsMate) {
        $d = New-Object System.Xml.XmlDocument; $d.Load($dogsMateDefs)
        foreach ($n in $d.SelectNodes('/Defs/*')) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($n,$true)) }
    }
    return ,$xml
}
function Apply-Patch([string]$file, $xml, [bool]$unwrapFindMod) {
    $doc = New-Object System.Xml.XmlDocument; $doc.Load((Join-Path $modDir "Patches\$file"))
    $op = $doc.Patch.Operation
    if ($unwrapFindMod) { $op = $op.SelectSingleNode('match') }
    $inst = New-VerseOperation $op
    try { if (-not $inst.Apply($xml)) { throw "$file failed" } } catch { throw $_.Exception.InnerException.ToString() }
}

It 'both crossing patches are present and well formed' {
    foreach ($f in 'Compat_DogsMate.xml','Compat_BetterCrossbreeding.xml') {
        $p = Join-Path $modDir "Patches\$f"
        if (-not (Test-Path $p)) { "$f is missing"; continue }
        try { $d = New-Object System.Xml.XmlDocument; $d.Load($p) } catch { "$f does not parse" }
    }
}

if (-not (Test-Path $dogsMateDefs)) {
    ItSkip 'Dogs mate patch' 'Dogs mate (Mlie.DogsMate, 2441132298) not installed'
} else {
    It 'Dogs mate: the dalmatian joins the Dog group once, beside the vanilla dogs' {
        $xml = New-CrossFixture $true
        Apply-Patch 'Compat_DogsMate.xml' $xml $false
        Apply-Patch 'Compat_DogsMate.xml' $xml $false | Out-Null
        $li = @($xml.SelectNodes('/Defs/Revolus.DogsMate.AnimalGroupDef[defName="Dog"]/pawnKinds/li') | ForEach-Object { $_.InnerText })
        foreach ($d in $dogs) { if ($li -notcontains $d) { "vanilla $d left the group" } }
        if (@($li | Where-Object { $_ -eq 'CCPDalmatian' }).Count -lt 1) { 'the dalmatian did not join' }
        if (@($xml.SelectNodes('/Defs/Revolus.DogsMate.AnimalGroupDef[defName="Fox"]/pawnKinds/li[text()="CCPDalmatian"]')).Count -ne 0) { 'the dalmatian joined another group' }
    }
    It 'Dogs mate: the patch is silent without the mod' {
        $xml = New-CrossFixture $false
        $before = $xml.OuterXml
        Apply-Patch 'Compat_DogsMate.xml' $xml $false
        if ($xml.OuterXml -cne $before) { 'the patch changed a document with no Dogs mate group' }
    }
}

It 'Better Crossbreeding: every pair has the list on the male and the extension on the mother, both ways' {
    $xml = New-CrossFixture $false
    Apply-Patch 'Compat_BetterCrossbreeding.xml' $xml $true
    $before = $xml.OuterXml
    foreach ($d in $dogs) {
        $mine = @($xml.SelectNodes('/Defs/ThingDef[defName="CCPDalmatian"]/race/canCrossBreedWith/li') | ForEach-Object { $_.InnerText })
        if ($mine -notcontains $d) { "the dalmatian does not seek $d" }
        $theirs = @($xml.SelectNodes("/Defs/ThingDef[defName='$d']/race/canCrossBreedWith/li") | ForEach-Object { $_.InnerText })
        if ($theirs -notcontains 'CCPDalmatian') { "$d does not seek the dalmatian" }
        if (@($xml.SelectNodes("/Defs/ThingDef[defName='$d']/race/canCrossBreedWith")).Count -ne 1) { "$d has more than one canCrossBreedWith" }
        if (@($xml.SelectNodes("/Defs/PawnKindDef[defName='CCPDalmatian']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']/outcomes/$d/Random")).Count -ne 1) { "no Random outcome for dalmatian mother by $d" }
        if (@($xml.SelectNodes("/Defs/PawnKindDef[defName='$d']/modExtensions/li[@Class='DZY.CrossBreeding.Extension']/outcomes/CCPDalmatian/Random")).Count -ne 1) { "no Random outcome for $d mother by the dalmatian" }
    }
    if (@($xml.SelectNodes('/Defs/PawnKindDef[defName="CCPDalmatian"]/modExtensions/li[@Class="DZY.CrossBreeding.Extension"]')).Count -ne 1) { 'more than one extension on the dalmatian' }
}
It 'Better Crossbreeding: a list another mod already made is appended to, not replaced' {
    $xml = New-CrossFixture $false
    $race = $xml.SelectSingleNode('/Defs/ThingDef[defName="Husky"]/race')
    $frag = $xml.CreateDocumentFragment(); $frag.InnerXml = '<canCrossBreedWith><li>Wolf_Timber</li></canCrossBreedWith>'
    [void]$race.AppendChild($frag)
    Apply-Patch 'Compat_BetterCrossbreeding.xml' $xml $true
    $li = @($xml.SelectNodes('/Defs/ThingDef[defName="Husky"]/race/canCrossBreedWith/li') | ForEach-Object { $_.InnerText })
    if ($li -notcontains 'Wolf_Timber' -or $li -notcontains 'CCPDalmatian') { "the husky list is [$($li -join ',')]" }
}
It 'Better Crossbreeding: applying twice does not duplicate the extension' {
    $xml = New-CrossFixture $false
    Apply-Patch 'Compat_BetterCrossbreeding.xml' $xml $true
    Apply-Patch 'Compat_BetterCrossbreeding.xml' $xml $true
    if (@($xml.SelectNodes('/Defs/PawnKindDef[defName="Husky"]/modExtensions/li[@Class="DZY.CrossBreeding.Extension"]')).Count -ne 1) { 'the husky got two extensions' }
}
It 'Better Crossbreeding: the guard names the mod and the class spelling is the assembly''s' {
    $d = New-Object System.Xml.XmlDocument; $d.Load((Join-Path $modDir 'Patches\Compat_BetterCrossbreeding.xml'))
    if ($d.Patch.Operation.Class -ne 'PatchOperationFindMod' -or $d.Patch.Operation.mods.li -ne 'Better Crossbreeding') { 'the patch is not guarded by the Better Crossbreeding display name' }
    if (@($d.SelectNodes('//@Class') | Where-Object { $_.Value -cmatch 'DZY\.Crossbreeding' }).Count -gt 0) { 'the patch spells the class as the mod''s Example does, a type that does not exist' }
}
