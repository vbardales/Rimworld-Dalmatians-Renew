---
mod:          Dalmatians Renew
packageId:    nelim.dalmatiansrenew
repo:         Rimworld-Dalmatians-Renew
visibility:   public
detached:     yes
stage:        done
licence:      silent
licence_at:   four places; made public because the source is dead and silent
dependencies: none
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: the thirteen scenarios in TESTING.md, none played
  - unverified: C and D, the A Dog Said 2 patch and the load order, which nothing outside the game settles
  - defect: the dessicated corpse has only its _east texture, the other two faces are rotations
session:      local_e7fdeacc-7649-4702-9f00-45be2663ced1
updated:      2026-09-12, the mod's own session
---

# Dalmatians Renew — status

Status card, read by a sweep over every mod rather than by asking each thread one at a time. It
lives at the root, never inside `Mod/`, so Steam never receives it.

This card is in English, and it is the only one that is: the rest of the collection keeps the
French keys the sweep was written against. The repository around it — README, changelog, testing
notes, attribution, every commit message — is English throughout, and the card was the one file
out of step.

The fields above were deduced from disk on 2026-09-12. Three could not be, and were waiting for
the session that holds this mod. They were filled the same day:

- **`stage`** — `done`, confirmed. The port is whole: wildness moved to a stat, the A Dog Said
  patch rewritten onto the three categories behind a `PatchOperationConditional`, the load order
  declared, sixteen French keys, and two pictures made for the port. `_tools/Run-Tests.ps1` passes
  twenty-eight tests with nothing failed and nothing skipped, and `main` sits at the same commit as
  `origin`. What is left is not development: it is verification in the game, and then publication.
- **`tested_on`** — left empty, and that is accurate rather than an omission. This dalmatian has
  never been seen running. No dog tamed, no information card read, no operations tab opened.
- **`remaining`** — the catch-all line is replaced by three real ones, now that `TESTING.md` says
  precisely what has not been verified. C and D stand apart because they are the only two nothing
  outside the game can settle: the patch's effect lives in a list A Dog Said 2 builds at load time,
  and both outcomes are silent. The `defect` line notes the one known gap, inherited from the
  source in 2018 and left alone — repairing it would be drawing rather than porting.

The `workshop` field is empty because the item does not exist yet: `About/PublishedFileId.txt` was
dropped, since it named cucumpear's and lavie2k's.

The three categories `remaining` takes: `feature` for something missing from the first pass, `defect`
for a known fault not repaired, `unverified` for what could not be checked.

The `session` field was not touched: it names the sidebar session group, not this conversation.

Vocabulary for `licence`: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.
