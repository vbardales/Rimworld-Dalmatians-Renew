# Test scenarios

Three defs, four textures, two patches (one guarded for A Dog Said 2, one loaded only beside
WhaleysDogs), no assembly. There is very little here to break, and the two
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
- Compare with a hare, which declares 0.75. A card that lists every animal at 0% would not tell a
  stat that is read from one that is missing. The husky is no control in 1.6: it declares 0 as well,
  which the first Pickle run of 2026-09-24 found out by reading its card at 0%.
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

## M — English and French translations

Run this scenario in English and French, first without WhaleysDogs, then with
`Mlie.WhaleysDogs` enabled before this mod. Restart after changing the configuration.
Inspect adults and puppies, animal descriptions and attack labels, leather descriptions,
and the material name on a crafted garment. Include both saved `CCPDalmatian` animals
and `WD_Dalmatian` animals in the integration configuration. Check singular/plural
labels in lists, raw keys, unexpected English fallback in French and clipped text.
English uses the source Def text; French uses the injections inventoried in STATUS.md.
Record each language/configuration result separately; offline checks do not pass this scenario.

- Switch the game to French and reload.
- The animal is *dalmatien*, the puppy life stage is *chiot dalmatien*, and the leather is
  *fourrure de dalmatien*.
- The puppy stage is keyed `lifeStages.dalmatian_puppy`, by label and not by index. A puppy that
  stays in English while the adult translates means that key stopped matching, which happens if the
  English label is ever edited.
- WhaleysDogs uses `lifeStages.Young_Dalmation`, preserving the exact spelling and case
  of its English source handle. Its French puppy label is also *chiot dalmatien*.

## What cannot be tested offline

Scenarios C and D are the pair that matters, and neither can be settled without the game: the
patch's effect lives in a list built at load time by another mod, and the failure mode of both is
silence. Everything else in this file has a counterpart in `_tools/Run-Tests.ps1`, which is why
that suite exists.

## N — WhaleysDogs, two coats and one ordinary acquisition pool

Use a disposable save. Enable WhaleysDogs, this mod, then ADS 2 if testing it. Spawn at least
30 WD_Dalmatian pawns, including males and females. Expect both the original and the alternate
coat, roughly half each (not an exact quota). Check all directions and all three ages; compare
silhouette size, clipping, shadows and female graphics. Save/reload: each pawn retains its coat.
Check fresh, rotting and dessicated corpses; both coats keep WhaleysDogs' complete corpse fallback.
Generate ordinary trader stock and random starting pets: only WD_Dalmatian should be newly offered
as a dalmatian. CCPDalmatian remains available for explicit debug/scenario selection by design.

## O — WhaleysDogs balance, French, leather and ADS

Compare WD_Dalmatian with WhaleysDogs alone: all stats, diet, sounds and ages remain unchanged.
With this port enabled, leather becomes Leather_Dalmatian and animalType is Canine. Butcher an
animal and verify the leather label and item. Switch to French; verify animal, puppy and tool
labels without unresolved translation errors. With ADS 2 enabled, compare both saved races with
the husky's surgery list. Repeat without ADS 2: no patch error and no added ADS surgeries.

## P — Existing animals and legacy reproduction

On a COPY of an existing standalone save containing named/trained CCPDalmatian dogs and leather,
enable WhaleysDogs plus this port. Every old dog, its name, training and health must survive.
Verify an appropriate animal trader still buys an old dog. Old dogs can still reproduce and
explicit scenarios can request them: no conversion or crossbreeding is promised. On a copy of
a WhaleysDogs save, enable this port and verify old WD_Dalmatian animals survive as well.

## Q — Optional content and load-order warning

With only Core and this port, no WD_Dalmatian translation or integration patch should load.
Verify the original dog balance, traders, textures and leather still work. With WhaleysDogs,
check the mod list requests WhaleysDogs -> this port -> ADS 2. A reversed order is unsupported;
restore it before checking surgeries. Disabling WhaleysDogs restores our standalone definitions,
but a save containing WD_Dalmatian still requires WhaleysDogs. Do not remove content mods from
the primary save to perform this check; use disposable copies.

Record date, game build, load order, scenario ID, pass/fail and relevant log lines for N-Q.
These four scenarios are documented but have not yet been executed in game.

## What each scenario became

Written 2026-09-24. The suite that plays what needs a game is in `Tests/Pickle/`, and its README
lists the six passes and the commands: without optional mods (English and French), WhaleysDogs
(English and French), A Dog Said 2 in the declared order, every optional mod together, A Dog Said 2 in
the wrong order, and cucumpear's original. **None of it has been run.** The sections A to Q above stay
as the plain-language statement of what each scenario means; this table says where each one is checked.

