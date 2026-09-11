# Dalmatians — attribution

A 1.6 port of **Dalmatians**, by **cucumpear** and **lavie2k**
([1513691963](https://steamcommunity.com/sharedfiles/filedetails/?id=1513691963)).

## Status: public

The source mod is **dead** — it declares 1.0 through 1.4 and nothing further — and **no licence
is declared anywhere**, checked at the four places one could be: no `LICENSE` file in the mod,
no mention in its `About.xml`, no linked repository (`<url>` is absent entirely), and nothing in
the body of the description on its Steam page. That last check is the one that matters: it is
the one that was skipped once on たたら製鉄, whose ban on redistribution turned out to be a
sentence in its description and nowhere else.

This is the usual convention for ports on the RimWorld Workshop: republished with **credit by
name** and **removal on request, without argument**. The `<author>` field reads
`cucumpear, lavie2k - 1.6 port: nelim`, and the removal clause is in the description.

## Where it came from

This mod was inside **Nelim's Animal Ark**, the private pack of abandoned animal mods, from
2026-08-30 until 2026-09-05. It came out because dead-and-unlicensed is now a reason to publish
rather than to keep back. The pack no longer ships it; the two cannot both be installed, since
they define the same `CCPDalmatian`.

## What was carried over

Everything the mod defined — three defs, four textures and one patch. No C#, no dependency, no
DLC, no research.

| def | type | what it is |
|---|---|---|
| `CCPDalmatian` | `ThingDef` | the animal, on `AnimalThingBase` |
| `CCPDalmatian` | `PawnKindDef` | its spawn entry, on `AnimalKindBase` |
| `Leather_Dalmatian` | `ThingDef` | its leather, on `LeatherBase` |

Its stats, tools, litter curve, life stages, sounds, trade tags and draw sizes are cucumpear's
and lavie2k's, unchanged. So are the four textures, byte for byte, and `About/Preview.png`,
which is their own in-game showcase.

**The mod ships no `About/ModIcon.png`.** One existed for a few days: a 52×52 square of their own
south-facing sprite, scaled to 128 px, because the full 44×93 sprite reads as a thin vertical
smudge at the ~32 px the mod list actually draws.

It was removed on 2026-09-11. An icon cut from the source mod's art makes the upstream author's
work carry the port's identity, and the icon is the one file of a port that is supposed to speak
for the port rather than for the mod it carries. RimWorld loads a mod that has none.
`Art/Make-ModIcon.ps1` is kept: the script is port work and falls under the MIT grant, the art it
crops does not.

## What changed in the port

**One real breakage, and it is the one this repository has hit before.** The def declared
`<wildness>0</wildness>` inside `<race>`. Wildness stopped being a field of `RaceProperties` and
became a `StatDef`; that element now matches no field, and RimWorld does not stop for an element
that matches no field — it logs one line and carries on with the field unset.

Here the damage is smaller than usual, and saying otherwise would overstate it: the `Wildness`
stat's `defaultBaseValue` is `-1` (Core's own comment: *"so we can catch missing wildness stats
on animals"*), its `minValue` is `0`, and `StatWorker` clamps. A dalmatian left in the old form
therefore still evaluates to 0 — which is exactly the value it was asking for. What is actually
lost is the information card: `Wildness` declares `showIfUndefined` false, so the line simply
disappears from the animal's stats. The reason to fix it anyway is that *any other* animal in
this position, with a wildness that was not zero, silently becomes as tame as a rat. It is now
`<Wildness>0</Wildness>` under `statBases`, written the way vanilla's own dogs write it.

**The A Dog Said patch had two separate faults**, and the second hid the first.

The names it targeted are gone. `Patches/ADSPatch.xml` added the dalmatian to the `recipeUsers`
of `OldWoundsAnimal`, `InstallPegLegAnimal`, `InstallBionicEyeAnimal` and a dozen more — the
abstract recipe names *A Dog Said... Animal Prosthetics* used up to 2023. **A Dog Said... Animal
Prosthetics 2** (`SamBucher.ADogSaidAnimalProsthetics2`), which declares 1.4, 1.5 and 1.6,
defines none of them: it groups animals into three abstract parents instead, `ADS_Cat1` (basic
replacements), `ADS_Cat2` (+ simple prosthetics) and `ADS_Cat3` (+ bionics). The patch's leading
`PatchOperationTest` therefore failed, the sequence stopped, and `<success>Always</success>` kept
that from being reported — no prosthetics for the dalmatian, and no error to say so.

That guard is not the fault, and it was worth checking rather than assuming: a survey tool
flagged this patch as unguarded because it only recognises `PatchOperationFindMod`. The
`PatchOperationSequence` + `PatchOperationTest` idiom is the other valid form and it was doing its
job. It is now a `PatchOperationConditional` on `ADS_Cat1` — the same test in one operation instead
of three, with no `<success>Always</success>` needed to keep it quiet, since a `Conditional` whose
`xpath` selects nothing and which declares no `<nomatch>` simply reports success.

**Between the two it was `MayRequire="SamBucher.ADogSaidAnimalProsthetics2"` on the operation, and
that form is inert.** Recorded because the wrong form cannot be told from the right one by eye.
`Verse.PatchOperation` has three fields — `sourceFile`, `neverSucceeded`, `success` — and no
`mayRequire`; `ModContentPack.LoadPatches`, which builds each operation, never reads the attribute.
`DirectXmlToObject.ObjectFromXml` does load the literal, which is what makes the inference tempting,
but at IL offsets 1440 and 1459 of a 1700-byte method, immediately before the
`RegisterObjectWantsCrossRef` call at 1525 — the path for a def reference **inside a field**, not the
root node. So the add would have applied whether A Dog Said 2 was loaded or not.

The attribute is honoured on a def node, on every `<li>`, and on any ordinary field element. A Dog
Said 2 uses it correctly in that last sense, on the `<li>`s inside its category lists
(`MayRequire="ludeon.rimworld.odyssey"`); copying it up onto the `<Operation>` is the mistake, and
live 1.6 mods make it. The sibling port, Pomeranian - A Dog Said Patch, carries the same corrected
guard.

The second fault is in the XPath, and it never had a chance to show because the guard stopped the
sequence first. The predicate was written:

    /Defs/RecipeDef[@Name = "OldWoundsAnimal" or "InstallPowerClawAnimal" or ... ]/recipeUsers

That is not the test it looks like. In XPath, `or` converts each operand to a boolean, and a
non-empty string literal is `true` — so the predicate is `true` for **every** `RecipeDef` in the
document, whatever its name. Had the old names still existed, the operation would have added
`CCPDalmatian` to the `recipeUsers` of every recipe in the game and in every mod loaded. Each
name is now compared properly, `@Name="..." or @Name="..."`, which is also the form A Dog Said
2's own compatibility patches use.

The dalmatian is added to all three categories, which is where vanilla's `Husky`,
`LabradorRetriever` and `YorkshireTerrier` already are. A Dog Said 2 states the rule in the tooltip
of its own settings — category 3 is *pack animals and trainable pets* — and the lists are
cumulative, so a category-3 animal appears in all of them.

**A third fault, found later: the patch was arriving too late to matter.** The `ADS_Cat` defs are
abstract and nothing inherits from them. What connects them to real recipes is A Dog Said 2's own
final patch, `1.6/Patches/z_Category_Patches.xml` — named `z_` so it sorts after every one of its
`ModCompat` files — which copies each category's `recipeUsers` onto `SurgeryInstallMedievalBodyPartAnimalBase`,
`SurgeryInstallSimpleProstheticBodyPartAnimalBase`, `SurgeryInstallBionicBodyPartAnimalBase` and
`SurgeryInstallMiscBodyPartAnimalBase` with `PatchOperationAddOrMergeCopy`, taking each list as it
stands at that moment. A Dog Said 2's own compat files are safe because they live inside it, where
file-name order settles the question. An outside mod is not: cross-mod patch order is mod load
order, checked against the 1.6 assembly rather than assumed —
`Verse.LoadedModManager.ApplyPatches` is a `SelectMany` over the running mods followed by
`PatchOperation.Apply`. `<loadBefore>SamBucher.ADogSaidAnimalProsthetics2</loadBefore>` is now
declared in `About.xml`.

**One field was added.** `<animalType>Canine</animalType>`, which did not exist when this mod was
written. Six defs in the game declare it — `Husky`, `LabradorRetriever`, `YorkshireTerrier`,
`Warg`, Odyssey's `BogHound`, and `ThingBaseWolf`, the abstract base the wolves share — so every
dog-shaped animal vanilla ships is a `Canine` and this one should be too. It is honest to say
what it does today, which is close to nothing: `Verse.AnimalType` has three values (`None`,
`Canine`, `Dryad`) and exactly one consumer in the 1.6 assembly,
`TraitDef.disableHostilityFromAnimalType`, which no vanilla trait sets. It is a hook for mods.
Declaring it costs nothing and puts the dalmatian in the same bucket as the other dogs for
anything that ever reads it.

**French was added**: 16 keys, checked against the same rules the game's own injector applies.
The plural and the puppy stage follow vanilla's husky exactly, including the handle
`lifeStages.dalmatian_puppy` — the game keys list elements by their label, not their index. The
leather is *fourrure de dalmatien*, because that is how the game already names dog leather in
French (`Leather_Dog` is *fourrure de chien*), and it gets a `stuffProps.stuffAdjective` the
English def does not need: English falls back to the label and reads correctly, French does not.

## What did not change

Every stat, every tool, the litter curve, the life stages and their draw sizes, the sounds, the
trade tags, the leather's colour and insulation — and the two `defName`s, so a save moves between
the two mods without losing a dog. The original is declared in `<incompatibleWith>`.

**The defNames were checked rather than assumed**, and `Leather_Dalmatian` is exactly the kind of
name that collides — no author prefix, and every animal mod that adds a dog wants it:

- **Core and every DLC** — nothing.
- **Every subscribed Workshop mod**, 10 353 of them. The only files in all of them that name
  `CCPDalmatian` or `Leather_Dalmatian` are the source mod's own three.
- **This repository** — nothing, once the Animal Ark copy was removed.

No collision, so no rename. That is the right way round to decide it: a rename is permanent in a
way a port is not, and it would take every dalmatian already tamed out of every existing save.

## One upstream gap, left alone

The dessicated corpse ships **one** texture, `Dessicated_Dalmatian_east.png`. There is no
`_north` and no `_south`. `Graphic_Multi` does not fail on this — with only the east face it
builds the north by rotating that one, and derives the rest from it — so a long-dead dalmatian is
drawn from the side whichever way it is lying. It has been that way since 2018.

Fixing it would mean drawing two textures, which is making art rather than porting a mod. It is
recorded here instead.

## What was dropped from the published folder

`About/PublishedFileId.txt`, for the obvious reason: it names cucumpear's and lavie2k's Workshop
item.

## Adoption

If I do not answer within a reasonable time after being contacted, anyone may freely update this
or any other of my mods, including publishing a continuation of it. All credit must be preserved.
