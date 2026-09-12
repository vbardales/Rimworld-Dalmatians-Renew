# Test scenarios

Three defs, four textures, one patch, no assembly. There is very little here to break, and the two
things that were broken in the 1.4 version both broke **silently**. That is the whole reason this
mod needs the game rather than a checker.

**An empty log is not a pass.** Neither original fault wrote an error line. The A Dog Said patch
opened on a test that failed, so the sequence stopped and `<success>Always</success>` kept it quiet:
no prosthetics, no old-wound treatment, nothing logged. The wildness element matched no field, which
*does* log one line, but it is a warning among hundreds and the animal loaded anyway. Only the
information card and the operations tab settle either of them.

## Load order

```
nelim.dalmatiansrenew                 this mod                              before it
SamBucher.ADogSaidAnimalProsthetics2  A Dog Said... Animal Prosthetics 2   3238353862   after this mod
```

`<loadBefore>` declares this, and it is not cosmetic: scenario D exists to prove it.

A Dog Said 2 is **not** a dependency. The patch is guarded, so the mod is whole without it.

`cucumpear.dalmatians` is named in `<incompatibleWith>` and must stay off. So must **Nelim's Animal
Ark**, which is not declared and cannot be: it carried this dalmatian until 2026-09-11, and both
define `CCPDalmatian`.

## What to search the log for

`Player.log` sits in
`%USERPROFILE%\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`.

| String in the log | Written by | What it would mean for this mod |
|---|---|---|
| `doesn't correspond to any field` | `DirectXmlToObject.ObjectFromXml` | The fault this port exists to fix. Expected count naming `CCPDalmatian`, `Leather_Dalmatian` or `RaceProperties`: **zero**. A line naming `wildness` means the old form came back. |
| `Could not load UnityEngine.Texture2D` | `ContentFinder<Texture2D>.Get` | A `texPath` with nothing behind it. The line names the path, so it says whether it is `Dalmatian` or `Dessicated_Dalmatian`. |
| `Failed to find any textures at` | `Graphic_Multi.Init` | The same fault one level up: no rotation at all found. |
| `Could not find parent node named` | `XmlInheritance.ResolveParents` | One of the three templates is gone: `AnimalThingBase`, `AnimalKindBase`, `LeatherBase`. The mod declares no abstract def of its own, so all three come from Core. |
| `Patch operation` … `failed` | `PatchOperation.Complete` | Expected count from this mod: **zero**, and zero is not informative. A `PatchOperationConditional` whose xpath selects nothing and which declares no `<nomatch>` reports success and logs nothing. |
| `Adding duplicate` | `DefDatabase.Add` | cucumpear's original, or the Animal Ark, is enabled alongside this port. |
| `Could not find type named` | `DirectXmlToObject.ClassTypeOf` | Only two `Class=` values exist here, both `Verse` patch operations. This would mean 1.6 renamed one. |

Lines naming other mods are not ours to fix, and are worth leaving in whatever gets pasted back.

---

## A — the animal exists, and tames

The baseline. Everything else assumes this one passed.

- Dev mode on, spawn `CCPDalmatian` with the debug spawn-pawn action.
- It draws as a white dog with black patches, walks, and is listed in the Wildlife tab.
- Tame it. It takes a name **the moment** it is tamed: `nameOnTameChance` is 1, which no vanilla
  dog has. A dalmatian that stays "dalmatian" after taming means the `<race>` block did not load.
- Training goes to **Advanced**: Obedience, Release, Rescue, Haul are all offered.

## B — wildness reads on the information card

The first of the two repairs, and the only place it shows.

- Open the tamed dalmatian's information card, Stats.
- **Wildness is listed, at 0%.** Listed is the point: `Wildness` declares `showIfUndefined` false,
  so the old broken form did not print a wrong number, it printed no line at all.
- Compare with a husky, which is 0.75. A dalmatian that reads 75% means the `<Wildness>` stat base
  is being ignored and the parent template's value is showing through.
- Search the log for `doesn't correspond to any field`. No line may name `wildness`.

## C — A Dog Said 2, with the load order correct

The second repair, and the reason the patch was rewritten.

- Enable A Dog Said 2, this mod **before** it in the list.
- Tame a dalmatian and a **husky**. Open the Health tab of each, then the operations list.
- **The two lists must match.** That is the assertion: not "the dalmatian has some operations" but
  "the dalmatian has the same ones vanilla's husky has". Both animals sit in all three of ADS 2's
  categories, so any difference is a fault.
- Expect prosthetic and bionic limb installs, and old-wound treatment. A dalmatian that offers only
  amputation is one that got none of the three lists.

## D — A Dog Said 2, with the load order wrong

The negative control, and the scenario that justifies `<loadBefore>`. Skip it and the mod looks
correct for a reason that is not the declared one.

