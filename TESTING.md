# Test scenarios

Three defs, four textures, two patches (one guarded for A Dog Said 2, one loaded only beside
WhaleysDogs), no assembly. Little here to break. The two
things broken in 1.4 version both broke **silently**. That is why this
mod needs the game, not a checker.

**Empty log not a pass.** Neither original fault wrote error line. A Dog Said patch
opened on failing test, so sequence stopped and `<success>Always</success>` kept it quiet:
no prosthetics, no old-wound treatment, nothing logged. Wildness element matched no field, which
*does* log one line, but it is one warning among hundreds and animal loaded anyway. Only the
information card and operations tab settle either.

## Load order

```
nelim.dalmatians                 this mod                              before it
SamBucher.ADogSaidAnimalProsthetics2  A Dog Said... Animal Prosthetics 2   3238353862   after this mod
```

`<loadBefore>` declares this, not cosmetic: scenario D exists to prove it.

A Dog Said 2 **not** dependency. Patch guarded, so mod whole without it.

`cucumpear.dalmatians` named in `<incompatibleWith>`, must stay off. So must **Nelim's Animal
Ark**, not declared and cannot be: it carried this dalmatian until 2026-09-11, both
define `CCPDalmatian`.

## What to search the log for

`Player.log` sits in
`%USERPROFILE%\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`.

| String in the log | Written by | What it would mean for this mod |
|---|---|---|
| `doesn't correspond to any field` | `DirectXmlToObject.ObjectFromXml` | Fault this port exists to fix. Expected count naming `CCPDalmatian`, `Leather_Dalmatian` or `RaceProperties`: **zero**. Line naming `wildness` = old form came back. |
| `Could not load UnityEngine.Texture2D` | `ContentFinder<Texture2D>.Get` | `texPath` with nothing behind it. Line names path, so shows whether `Dalmatian` or `Dessicated_Dalmatian`. |
| `Failed to find any textures at` | `Graphic_Multi.Init` | Same fault one level up: no rotation found at all. |
| `Could not find parent node named` | `XmlInheritance.ResolveParents` | One of three templates gone: `AnimalThingBase`, `AnimalKindBase`, `LeatherBase`. Mod declares no abstract def of its own, so all three come from Core. |
| `Patch operation` … `failed` | `PatchOperation.Complete` | Expected count from this mod: **zero**, and zero not informative. `PatchOperationConditional` whose xpath selects nothing and declares no `<nomatch>` reports success, logs nothing. |
| `Adding duplicate` | `DefDatabase.Add` | cucumpear's original, or Animal Ark, enabled alongside this port. |
| `Could not find type named` | `DirectXmlToObject.ClassTypeOf` | Only two `Class=` values exist here, both `Verse` patch operations. Would mean 1.6 renamed one. |

Lines naming other mods not ours to fix, worth leaving in whatever gets pasted back.

---

## A — the animal exists, and tames

Baseline. Everything else assumes this passed.

- Dev mode on, spawn `CCPDalmatian` with debug spawn-pawn action.
- Draws as white dog with black patches, walks, listed in Wildlife tab.
- Tame it. Takes name **the moment** tamed: `nameOnTameChance` is 1, no vanilla
  dog has this. Dalmatian staying "dalmatian" after taming = `<race>` block did not load.
- Training goes to **Advanced**: Obedience, Release, Rescue, Haul all offered.

## B — wildness reads on the information card

First of two repairs, only place it shows.

- Open tamed dalmatian's information card, Stats.
- **Wildness listed, at 0%.** Listed is the point: `Wildness` declares `showIfUndefined` false,
  so old broken form printed no line at all, not wrong number.
- Compare with hare, declares 0.75. Card listing every animal at 0% would not tell stat
  read from stat missing. Husky no control in 1.6: declares 0 too,
  which first Pickle run of 2026-09-24 found by reading its card at 0%.
- Search log for `doesn't correspond to any field`. No line may name `wildness`.

## C — A Dog Said 2, with the load order correct

Second repair, reason patch was rewritten.

