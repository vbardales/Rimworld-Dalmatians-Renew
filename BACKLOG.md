# Backlog

Ideas for mod not started. Each entry: what feature would be, what already covers part of it, what must be settled before first line of code. Nothing promised.

Mod is port, balance deliberately left as cucumpear and lavie2k made it (`ATTRIBUTION.md`). Idea earns place here only if serves that dog without changing what port promises. Shipped stuff in `CHANGELOG.md`; stuff to check in play in `TESTING.md`.

---

## Nocturnal Animals (Continued)

**Where it stands, 2026-09-25: nothing to do, nothing claimed.** Workshop `2269731409`, package `Mlie.XNDNocturnalAnimals`, read from installed copy (1.6 folder). Gives animal body clock through def extension, `NocturnalAnimals.ExtendedRaceProperties` with `bodyClock`, ships patches for vanilla wolves, foxes, deer, elk, wild boar, other wild animals. **Its 1.6 patches name no husky, labrador or yorkshire terrier**, own description says unpatched animal is diurnal. Dalmatian therefore diurnal beside vanilla's dogs, which is what domestic dog already is in game.

- **Why it stays out:** body clock = behaviour change neither original nor vanilla's dogs have. Would also add soft link to mod with no bearing on this one.
- **What must be settled first:** whether owner wants dalmatian to differ from husky. If so, patch in `Compatibility/` with `PatchOperationAddModExtension`, read only when package active (`LoadFolders.xml`, `IfModActive`), exactly as WhaleysDogs folder. One pass, one scenario reading extension off live def.
- **Not verified:** what mod's card shows for animal without extension, what its settings page lists for dalmatian. Neither run; only files read.

## Better Crossbreeding

**Where it stands, 2026-09-25: nothing happens by default, feature possible.** Workshop `3520675842`, package `DizzyEevee.BetterCrossbreeding`, read from installed copy. Only installed mod whose name says crossbreeding; if other meant, entry is for wrong mod. Adds def extension, `DZY.Crossbreeding.Extension` with list of outcomes, reads it **on mother's PawnKindDef only**. Ships no outcomes: its `Example/` folder not loaded (`LoadFolders.xml` reads `/` and `1.6`). Animal without extension breeds as vanilla, so dalmatian unaffected today.

Vanilla 1.6 has own field, `canCrossBreedWith` on race, which Core uses for thrumbo and Odyssey for one more animal. Neither field set on a dog.

- **Feature, if wanted:** dalmatian mother by husky or labrador father giving chosen kind (paternal, maternal, random or weighted list), and reverse for husky and labrador. New gameplay, not part of original, reason this is backlog entry not fix.
- **What must be settled first:** whether wanted at all, which outcomes, whether other direction (husky mother) patched into vanilla's defs, which this mod never did. Soft link only: `Compatibility/BetterCrossbreeding/`, active only with package.
- **What it costs:** Harmony-based mod keeping per-save dictionary of fathers, so pass must play pregnancy through save and reload. Neither mother-only rule nor birth path run.

## Gate for both

Neither is dependency, neither declared in `loadAfter` unless patch written, each credited on Workshop page and in `WORKSHOP_COMMENTS.md` before anything ships (`PUBLISHING.md`, Mentions).

## Dogs mate (Continued)

**Where it stands, 2026-10-02: never examined.** `Mlie.DogsMate` (2441132298) lists breedable `PawnKindDef`s per `Revolus.DogsMate.AnimalGroupDef`; `PUBLISHING.md` (animal mods, 2026-10-01) asks every animal mod to settle it before `preTest`. To read from installed copy: `Dog` group, whether dalmatian belongs there beside husky. Decision either way goes in `STATUS.md`.

## Original repository

2026-10-02: none found. `github.com/cucumpear` (30 repositories) holds no Dalmatians mod, so pull request `PUBLISHING.md` asks for has no target.

## Decided 2026-10-02

Owner: Nocturnal Animals, no patch. Better Crossbreeding and Dogs mate, patches written (`Mod/Patches/Compat_*.xml`). Two entries above are history; Dogs mate entry done. Still open: Pickle scenario for each patch, and pregnancy played through save for Better Crossbreeding (see cost above).