| Scenario | Where it is checked | What is left out, and why |
| --- | --- | --- |
| A. the animal exists, and tames | Pickle `01`: defs owned by the mod, race values, naming on taming | That Obedience, Release, Rescue and Haul are offered: the game's reaction to `trainability`, whose value is asserted |
| B. Wildness on the card | Pickle `01`: card lists Wildness at 0%, a hare at 75%, with a capture | The log search for `wildness`: warnings the game writes while it loads its defs may come before Pickle starts capturing the log, so `no warnings from mod` cannot be relied on for them. `_tools/Run-Tests.ps1` proves offline that no `<wildness>` is left under `<race>` |
| C. A Dog Said 2, correct order | Pickle `03` and `04`: same operations as the husky, more than a plain animal | The look of the Health tab: vanilla's interface |
| D. A Dog Said 2, wrong order | Pickle `05`, the symptom asserted as green | Nothing. It is the one supported-order exception, and it runs when A Dog Said 2 changes |
| E. A Dog Said 2 absent | Pickle `01` and `02`: same operations as a rat, no error, no warning | |
| F. the leather | Pickle `01`: butchering yields it, insulation 14 against 16, a capture beside plain leather and its information card | Making a duster: the garment's colour is vanilla's reaction to `stuffProps.color` |
| G. the pet behaviours | Pickle `01`: nuzzle interval, both manhunter chances, gestation, litter curve and lifespan read from the live def | A dog seen nuzzling, shot or bred: the game's behaviour given those values, and random |
| H. trade | Pickle `01`: a trader kind's generator handles it, the player can sell it, market value 250 | A trader actually rolling one: random |
| I. the four textures | Pickle `01`: four rotations, puppy beside an adult, dessicated corpse, all captures a person reads | Nothing. West is mirrored from east, and the corpse's single texture is a documented gap |
| J. the two collisions | Pickle `06`: the original loaded before this mod | Nelim's Animal Ark: not reproducible. It stopped shipping the dalmatian on 2026-09-11 and the current Ark carries neither identifier, which the 2026-09-13 audit checked |
| K. an existing save | Not automated | Adding, swapping or removing a mod over a save is the game's handling of a changed mod list. What this mod answers for, that it keeps the original's `defName`s, is checked offline: the suite asserts that the three defs are there under the original's names, `CCPDalmatian` and `Leather_Dalmatian` |
| L. the mod list entry | Not automated | The mod list's rendering is the game's. The name, the icon's and the preview's dimensions are checked offline by the About and image tests |
| M. English and French | Pickle `01` and `02`, once per language: labels, plurals, puppy stage, attack labels, descriptions, the material name on a garment | Clipped text and layout, which are read on the captures |
| N. WhaleysDogs, two coats | Pickle `02`: both coats among forty animals, coats kept through a save and reload, trader pool, corpses of both coats at three stages, both coats facing every way | Silhouette, clipping and shadows are read on the captures. The starting-pet pool is asserted offline through the legacy fields |
| O. WhaleysDogs balance, leather, ADS | Pickle `02` and `04`: leather, French, operations. Balance unchanged: `_tools/WhaleysDogs.Tests.ps1`, offline, on the real patch operations | |
| P. existing animals, legacy reproduction | Pickle `02`: a legacy dog kept, still the player's and still the same coat after a reload, still sellable | Loading a real old save under a changed mod list is the game's, as in K. Reproduction of an old dog is not asserted: it is random, and the compatibility patch does not touch the race's reproduction fields |
| Q. optional content and load order | Pickle `01`: no integration loaded without WhaleysDogs. `02`, `03`, `04`: the declared order is the loaded order | A reversed order is covered by D. Removing WhaleysDogs from a save that holds `WD_Dalmatian` is the game's own refusal |

"Not automated" is a justified non-applicability and not a scenario left to do: what each one would
exercise is the game's own handling of a mod list, and what this mod answers for is asserted offline.

## Evidence to keep

Written 2026-09-24, before any in-game run exists. It says which proofs are worth keeping once
scenarios A-Q are played, so that nobody has to decide it again, and so that the folder stays small.

Where it lives. In-game evidence is kept **on disk only**, under `Tests/Pickle/Evidence/<run>/`,
and that folder is in `.gitignore`, like `evidence/`. Nothing in it is committed. The one thing
that is versioned is a short text summary, one line per run, under `docs/runs/`, cited by
`STATUS.md`. Never a folder of captures. The shared Pickle report folder holds every mod's
screenshots: copy only the files of this mod's own scenarios, never the folder.

What proves something, and is kept:

- **The verdict of each pass**: `summary.md` and `junit.xml`. Read `exitReason` before the
  numbers, and compare the scenarios played with the features discovered. A partial report that
  says "passed" is not a pass. The pass is named in the report (`-pickle-set-name`, the dependency
  map used), because passes differ only by what is loaded. The six passes are in
  `Tests/Pickle/README.md` and the scenarios are in the table above.
- **The captures a person has opened and read** for the scenarios that are only reviewable: the
  information card (B), the three rotations and the dessicated corpse's single east texture (I),
  the two coats and WhaleysDogs graphics (N), the operations tab with A Dog Said 2 (C). A green
  run says the path ran, not that the image shows the intended state.
- **The log lines the table above asks for**, extracted, not the whole `Player.log`: the count of
  `doesn't correspond to any field` naming this mod, texture errors, `Adding duplicate`, and the
  load-order lines for the pass. A capture taken outside developer mode says nothing about missing
  translation keys, so the English and French passes each keep their own developer-mode capture.

What is not kept: every capture of a superseded run, a second report for the same scenario on the
same revision, a whole `Player.log` when three lines carry the proof, and any report about an older
build than the one now in the repository. Keep the latest report for the current revision, per pass
and per scenario, plus an older one only if it is the sole proof of a check the latest did not repeat.
Delete the rest as soon as a newer report replaces it, after listing what goes and what stays. Never
delete a report that a field in `STATUS.md` still points to: repoint the field first.

Minifying is allowed once a capture has been looked at: downscale it to the size that still shows
the thing, and keep it as PNG. Do not touch it before it has been opened.

The launcher's archive of the run (`pickle-reports-archive/`) is a full copy of the shared folder.
Select from the archive of this mod's own run what is worth keeping above, then delete that archive.
Leave every other archive alone.