- Same as C, but move this mod **after** A Dog Said 2 in the list.
- Expect the operations to be **gone**, and nothing in the log to say why.
- ADS 2's own `Patches/z_Category_Patches.xml` is named `z_` so it sorts last inside that mod. It
  copies the three categories' `recipeUsers` onto the real surgery recipes, taking each list as it
  stands at that moment. Cross-mod patch order is mod load order, so an addition made afterwards
  goes into a list nothing reads again.
- If the operations are still there in this configuration, the mechanism is not what the
  documentation says it is, and `ATTRIBUTION.md` needs correcting rather than celebrating.

## E — A Dog Said 2 absent

- Enable this mod with A Dog Said 2 switched off entirely.
- It must load, the dalmatian must be whole, and the patch must say nothing. That is the intended
  behaviour of a guarded patch and the reason this mod declares no dependency.
- The Health tab then offers what any vanilla animal offers, which is amputation and euthanasia.

## F — the leather

- Butcher a dalmatian, or dev-spawn `Leather_Dalmatian` directly.
- It is **almost white**, distinctly paler than plain leather beside it in the same stockpile.
- Its cold insulation is **14**, against plain leather's 16. Read it on the item's information
  card, not from the tooltip of a garment.
- Make a duster of it. The garment takes the leather's colour, and the French name of the material
  reads *fourrure de dalmatien*.

## G — the pet behaviours

These are cucumpear's and lavie2k's numbers, unchanged. They are worth one pass because they are
what the animal is for, and because a `<race>` block that half-loads still produces a walking dog.

- Leave a tamed dalmatian near colonists for a few days: it **nuzzles**, and the colonist gets the
  thought. `nuzzleMtbHours` is 20, so it is frequent enough to see within a quadrum.
- Shoot it, or fail a taming attempt on a wild one. It **never** turns manhunter: both chances are
  0. A dalmatian that turns on the colony means the `<race>` block did not load, and scenario A
  should already have caught that.
- Gestation is 25 days and litters are one to three.

## H — trade

- `AnimalCommon` and `AnimalPet` are the two trade tags.
- Call a bulk-goods trader and an exotic-goods trader, or check a nearby settlement's stock: the
  dalmatian is offered, at around **250 silver**.
- It can be sold back. An animal that can be bought but not sold means `MarketValue` is missing.

## I — the four textures

Four files: three rotations of the living animal, one of the dessicated corpse.

- Watch a dalmatian walk in each direction. West is not shipped; RimWorld mirrors `_east` when no
  `_west` exists, so a west-facing dog showing its far side reversed is correct.
- Check the puppy: it uses the same texture at a smaller `drawSize`, 0.95 against 1.5.
- **The dessicated corpse ships `_east` only.** `Graphic_Multi` builds the missing faces by
  rotating it, so a long-dead dalmatian is drawn from the side whichever way it lies. That is an
  upstream gap left alone deliberately, and it is **not** a fault to report. It is only worth
  checking that it does not crash and logs nothing.

## J — the two collisions

- Enable cucumpear's original alongside this port. `<incompatibleWith>` should make that
  impossible in the mod list itself; if it does not, the log says `Adding duplicate`.
- Enable **Nelim's Animal Ark** alongside this port. Nothing declares this one, because the Ark
  stopped shipping the dalmatian on 2026-09-11. An Ark from before that date defines `CCPDalmatian`
  too, and the last mod loaded wins in silence.

## K — an existing save

- Add the mod to a running colony. Dalmatians appear in later wildlife spawns and trader stock.
  Nothing already in the save changes.
- Swap cucumpear's original for this port in a save that has tamed dalmatians. The `defName` is
  unchanged, so **every dog already tamed survives the swap**, keeping its name and its training.
  That is the one claim the README makes about saves, and the only way to check it is this swap.
- Remove the mod from a save that has a dalmatian in it. The dog is destroyed, as with any content
  mod. Expected, and stated in the description.

## L — the mod list entry

- The name reads `Dalmatians Renew (unofficial)`.
- The icon is drawn at about 32 px there.
- The Workshop banner is `About/Preview.png`, 896 x 504.

## M — French

- Switch the game to French and reload.
- The animal is *dalmatien*, the puppy life stage is *chiot dalmatien*, and the leather is
  *fourrure de dalmatien*.
- The puppy stage is keyed `lifeStages.dalmatian_puppy`, by label and not by index. A puppy that
  stays in English while the adult translates means that key stopped matching, which happens if the
  English label is ever edited.

## What cannot be tested offline

Scenarios C and D are the pair that matters, and neither can be settled without the game: the
patch's effect lives in a list built at load time by another mod, and the failure mode of both is
silence. Everything else in this file has a counterpart in `_tools/Run-Tests.ps1`, which is why
that suite exists.
