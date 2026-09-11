# Dalmatians Renew

Port of **cucumpear's and lavie2k's Dalmatians** to RimWorld 1.6.

**I am not the author of this mod.** The animal, the artwork and the balance are theirs — all I
did was the work needed to make it run on 1.6, repair what the port turned up, and write the
French. Credit goes to them; mistakes in the port are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=1513691963 — declares 1.0
through 1.4 and nothing further. The page is still online; the mod is abandoned, not withdrawn.

## What the mod does

One dog. Three defs, four textures, one optional patch — no assembly, no dependency, no DLC, no
research.

| | |
|---|---|
| body size | 0.70 (husky 0.86, yorkshire terrier 0.2) |
| market value | 250 |
| comfortable to | −30 °C |
| food | omnivore, and eats eggs |
| trainability | Advanced |
| wildness | 0 — tames easily and never reverts |
| gestation | 25 days, litters of one to three |
| life expectancy | 12 years |
| leather | `Leather_Dalmatian`, almost white, insulation 14 against plain leather's 16 |

It nuzzles, it takes a name the moment it is tamed, and it never turns manhunter — on damage or
on a failed taming. Traders carry it: `AnimalCommon` and `AnimalPet`.

Available in English and French.

Content mod: removing it mid-save destroys any dalmatian already in the colony.

## What changed in the 1.6 port

### Wildness became a stat

The def declared this, inside `<race>`:

```xml
<wildness>0</wildness>
```

Wildness is no longer a field of `RaceProperties`; it is the `Wildness` `StatDef`. RimWorld does
not stop for an XML element that matches no field — it logs one line and carries on with the
field unset.

For this animal the practical damage is small, and it would be dishonest to dress it up: the
stat's `defaultBaseValue` is `-1`, its `minValue` is `0`, and `StatWorker` clamps, so a dalmatian
left in the old form still comes out at 0 — the value it was asking for. What is actually lost is
the line on the information card, because `Wildness` declares `showIfUndefined` false. The reason
to fix it regardless is the general case: any animal in this position whose wildness was *not*
zero silently becomes as tame as a rat.

It is now `<Wildness>0</Wildness>` under `statBases`, as vanilla's own dogs write it.

### The A Dog Said patch had stopped working, and was also wrong

Three faults, and the second hid the first.

**The names are gone.** The patch added the dalmatian to recipes called `OldWoundsAnimal`,
`InstallPegLegAnimal`, `InstallBionicEyeAnimal` and a dozen more — the names *A Dog Said...
Animal Prosthetics* used up to 2023. **A Dog Said... Animal Prosthetics 2** defines none of them:
it groups animals into three abstract recipe parents, `ADS_Cat1`, `ADS_Cat2` and `ADS_Cat3`. So
the patch's leading `PatchOperationTest` failed, the sequence stopped, and `<success>Always</success>`
kept that quiet. No prosthetics, no old-wound treatment, no error.

The guard itself was never the fault — a `PatchOperationSequence` opening on a `PatchOperationTest`
is a perfectly good way to make a patch optional. It is now a `PatchOperationConditional` on
`ADS_Cat1`, which does the same job in one operation instead of three and needs no
`<success>Always</success>` to stay quiet.

It was briefly `MayRequire="SamBucher.ADogSaidAnimalProsthetics2"` on the operation, which is
**inert**: `Verse.PatchOperation` has no such field, and `ModContentPack.LoadPatches`, which builds
the operations, never reads the attribute. The add would have applied with or without A Dog Said 2.
The attribute is honoured on a def node, on a `<li>` and on any field element — A Dog Said 2 uses it
correctly on the `<li>`s inside those category lists — which is exactly why the form on an
`<Operation>` looks right. Nothing in the log says otherwise.

**The XPath was never a test.** The predicate read:

    /Defs/RecipeDef[@Name = "OldWoundsAnimal" or "InstallPowerClawAnimal" or ... ]

In XPath, `or` converts its operands to booleans and a non-empty string literal is `true`. That
predicate matches **every** `RecipeDef` in the document. Had the old names still existed, the
dalmatian would have been added to the `recipeUsers` of every recipe in the game and in every mod
loaded. Each name is now compared properly — `@Name="..." or @Name="..."` — which is the form A
Dog Said 2 uses in its own compatibility patches.

The dalmatian now sits in all three categories, alongside vanilla's husky, labrador and yorkshire
terrier. A Dog Said 2 puts *pack animals and trainable pets* in category 3, and the three lists are
cumulative, so a category-3 animal appears in all of them.

