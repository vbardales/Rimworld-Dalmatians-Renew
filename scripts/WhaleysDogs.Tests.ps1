# Runs inside Run-Tests.ps1. Uses the actual installed Verse patch implementations,
# not a reimplementation of XPath patch semantics. Never writes to installed mods.
Section 'Optional WhaleysDogs integration'
# Unity profiler startup is not available in the offline test process.
$byName['DeepProfiler'].GetField('enabled').SetValue($null, $false)
$compatRoot = Join-Path $modDir 'Compatibility\WhaleysDogs'
$compat = New-Object System.Xml.XmlDocument
$compat.Load((Join-Path $compatRoot 'Patches\WhaleysDogs.xml'))

function New-VerseOperation($node) {
    $type = $byName[$node.GetAttribute('Class')]
    if (-not $type) { throw "Unknown patch class $($node.GetAttribute('Class'))" }
    $instance = [Activator]::CreateInstance($type)
    $fields = Get-FieldsRecursive $type
    foreach ($child in $node.ChildNodes) {
        if ($child.NodeType -ne 'Element') { continue }
        $field = $fields[$child.LocalName]
        if (-not $field) { throw "Unknown field $($child.LocalName) on $type" }
        switch ($child.LocalName) {
            'xpath' { $field.SetValue($instance, $child.InnerText) }
            'value' {
                $container = [Activator]::CreateInstance($byName['XmlContainer'])
                $container.node = $child
                $field.SetValue($instance, $container)
            }
            'operations' {
                $list = [Activator]::CreateInstance($field.FieldType)
                foreach ($operation in $child.SelectNodes('li')) { $list.Add((New-VerseOperation $operation)) }
                $field.SetValue($instance, $list)
            }
            default { $field.SetValue($instance, (New-VerseOperation $child)) }
        }
    }
    return $instance
}
function Apply-Compat($xml) {
    $operation = New-VerseOperation $compat.Patch.Operation
    try { if (-not $operation.Apply($xml)) { throw 'WhaleysDogs patch failed' } } catch { throw $_.Exception.InnerException.ToString() }
}
function New-CompatFixture([bool]$withWhaleys, [bool]$withAds) {
    $xml = New-Object System.Xml.XmlDocument
    $xml.LoadXml('<Defs/>')
    foreach ($node in $defNodes) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($node,$true)) }
    if ($withWhaleys) {
        $wd = New-Object System.Xml.XmlDocument
        $wd.Load((Join-Path $WhaleysRoot '1.6\Defs\ThingDefs_Races\Races_Animal_dalmatian.xml'))
        foreach ($node in $wd.SelectNodes('/Defs/*')) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($node,$true)) }
    }
    if ($withAds) {
        if (-not $adsDoc) { throw 'Installed ADS categories are required for this fixture' }
        foreach ($node in $adsDoc.SelectNodes('/Defs/*')) { [void]$xml.DocumentElement.AppendChild($xml.ImportNode($node,$true)) }
    }
    return ,$xml
}

It 'WhaleysDogs files are optional and load after WhaleysDogs, before ADS 2' {
    [xml]$folders = Get-Content -Raw (Join-Path $modDir 'LoadFolders.xml')
    $entries = @($folders.loadFolders.'v1.6'.li)
    if ($entries.Count -ne 2 -or $entries[0] -ne '/') { 'Unexpected default load roots' }
    if ($entries[1].InnerText -ne 'Compatibility/WhaleysDogs' -or $entries[1].IfModActive -cne 'Mlie.WhaleysDogs') { 'Optional root must require the exact WhaleysDogs package' }
    if (@($aboutDoc.ModMetaData.loadAfter.li) -notcontains 'Mlie.WhaleysDogs') { 'Missing WhaleysDogs loadAfter' }
    if (@($aboutDoc.ModMetaData.loadBefore.li) -notcontains 'SamBucher.ADogSaidAnimalProsthetics2') { 'Missing ADS loadBefore' }
}
It 'the optional patch is inert without the canonical dalmatian' {
    $xml = New-CompatFixture $false $false
    $before = $xml.OuterXml
    Apply-Compat $xml
    if ($xml.OuterXml -cne $before) { 'Standalone data changed' }
}