- Enable A Dog Said 2, this mod **before** it in list.
- Tame dalmatian and **husky**. Open Health tab of each, then operations list.
- **Two lists must match.** That is the assertion: not "dalmatian has some operations" but
  "dalmatian has same ones vanilla's husky has". Both animals sit in all three of ADS 2's
  categories, so any difference is a fault.
- Expect prosthetic and bionic limb installs, old-wound treatment. Dalmatian offering only
  amputation got none of the three lists.

## D — A Dog Said 2, with the load order wrong

Negative control, scenario justifying `<loadBefore>`. Skip it and mod looks
correct for reason not the declared one.

- Same as C, but move this mod **after** A Dog Said 2 in list.
- Expect operations **gone**, nothing in log to say why.
- ADS 2's own `Patches/z_Category_Patches.xml` named `z_` so it sorts last inside that mod. It
  copies three categories' `recipeUsers` onto real surgery recipes, taking each list as it
  stands then. Cross-mod patch order is mod load order, so later addition
  goes into list nothing reads again.
- If operations still there in this configuration, mechanism not what
  documentation says, and `ATTRIBUTION.md` needs correcting, not celebrating.

## E — A Dog Said 2 absent

- Enable this mod with A Dog Said 2 switched off entirely.
- Must load, dalmatian whole, patch silent. Intended
  behaviour of guarded patch, reason this mod declares no dependency.
- Health tab then offers what any vanilla animal offers: amputation and euthanasia.

## F — the leather

- Butcher dalmatian, or dev-spawn `Leather_Dalmatian` directly.
- **Almost white**, distinctly paler than plain leather beside it in same stockpile.
- Cold insulation **14**, against plain leather's 16. Read on item's information
  card, not garment tooltip.
- Make duster of it. Garment takes leather's colour, French material name
  reads *fourrure de dalmatien*.

## G — the pet behaviours

Cucumpear's and lavie2k's numbers, unchanged. Worth one pass because they are
what animal is for, and because half-loaded `<race>` block still produces walking dog.

- Leave tamed dalmatian near colonists few days: it **nuzzles**, colonist gets
  thought. `nuzzleMtbHours` is 20, frequent enough to see within a quadrum.
- Shoot it, or fail taming attempt on wild one. **Never** turns manhunter: both chances
  0. Dalmatian turning on colony = `<race>` block did not load, scenario A
  should already have caught that.
