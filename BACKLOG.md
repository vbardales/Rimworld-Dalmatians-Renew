# Backlog

Ideas for this mod that are not started. Each entry says what the feature would be, what already covers part
of it, and what has to be settled before the first line of code. Nothing here is promised.

This mod is a port, and its balance was deliberately left as cucumpear and lavie2k made it
(`ATTRIBUTION.md`). An idea earns a place here only if it serves that dog without changing what the port
promises. Anything shipped is in `CHANGELOG.md`; anything to check in play is in `TESTING.md`.

---

## Nocturnal Animals (Continued)

**Where it stands, 2026-09-25: nothing to do, and nothing is claimed.** Workshop `2269731409`, package
`Mlie.XNDNocturnalAnimals`, read from the installed copy (1.6 folder). It gives an animal a body clock through a
def extension, `NocturnalAnimals.ExtendedRaceProperties` with a `bodyClock`, and ships patches for vanilla wolves,
foxes, deer, elk, wild boar and other wild animals. **Its 1.6 patches name no husky, labrador or yorkshire
terrier**, and its own description says an animal that is not patched is diurnal. The dalmatian is therefore a
diurnal animal beside vanilla's dogs, which is what a domestic dog is in the game already.

- **Why it stays out:** a body clock would be a change of behaviour that neither the original nor vanilla's dogs
  have. It would also add a soft link to a mod that has no bearing on this one.
- **What would have to be settled first:** whether the owner wants the dalmatian to differ from the husky. If so,
  a patch in `Compatibility/` with `PatchOperationAddModExtension`, read only when the package is active
  (`LoadFolders.xml`, `IfModActive`), exactly as the WhaleysDogs folder is. One pass, one scenario reading the
  extension off the live def.
- **Not verified:** what the mod's card shows for an animal without the extension, and what its settings page
  lists for the dalmatian. Neither was run; only its files were read.

## Better Crossbreeding

**Where it stands, 2026-09-25: nothing happens by default, and a feature is possible.** Workshop `3520675842`,
package `DizzyEevee.BetterCrossbreeding`, read from the installed copy. It is the only installed mod whose name
says crossbreeding; if another one was meant, this entry is for the wrong mod. It adds a def extension,
`DZY.Crossbreeding.Extension` with a list of outcomes, and reads it **on the mother's PawnKindDef only**. It ships
no outcomes: its `Example/` folder is not loaded (`LoadFolders.xml` reads `/` and `1.6`). An animal without the
extension breeds as vanilla does, so the dalmatian is unaffected today.

Vanilla 1.6 has its own field, `canCrossBreedWith` on the race, which Core uses for the thrumbo and Odyssey for
one more animal. Neither field is set on a dog.

- **The feature, if wanted:** a dalmatian mother by a husky or a labrador father giving a chosen kind (paternal,
  maternal, random or a weighted list), and the reverse for the husky and labrador. It is new gameplay, not part
  of the original, and it is the reason this is a backlog entry and not a fix.
- **What would have to be settled first:** whether it is wanted at all, which outcomes, and whether the other
  direction (a husky mother) is patched into vanilla's defs, which this mod has never done. A soft link only:
  `Compatibility/BetterCrossbreeding/`, active only with the package.
- **What it costs:** a Harmony-based mod that keeps a per-save dictionary of fathers, so a pass would have to play
  a pregnancy through a save and reload. Neither the mother-only rule nor the birth path was run.

## Gate for both

Neither is a dependency, neither would be declared in `loadAfter` unless a patch is written, and each would be
credited on its Workshop page and in `WORKSHOP_COMMENTS.md` before anything ships (`PUBLISHING.md`, Mentions).