if (-not (Test-Path (Join-Path $WhaleysRoot '1.6\Defs\ThingDefs_Races\Races_Animal_dalmatian.xml'))) {
    ItSkip 'WhaleysDogs data integration' 'WhaleysDogs 1.6 not installed; supply -WhaleysRoot'
    return
}
It 'both saved identities survive and WhaleysDogs balance is preserved' {
    $xml = New-CompatFixture $true $false
    $wdPath = '/Defs/ThingDef[defName="WD_Dalmatian"]'
    $before = $xml.SelectSingleNode($wdPath).CloneNode($true)
    Apply-Compat $xml
    $after = $xml.SelectSingleNode($wdPath).CloneNode($true)
    foreach ($node in @($before,$after)) {
        foreach ($allowed in @('race/leatherDef','race/animalType')) {
            $field = $node.SelectSingleNode($allowed)
            if ($field) { [void]$field.ParentNode.RemoveChild($field) }
        }
    }
    if ($before.OuterXml -cne $after.OuterXml) { 'Unexpected WhaleysDogs balance edit' }
    foreach ($name in @('CCPDalmatian','WD_Dalmatian')) {
        foreach ($type in @('ThingDef','PawnKindDef')) {
            if ($xml.SelectNodes("/Defs/$type[defName='$name']").Count -ne 1) { "Missing or duplicate $type/$name" }
        }
        if ($xml.SelectSingleNode("/Defs/PawnKindDef[defName='$name']/race").InnerText -ne $name) { "Saved kind/race identity changed for $name" }
    }
    if ($xml.SelectSingleNode($wdPath+'/race/leatherDef').InnerText -ne 'Leather_Dalmatian') { 'Dedicated leather missing' }
}
It 'legacy dogs stop ordinary random recruitment but remain sellable' {
    $xml = New-CompatFixture $true $false
    Apply-Compat $xml
    $p = '/Defs/ThingDef[defName="CCPDalmatian"]'
    if ($xml.SelectSingleNode($p+'/tradeability').InnerText -ne 'Sellable') { 'Legacy traders must buy, not spawn, these dogs' }
    if ($xml.SelectSingleNode($p+'/race/petness').InnerText -ne '0') { 'Legacy kind still enters random starting-pet pool' }
    if ($xml.SelectNodes($p+'/race/wildBiomes/*').Count -ne 0) { 'Legacy wild spawn entries remain' }
    foreach ($flag in @('canArriveManhunter','canBeScattered','appearsRandomlyInCombatGroups')) {
        if ($xml.SelectSingleNode('/Defs/PawnKindDef[defName="CCPDalmatian"]/'+$flag).InnerText -ne 'false') { "Legacy $flag remains enabled" }
    }
    if ($xml.SelectSingleNode($p+'/race/trainability').InnerText -ne 'Advanced') { 'Legacy training changed' }
}
It 'native coat variant preserves WhaleysDogs graphics and is idempotent' {
    $xml = New-CompatFixture $true $false
    $p = '/Defs/PawnKindDef[defName="WD_Dalmatian"]'
    $stages = $xml.SelectSingleNode($p+'/lifeStages').OuterXml
    Apply-Compat $xml
    if ($xml.SelectSingleNode($p+'/lifeStages').OuterXml -cne $stages) { 'Original or corpse graphics changed' }
    if ($xml.SelectSingleNode($p+'/alternateGraphicChance').InnerText -ne '0.5') { 'Expected 50 percent alternate coat chance' }
    $before = $xml.OuterXml
    Apply-Compat $xml
    if ($xml.OuterXml -cne $before) { 'Repeated patch changes data or duplicates a variant' }
    $variant = $xml.SelectSingleNode($p+'/alternateGraphics/li')
    if ($variant.texPath -ne 'Things/Pawn/Animal/Dalmatian/Dalmatian') { 'Wrong coat path' }
    foreach ($dir in @('east','north','south')) {
        if (-not (Test-Path (Join-Path $modDir "Textures/$($variant.texPath)_$dir.png"))) { "Missing $dir variant texture" }
    }
}
It 'existing third-party coat variants are retained' {
    $xml = New-CompatFixture $true $false
    $node=$xml.SelectSingleNode('/Defs/PawnKindDef[defName="WD_Dalmatian"]')
    $fragment=$xml.CreateDocumentFragment()
    $fragment.InnerXml='<alternateGraphicChance>0.8</alternateGraphicChance><alternateGraphics><li><texPath>Other/Coat</texPath><weight>2</weight></li></alternateGraphics>'
    [void]$node.AppendChild($fragment)
    Apply-Compat $xml
    if ($node.alternateGraphicChance -ne '0.8' -or $node.SelectNodes('alternateGraphics/li').Count -ne 2 -or $node.SelectSingleNode('alternateGraphics/li[1]/texPath').InnerText -ne 'Other/Coat') { 'Third-party variation was overwritten' }
}
if ($adsDoc) {
    It 'ADS categories include both saved races once, without touching unrelated recipes' {
        $xml = New-CompatFixture $true $true
        $unrelated=$xml.CreateDocumentFragment(); $unrelated.InnerXml='<RecipeDef Name="Unrelated"><recipeUsers><li>Husky</li></recipeUsers></RecipeDef>'
        [void]$xml.DocumentElement.AppendChild($unrelated)
        $baseOp=New-VerseOperation $patchDoc.Patch.Operation
        if (-not $baseOp.Apply($xml)) { 'Base ADS patch failed'; return }
        Apply-Compat $xml; Apply-Compat $xml
        foreach ($cat in @('ADS_Cat1','ADS_Cat2','ADS_Cat3')) {
            foreach ($dog in @('CCPDalmatian','WD_Dalmatian')) {
                if ($xml.SelectNodes("/Defs/RecipeDef[@Name='$cat']/recipeUsers/li[text()='$dog']").Count -ne 1) { "Wrong count: $cat/$dog" }
            }
        }
        if ($xml.SelectSingleNode('/Defs/RecipeDef[@Name="Unrelated"]/recipeUsers').InnerText -ne 'Husky') { 'Unrelated recipe changed' }
    }
} else { ItSkip 'WhaleysDogs plus ADS' 'ADS 2 not installed' }
It 'patched defs and alternate-graphic fields exist in RimWorld 1.6' {
    $xml = New-CompatFixture $true $false
    Apply-Compat $xml
    $script:fieldProblems.Clear()
    foreach ($node in $xml.SelectNodes('/Defs/*')) { Walk $node $byName[$node.LocalName] $node.defName }
    $script:fieldProblems
}
It 'conditional French keys resolve against the WhaleysDogs defs' {
    $xml = New-CompatFixture $true $false
    foreach ($file in Get-ChildItem (Join-Path $compatRoot 'Languages/French/DefInjected') -Recurse -Filter *.xml) {
        [xml]$lang=Get-Content -Raw $file.FullName
        $type=$file.Directory.Name
        foreach ($key in $lang.SelectNodes('/LanguageData/*')) {
            $parts=$key.LocalName.Split('.')
            $node=$xml.SelectSingleNode("/Defs/$type[defName='$($parts[0])']")
            for($i=1;$i -lt $parts.Count;$i++) {
                $part=$parts[$i]
                if ($part -match '^\d+$') { $node=$node.SelectSingleNode('li['+([int]$part+1)+']') }
                else {
                    $next=$node.SelectSingleNode($part)
                    if (-not $next) {
                        $next = @($node.SelectNodes('li') | Where-Object {
                            $_.label -and (($_.label -replace ' ', '_') -ceq $part)
                        }) | Select-Object -First 1
                    }
                    if (-not $next -and $i -eq $parts.Count-1 -and (Get-FieldsRecursive $byName[$type]).ContainsKey($part)) { break }
                    $node=$next
                }
                if (-not $node) { "Unresolved translation $($key.LocalName)"; break }
            }
        }
    }
}