- Gestation 25 days, litter curve peaks at two puppies (points 0.5 to 3.5, original's, unchanged). Information card writes range as `1~4`; description states neither figure, only the peak.

## H — trade

- `AnimalCommon` and `AnimalPet` are two trade tags.
- Call bulk-goods trader and exotic-goods trader, or check nearby settlement's stock:
  dalmatian offered, around **250 silver**.
- Can be sold back. Animal bought but not sold = `MarketValue` missing.

## I — the four textures

Four files: three rotations of living animal, one of dessicated corpse.

- Watch dalmatian walk each direction. West not shipped; RimWorld mirrors `_east` when no
  `_west` exists, so west-facing dog showing far side reversed is correct.
- Check puppy: same texture at smaller `drawSize`, 0.95 against 1.5.
- **Dessicated corpse ships `_east` only.** `Graphic_Multi` builds missing faces by
  rotating it, so long-dead dalmatian drawn from side whichever way it lies. Upstream gap left alone deliberately, **not** fault to report. Only check it does not crash and logs nothing.

## J — the two collisions

- Enable cucumpear's original alongside this port. `<incompatibleWith>` should make that
  impossible in mod list itself; if not, log says `Adding duplicate`.
- Enable **Nelim's Animal Ark** alongside this port. Nothing declares this one, because Ark
  stopped shipping dalmatian on 2026-09-11. Ark from before that date defines `CCPDalmatian`
  too, last mod loaded wins in silence.

## K — an existing save

- Add mod to running colony. Dalmatians appear in later wildlife spawns and trader stock.
  Nothing already in save changes. Not own scenario: every Pickle scenario already
  loads save with mod present, so suite as whole covers it.
- Remove mod from save with dalmatian in it. Dog destroyed, as with any content
  mod. Expected, stated in description. Only part of K still worth look in game.

Claim that `defName` unchanged, so dog already tamed under cucumpear's original would
survive swap to this port, not checked in game (owner declined, 2026-09-27): stays
offline check that three defs carry original's names, `CCPDalmatian` and
`Leather_Dalmatian`.

## L — the mod list entry

- Name reads `Dalmatians Renew (unofficial)`.
- Icon drawn at about 32 px there.
- Workshop banner is `About/Preview.png`, 896 x 504.

## M — English and French translations

Run in English and French, first without WhaleysDogs, then with
`Mlie.WhaleysDogs` enabled before this mod. Restart after changing configuration.
Inspect adults and puppies, animal descriptions and attack labels, leather descriptions,
material name on crafted garment. Include both saved `CCPDalmatian` animals
and `WD_Dalmatian` animals in integration configuration. Check singular/plural
labels in lists, raw keys, unexpected English fallback in French, clipped text.
English uses source Def text; French uses injections inventoried in STATUS.md.
Record each language/configuration result separately; offline checks do not pass this scenario.

- Switch game to French and reload.
- Animal is *dalmatien*, puppy life stage *chiot dalmatien*, leather
  *fourrure de dalmatien*.
- Puppy stage keyed `lifeStages.dalmatian_puppy`, by label not index. Puppy that
  stays English while adult translates = key stopped matching, happens if
  English label ever edited.
- WhaleysDogs uses `lifeStages.Young_Dalmation`, preserving exact spelling and case
  of its English source handle. Its French puppy label also *chiot dalmatien*.

## What cannot be tested offline

Scenarios C and D are the pair that matters, neither settled without game: patch's
effect lives in list built at load time by another mod, failure mode of both is
silence. Everything else here has counterpart in `scripts/Run-Tests.ps1`, why
that suite exists.

## N — WhaleysDogs, two coats and one ordinary acquisition pool

Use disposable save. Enable WhaleysDogs, this mod, then ADS 2 if testing it. Spawn at least
30 WD_Dalmatian pawns, males and females. Expect both original and alternate
coat, roughly half each (not exact quota). Check all directions and all three ages; compare
silhouette size, clipping, shadows, female graphics. Save/reload: each pawn retains coat.
Check fresh, rotting, dessicated corpses; both coats keep WhaleysDogs' complete corpse fallback.
Generate ordinary trader stock and random starting pets: only WD_Dalmatian should be newly offered
as dalmatian. CCPDalmatian remains available for explicit debug/scenario selection by design.

## O — WhaleysDogs balance, French, leather and ADS

Compare WD_Dalmatian with WhaleysDogs alone: all stats, diet, sounds, ages unchanged.
With this port enabled, leather becomes Leather_Dalmatian and animalType is Canine. Butcher
animal, verify leather label and item. Switch to French; verify animal, puppy, tool
labels without unresolved translation errors. With ADS 2 enabled, compare both saved races with
husky's surgery list. Repeat without ADS 2: no patch error, no added ADS surgeries.

## P — Existing animals and legacy reproduction

On COPY of existing standalone save containing named/trained CCPDalmatian dogs and leather,
enable WhaleysDogs plus this port. Every old dog, its name, training, health must survive.
Verify appropriate animal trader still buys old dog. Old dogs can still reproduce and
explicit scenarios can request them: no conversion or crossbreeding promised. On copy of
WhaleysDogs save, enable this port, verify old WD_Dalmatian animals survive too.

## Q — Optional content and load-order warning

With only Core and this port, no WD_Dalmatian translation or integration patch should load.
Verify original dog balance, traders, textures, leather still work. With WhaleysDogs,
check mod list requests WhaleysDogs -> this port -> ADS 2. Reversed order unsupported;
restore before checking surgeries. Disabling WhaleysDogs restores our standalone definitions,
but save containing WD_Dalmatian still requires WhaleysDogs. Do not remove content mods from
primary save for this check; use disposable copies.

Record date, game build, load order, scenario ID, pass/fail, relevant log lines for N-Q.
These four scenarios documented but not yet executed in game.

## What each scenario became

Written 2026-09-24. Suite playing what needs game is in `Tests/Pickle/`, its README
lists six passes and commands: without optional mods (English and French), WhaleysDogs
(English and French), A Dog Said 2 in declared order, every optional mod together, A Dog Said 2 in
wrong order, cucumpear's original. **None run.** Sections A to Q above stay
as plain-language statement of what each scenario means; table says where each is checked.

| Scenario | Where it is checked | What is left out, and why |
| --- | --- | --- |
| A. the animal exists, and tames | Pickle `01`: defs owned by mod, race values, naming on taming, Obedience, Release, Rescue, Haul all offered on `pawn.training` (PickleTools, 2026-09-27: same call Training tab itself makes, not copy) | Nothing |
| B. Wildness on the card | Pickle `01`: card lists Wildness at 0%, hare at 75%, with capture | Log search for `wildness`: warnings game writes while loading defs may come before Pickle starts capturing log, so `no warnings from mod` unreliable for them. `scripts/Run-Tests.ps1` proves offline no `<wildness>` left under `<race>` |
| C. A Dog Said 2, correct order | Pickle `03` and `04`: same operations as husky, more than plain animal | Look of Health tab: vanilla's interface |
| D. A Dog Said 2, wrong order | Pickle `05`, symptom asserted as green | Nothing. Only supported-order exception, runs when A Dog Said 2 changes |
| E. A Dog Said 2 absent | Pickle `01` and `02`: same operations as rat, no error, no warning | |
| F. the leather | Pickle `01`: butchering yields it, insulation 14 against 16, capture beside plain leather and its information card | Making duster: garment colour is vanilla's reaction to `stuffProps.color` |
| G. the pet behaviours | Pickle `01`: nuzzle interval, both manhunter chances, gestation, litter curve, lifespan read from live def | Dog seen nuzzling, shot or bred: game's behaviour given those values, random |
| H. trade | Pickle `01`: trader kind's generator handles it, player can sell it, market value 250 | Trader actually rolling one: random |
| I. the four textures | Pickle `01`: four rotations, puppy beside adult, dessicated corpse, all captures person reads | Nothing. West mirrored from east, corpse's single texture documented gap |
| J. the two collisions | Pickle `06`: original loaded before this mod | Nelim's Animal Ark: not reproducible. Stopped shipping dalmatian 2026-09-11, current Ark carries neither identifier, checked by 2026-09-13 audit |
| K. an existing save | Automated 2026-10-02 (owner: can be): Pickle `10` + `Removal/Mod/removal-check`, two-launch chain (after Animal Apparel Collars' scenario H). Asserts no errors and live engine after loading without mod and after resave; dog dropped is game's handling. Was: removing mod from save with dalmatian destroys it | Adding mod not own scenario, every Pickle scenario already does it. Swapping with original, to see already-tamed dog survive, was in scope but owner declined: what it would have checked, that `defName`s unchanged, stays offline check on three defs |
| L. the mod list entry | Not automated | Mod list rendering is game's. Name, icon and preview dimensions checked offline by About and image tests |
| M. English and French | Pickle `01` and `02`, once per language: labels, plurals, puppy stage, attack labels, descriptions, material name on garment | Clipped text and layout, read on captures |
| N. WhaleysDogs, two coats | Pickle `02`: both coats among forty animals, coats kept through save and reload, trader pool, corpses of both coats at three stages, both coats facing every way | Silhouette, clipping, shadows read on captures. Starting-pet pool asserted offline through legacy fields |
| O. WhaleysDogs balance, leather, ADS | Pickle `02` and `04`: leather, French, operations. Balance unchanged: `scripts/WhaleysDogs.Tests.ps1`, offline, on real patch operations | |
| P. existing animals, legacy reproduction | Pickle `02`: legacy dog kept, still player's and same coat after reload, still sellable | Loading real old save under changed mod list is game's, as in K. Reproduction of old dog not asserted: random, and compatibility patch does not touch race's reproduction fields |
| Q. optional content and load order | Pickle `01`: no integration loaded without WhaleysDogs. `02`, `03`, `04`: declared order is loaded order | Reversed order covered by D. Removing WhaleysDogs from save holding `WD_Dalmatian` is game's own refusal |

"Not automated" is justified non-applicability, not scenario left to do: what each would
exercise is game's own handling of mod list, and what this mod answers for is asserted offline.

## Evidence to keep

Written 2026-09-24, before any in-game run exists. Says which proofs worth keeping once
scenarios A-Q played, so nobody decides again, and folder stays small.

Where it lives. In-game evidence kept **on disk only**, under `Tests/Pickle/Evidence/<run>/`,
folder in `.gitignore`, like `evidence/`. Nothing in it committed. Only thing
versioned is short text summary, one line per run, under `docs/runs/`, cited by
`STATUS.md`. Never folder of captures. Shared Pickle report folder holds every mod's
screenshots: copy only files of this mod's own scenarios, never the folder.

What proves something, and is kept:

- **Verdict of each pass**: `summary.md` and `junit.xml`. Read `exitReason` before
  numbers, compare scenarios played with features discovered. Partial report
  saying "passed" is not a pass. Pass named in report (`-pickle-set-name`, dependency
  map used), because passes differ only by what is loaded. Six passes in
  `Tests/Pickle/README.md`, scenarios in table above.
- **Captures a person has opened and read** for scenarios only reviewable: the
  information card (B), three rotations and dessicated corpse's single east texture (I),
  two coats and WhaleysDogs graphics (N), operations tab with A Dog Said 2 (C). Green
  run says path ran, not that image shows intended state.
- **Log lines the table above asks for**, extracted, not whole `Player.log`: count of
  `doesn't correspond to any field` naming this mod, texture errors, `Adding duplicate`, and
  load-order lines for pass. Capture taken outside developer mode says nothing about missing
  translation keys, so English and French passes each keep own developer-mode capture.

What is not kept: every capture of superseded run, second report for same scenario on
same revision, whole `Player.log` when three lines carry proof, any report about older
build than one now in repository. Keep latest report for current revision, per pass
and per scenario, plus older one only if sole proof of check latest did not repeat.
Delete rest as soon as newer report replaces it, after listing what goes and what stays. Never
delete report that field in `STATUS.md` still points to: repoint field first.

Current state (2026-10-02): kept latest report per scenario (2026-09-27-p1-training for pass 1 English; p1-french,
p2-english/french and two p2 trade runs as sole proof for French pass 1 and pass 2; rename-p1..p5, p6b; gallery-6),
training captures recompressed to JPEG. Keep same shape after each later run: replace, never accumulate.

Minifying allowed once capture looked at, never before opened. Keep
full frame, recompress to JPEG at quality 85: 1920 x 1080 capture goes from about 3 MB
as PNG to about 250 KB, stays legible, as first three runs of this suite showed. Do not
keep `report.html` (5 MB and up) or `messages.ndjson`: summary, junit file, log and
captures carry proof. Of two runs of same scenario, keep later, delete run whose
captures showed nothing once replacement does. 2026-09-25 clean-up took evidence folder
from 50 MB to 2.5 MB this way.

Launcher's archive of run (`pickle-reports-archive/`) is full copy of shared folder.
Select from archive of this mod's own run what is worth keeping above, then delete that archive.
Leave every other archive alone.

## Crossing patches (2026-10-02)

Dogs mate and Better Crossbreeding patches (`Mod/Patches/Compat_*.xml`): offline in `scripts/Crossbreeding.Tests.ps1` (real Verse operations); in game, passes 7 to 9 of `Tests/Pickle/README.md` (features `08`, `09`), reading live `canCrossBreedWith` lists and `DZY.CrossBreeding.Extension` of each mother kind. **Not automated:** pregnancy played through to birth with Better Crossbreeding (per-save father dictionary, needs save and reload) and actual courtship in Dogs mate. Both are mods' own behaviour once lists right, stay out of this mod's tests. Keep per pass verdict (`summary.md`, `junit.xml`) of latest run only.