**It was also arriving too late to matter.** The `ADS_Cat` defs are abstract and nothing inherits
from them. A Dog Said 2's own final patch, named `z_Category_Patches.xml` so it sorts last, copies
their `recipeUsers` onto the real surgery bases — and it takes each list as it stands at that
moment. Its own compatibility files are safe because they live inside it, where file order settles
the question; an outside mod is not, because cross-mod patch order is mod load order. So this mod
must load **before** A Dog Said 2, and `<loadBefore>` now declares it.

### One field added

`<animalType>Canine</animalType>`. Every dog-shaped animal vanilla ships declares it — husky,
labrador, yorkshire terrier, warg, Odyssey's bog hound, and the abstract base the wolves share —
and it did not exist when this mod was written.

What it actually does today is close to nothing, and that is worth saying plainly: `AnimalType`
has three values and exactly one consumer in the 1.6 assembly,
`TraitDef.disableHostilityFromAnimalType`, which no vanilla trait sets. It is a hook for mods.
Declaring it costs nothing and puts the dalmatian where the other dogs already are.

### French

16 keys. The puppy stage is keyed `lifeStages.dalmatian_puppy`, not by index — the game keys list
elements by their label. The leather is *fourrure de dalmatien*, matching how the game already
names dog leather in French, and carries a `stuffProps.stuffAdjective` that the English def does
not need.

### What did not change

Every stat, every tool, the litter curve, the life stages and their draw sizes, the sounds, the
trade tags, the leather's colour and insulation, and the four textures. The balance was not
touched anywhere.

## The defNames were kept

`CCPDalmatian` carries an author prefix. `Leather_Dalmatian` does not, and that is exactly the
kind of name another dog mod would want, so it was checked rather than assumed:

- **Core and every DLC** — nothing.
- **All 10 353 subscribed Workshop mods** — the only files among them that name either def are
  the source mod's own three.
- **Every other mod I maintain** — nothing.

No collision, so no rename. A rename is permanent in a way a port is not: it would take every
dalmatian already tamed out of every existing save.

## One upstream gap, left alone

The dessicated corpse ships one texture, `Dessicated_Dalmatian_east.png` — no `_north`, no
`_south`. `Graphic_Multi` does not fail on this; it builds the missing faces by rotating the one
it has, so a long-dead dalmatian is drawn from the side whichever way it lies. It has been that
way since 2018, and fixing it would mean drawing art rather than porting a mod.

## Compatibility with the original

The two cannot run together: `cucumpear.dalmatians` is declared in `<incompatibleWith>`. Because
the `defName`s match, swapping one for the other in an existing save keeps every dog already
tamed.

This mod also spent a week inside **Nelim's Animal Ark** and has been taken out of it, for the
same reason: same defName, same collision.

## Repository layout

```
DalmatiansRenew/
  Mod/     <- what goes on the Workshop; the NTFS junction into RimWorld/Mods points here
  Art/     <- the full-resolution sources of the two pictures, never published
  _tools/  <- the test suite, never published
```

`Art/` holds the full-resolution sources of the two pictures, `Preview-source.png` and
`ModIcon-source.png`, which are cropped and scaled down into `Mod/About/`. It also keeps
`Make-ModIcon.ps1`, the script that cut the first icon out of the mod's own sprite. That icon is
gone: a port does not take its identity from the art it carries, and both pictures are now the
port's own work.

## Verification

Two levels, neither of which needs the game.

`_tools/Run-Tests.ps1` is the mod's own suite: 28 tests, a few seconds, no RimWorld. It reads the
game's classes by reflection and A Dog Said 2 off disk, so the sentences these documents state as
fact are computed rather than trusted - the XPath quirk is reproduced rather than described, the
`Wildness` clamp is read off the stat, and the leather's margin is walked up `LeatherBase`.

```bash
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1
```

The static checks that live in my mod monorepo are the deeper instruments. They are tooling, not
mod content, so they are not carried here; run from that monorepo, with this folder beside it, the
commands are:

```bash
pwsh -File scripts/Check-XmlFields.ps1   -ModPath DalmatiansRenew/Mod
pwsh -File scripts/Check-DefRefs.ps1     -ModPath DalmatiansRenew/Mod -Brief
pwsh -File scripts/Check-DefInjected.ps1 -TransMod DalmatiansRenew/Mod
```

Every element maps to a 1.6 field, every def reference and `ParentName` resolves, and all 16
translation keys land on something the injector can reach.

What none of that can settle is in [TESTING.md](TESTING.md): the patch's effect lives in a list
another mod builds at load time, and the failure mode is silence.

## Credits

- **cucumpear** and **lavie2k** — the dalmatian, its artwork, its balance, the original mod.

See [ATTRIBUTION.md](ATTRIBUTION.md) for the licence position and what exactly was carried over.

The port work was done with the help of an AI assistant (Claude, by Anthropic), under human
direction and in-game testing.
