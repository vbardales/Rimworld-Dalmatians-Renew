# Changelog

All notable changes to this mod are documented here.

## [1.0.0] — 2026-09-05

First release. Port of cucumpear's and lavie2k's **Dalmatians** to RimWorld 1.6.

### Fixed

- `CCPDalmatian`: `<wildness>0</wildness>` under `<race>` replaced by `<Wildness>0</Wildness>`
  under `<statBases>`. Wildness stopped being a field of `RaceProperties` and became a `StatDef`;
  the old element matches no field, so the loader logged one line and carried on with it unset.
  The practical damage here is limited — the stat's `defaultBaseValue` is `-1`, its `minValue` is
  `0` and `StatWorker` clamps, so the animal still evaluated to the 0 it wanted — but the line
  vanished from its information card (`showIfUndefined` is false), and any animal in the same
  position with a non-zero wildness would silently have become as tame as a rat.
- `Patches/ADSPatch.xml`: rewritten to target A Dog Said 2. The patch named the abstract recipes
  *A Dog Said... Animal Prosthetics* used up to 2023 — `OldWoundsAnimal`,
  `InstallSimpleProstheticLegAnimal` and a dozen more. **A Dog Said... Animal Prosthetics 2**
  (`SamBucher.ADogSaidAnimalProsthetics2`, which declares 1.6) defines none of them; it groups
  animals into `ADS_Cat1`, `ADS_Cat2` and `ADS_Cat3`. The leading `PatchOperationTest` therefore
  failed, the sequence stopped, and `<success>Always</success>` kept it silent: the dalmatian had
  no animal surgeries at all, and nothing said so. It is now added to the three categories, where
  vanilla's husky, labrador and yorkshire terrier already are.
- `Patches/ADSPatch.xml`: the patch was reaching the categories too late to matter. The `ADS_Cat`
  defs are abstract and nothing inherits from them; A Dog Said 2's own final patch,
  `z_Category_Patches.xml`, copies their `recipeUsers` onto the real surgery bases with
  `PatchOperationAddOrMergeCopy`, taking each list as it stands at that moment. Cross-mod patch
  order is mod load order — checked against the 1.6 assembly, where
  `Verse.LoadedModManager.ApplyPatches` is a `SelectMany` over the running mods followed by
  `PatchOperation.Apply` — so an addition made by a mod loaded after A Dog Said 2 goes into a list
  nothing reads. `<loadBefore>SamBucher.ADogSaidAnimalProsthetics2</loadBefore>` is now declared.
- `Patches/ADSPatch.xml`: the XPath predicate `[@Name = "A" or "B" or "C"]` corrected to
  `[@Name="A" or @Name="B" or @Name="C"]`. The original is not the test it looks like — in XPath
  `or` converts its operands to booleans and a non-empty string literal is `true`, so the
  predicate matched **every** `RecipeDef` in the document. Had the old recipe names still
  existed, the dalmatian would have been added to the `recipeUsers` of every recipe in the game
  and in every mod loaded. The broken guard is what kept this from ever firing.

### Removed

- `About/ModIcon.png` as a 52×52 crop of the mod's own south-facing sprite scaled to 128 px, and
  `About/Preview.png` as cucumpear's and lavie2k's in-game screenshot. Art taken from the source
  makes the upstream author's work carry the port's identity, and those two files are the ones a
  port is supposed to speak for itself with. Both were replaced on 2026-09-11 by pictures made for
  this port, listed under Added. `Art/Make-ModIcon.ps1` is kept.

### Changed

- `Patches/ADSPatch.xml`: the guard is now a `PatchOperationConditional` on `ADS_Cat1`, replacing
  the `PatchOperationSequence` + `PatchOperationTest` + `<success>Always</success>` form. That form
  was valid and was kept on purpose at first — the survey tool that flagged it only recognises
  `PatchOperationFindMod` — but the conditional does the same test in one operation instead of
  three, and needs no `Always` to stay quiet: its `xpath` selecting nothing, with no `<nomatch>`
  declared, is already a success. Same guard as the sibling Pomeranian - A Dog Said Patch.

  In between, this was `MayRequire="SamBucher.ADogSaidAnimalProsthetics2"` on the operation, which
  is **inert** and never shipped. `Verse.PatchOperation` has no such field, and
  `ModContentPack.LoadPatches`, which builds each operation, never reads the attribute, so the add
  would have applied with or without A Dog Said 2. `DirectXmlToObject.ObjectFromXml` does load the
  literal, at IL offsets 1440/1459 of a 1700-byte method, immediately before
  `RegisterObjectWantsCrossRef` at 1525 — the def-reference-in-a-field path, not the root node. The
  attribute is honoured on a def node, on a `<li>` and on any field element, which is why the wrong
  form reads as correct; A Dog Said 2 uses it properly on the `<li>`s of those very lists.
- `packageId` changed from `cucumpear.dalmatians` to `nelim.dalmatiansrenew`.
  `<incompatibleWith>` keeps cucumpear's and lavie2k's, which is what that field is for: the two
  mods define the same animal, and only one of them may.
- `<name>` changed from `Dalmatians` to `Dalmatians Renew`. Nothing was ever published under the
  earlier form of the name, which said 1.6 where the repository said Renew, so this replaces it
  rather than succeeding it. The directory and the `packageId` follow the displayed name.
- `<supportedVersions>` set to 1.6.
- `About/PublishedFileId.txt` dropped: it names cucumpear's and lavie2k's Workshop item.

### Added

- `<animalType>Canine</animalType>` on `CCPDalmatian`. The field did not exist when this mod was
  written, and every dog vanilla ships declares it. It does close to nothing today —
  `Verse.AnimalType` has one consumer in the 1.6 assembly,
  `TraitDef.disableHostilityFromAnimalType`, which no vanilla trait sets — but it is free, and it
  puts this dog where the other dogs are.
- `Languages/French/`, 16 keys, including `stuffProps.stuffAdjective` on the leather, which the
  English def does not declare and does not need.
- `<incompatibleWith>cucumpear.dalmatians</incompatibleWith>`: the `defName`s are unchanged, so
  the two mods cannot load together.
- `About/Preview.png` and `About/ModIcon.png`, made for this port on 2026-09-11 and replacing the
  showcase and the icon that came from the source mod. The showcase is a dalmatian asleep in a
  lamp pool, drawn to the collection's own showcase rules; the icon is the collection's mascot
  wearing the dog's markings. Full-resolution sources under `Art/`, which the mod does not ship.

### Unchanged

- Every stat, tool, litter curve, life stage, draw size, sound and trade tag, the leather's
  colour and insulation, and the four textures.
- The two `defName`s — `CCPDalmatian` and `Leather_Dalmatian` — so a save moves between the two
  mods without losing a dog. Checked against Core, every DLC, all 10 353 subscribed Workshop mods
  and every other mod I maintain: nothing else defines either.
- The dessicated corpse still ships only its east texture. `Graphic_Multi` rotates that one for
  the other facings, as it has since 2018; supplying the missing two would be drawing art rather
  than porting a mod.
