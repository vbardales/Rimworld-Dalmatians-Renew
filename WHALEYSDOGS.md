# WhaleysDogs integration assessment

Inspected installed WhaleysDogs (Continued), package Mlie.WhaleysDogs, Workshop 2274606936,
on 2026-09-13. Only the two mods and the installed ADS 2 integration folder were searched.

There is no identifier collision: our ThingDef/PawnKindDef is CCPDalmatian, theirs is
WD_Dalmatian. The overlap is two representations of the same dog breed.

| Property | Dalmatians Renew | WhaleysDogs 1.6 |
|---|---|---|
| Market value | 250 | 320 |
| Body size | 0.70 | 1.0 |
| Hunger rate | 0.4 | 0.20 |
| Health scale | 1.0 | 0.75 |
| Minimum comfortable temperature | -30 C | 1 C |
| Wildness | 0 | 0.2 |
| Food | Omnivore + eggs | Carnivore + eggs |
| Trainability | Advanced | Advanced |
| Gestation | 25 days | 22 days |
| Life expectancy | 12 years | 18 years |
| Adult age | 0.5 years | 2.65 years |
| Nuzzle interval | 20 hours | 24 hours |
| Name on tame chance | 1 | 0.75 |
| Manhunter on damage | 0 | 0.1 |
| Leather | Leather_Dalmatian | Leather_Dog |
| Living graphics | 3 directional textures | 3 directional textures |
| Dessicated graphics | 1 inherited east texture | vanilla labrador graphics |

## Implemented ownership

With Mlie.WhaleysDogs enabled, WD_Dalmatian is the canonical breed for ordinary acquisition.
Its stats, tools, food, lifespan, maturity, sounds and existing graphics remain unchanged.
The only ThingDef additions are Leather_Dalmatian and animalType Canine. Without WhaleysDogs,
this port loads its original standalone definitions and no integration translations or patches.

Load order: WhaleysDogs, Dalmatians Renew, A Dog Said 2 (if used). About.xml declares both edges.
LoadFolders.xml activates Compatibility/WhaleysDogs only for Mlie.WhaleysDogs. The patch also
checks for WD_Dalmatian before acting. No upstream asset or source file is copied into this mod.

## Appearance and useful additions

The native PawnKindDef alternateGraphics mechanism adds our three living sprites as a coat
variant. With the installed unmodified WhaleysDogs data, alternateGraphicChance is 0.5.
PawnGraphicUtils.TryGetAlternate seeds selection from the pawn ID, so the choice is stable
across rendering, ages and save reloads, with no artificial male/female split. Existing
third-party variants and their declared selection chance are retained. Adding/removing variant
mods may change appearance; this is not a separately saved coat assignment.

Both sets have north/east/south textures, with mirrored west: this adds a visual option, not
extra directions. Original body/female graphics and all WhaleysDogs life-stage sizes remain.
The complete vanilla labrador corpse graphics used by WhaleysDogs remain for both coats;
our incomplete dessicated sprite is not applied to WD_Dalmatian. WhaleysDogs 1.6 uses an asset
bundle. Its manifest was inspected, but its current pixels were not extracted for visual
comparison. Actual coat size, directional appearance and corpse rendering need in-game QA.

WD_Dalmatian yields our dedicated leather and receives French animal/puppy/tool labels. Both
saved races are added to the three ADS 2 recipe categories if those lists exist; unrelated
recipes are untouched. No ADS dependency is added and membership is not duplicated.

## Existing saves and deliberate limits

CCPDalmatian ThingDef and PawnKindDef remain unchanged in identity and continue to reference
each other. Existing animals are not deleted or converted, keep their training and can be
sold. While WhaleysDogs is active the legacy breed becomes Sellable, petness becomes zero,
wildBiomes is emptied, and its kind is excluded from manhunter, scatter and random combat
selection with zero ecosystem weight. The trade tags remain so traders can buy old animals.
The native trader and random starting-pet selection code was inspected to verify those gates.

This retires ordinary acquisition; it is not a universal interceptor of other mods' generators.
Explicit scenario selections, debug spawning, an external mod explicitly requesting the old
kind and offspring of existing legacy animals can still produce CCPDalmatian. Legacy dogs and
WD_Dalmatian remain distinct races; crossbreeding is not added. This exception avoids destructive
save migration. Disabling WhaleysDogs restores standalone behaviour, but any existing
WD_Dalmatian still requires its owning mod. Removing this port also removes its leather and
legacy race: neither mod should be removed casually from a save using its content.

## Validation

Run _tools/Run-Tests.ps1. Nine integration tests extend the original 28. The integration tests
instantiate the installed Verse patch classes and call Apply on fixture documents; only the
Unity profiler is disabled in the offline process. They verify the absent-mod guard, metadata,
unchanged canonical stats, saved identities, acquisition gates, coat variants, repeated patch
application, existing variants, ADS categories, real 1.6 fields and conditional French keys.

All 37 tests passed on 2026-09-13, no skips. This is not a RimWorld save-load/rendering run.
TESTING.md scenarios N-Q cover those remaining runtime checks.