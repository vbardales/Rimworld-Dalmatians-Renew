---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Dalmatians Renew (unofficial)
packageId:    nelim.dalmatians
repo:         Rimworld-Dalmatians-Renew
remote:       https://github.com/vbardales/Rimworld-Dalmatians-Renew
local_path:   C:\Users\nelim\Documents\rimworld\DalmatiansRenew
visibility:   public
upstream_visibility: public (Steam API visibility=0; banned=0; checked 2026-09-12)
detached:     yes
maintainer:   Claude Code (the session named for this mod); Codex worked on it earlier
workflow_stage: playTests[1.0.0]
licence:      silent
licence_port: MIT, limited to the port contributions
licence_at:   LICENSE; Mod/LICENSE; ATTRIBUTION.md
upstream_mod_remotes: N/A (source mod cucumpear/lavie2k's Dalmatians, 1513691963: no <url> in its About.xml; rechecked 2026-10-02: github.com/cucumpear has 30 repositories, none holds this mod, and the nearest (All-The-Puppers for 0.17, AnimalCollabProject, Beasties) contain no Dalmatian def; a repository found later would still not be a licence)
dependencies: none
showcase:     complete
settings_audit: not_applicable
xml_tests:    passed
functional_tests: unverified
pickle_tests: 10 features, 52 scenarios, 9 passes plus the removal chain; passes 1 to 6 green (2026-09-24 to 26, French replays 2026-10-02), passes 7 and 8 green 2026-10-02; pass 9 red once on 2026-10-02 (the vanilla-dogs assertion needs Dogs mate absent, fixed by tag @without-dogsmate in 29088f0), replayed green 2026-10-10 (7 of 7, ticket 20261010-225052-995-f244, exitReason passed); removal chain green 2026-10-10 (2 sequences, 1 of 1 each, ticket 20261010-225054-111-21e8, exitReason passed); evidence in DalmatiansRenew/DalmatiansRenew/Tests/Pickle/Evidence/2026-10-10-p9 and 2026-10-10-removal (nested path, launcher quirk)
audit_revision: 06648bd4c28c0a5e0a53855c82025c02eeceaea2 (2026-10-10 audit, working tree not yet committed)
tested_on:
automated:    44 passed, 0 failed, 0 skipped on 2026-10-10 (scripts/Run-Tests.ps1, was _tools/), tree = 06648bd plus the 2026-10-10 closing pass
manual:       17 scenarios documented in TESTING.md; K reduced to one check (removal) and L dropped (owner, 2026-09-27), A automated in full (training tab) the same day; rows 1 and K-removal of PUBLICATION.md's table still pending in game
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - unverified: AUDIT.md 8.m code review (`code_review_sha` absent: review from the first commit, no tag exists yet); the two replays are green
  - unverified: AUDIT.md 8.d the `@review` captures of the passes played since 2026-10-02 opened and looked at
  - unverified: social preview image (public repository): Mod/About/Preview.png was re-rendered on 2026-10-10 after the owner changed Art/ModIcon-source.png (2026-10-04); upload it (Settings, Social preview) and record `social_preview_sha256` after the commit
  - unverified: workshop item 3806709979 still carries the description sent by 0.1.0 (lacks IF I GO QUIET, AI-GENERATED, THANKS, Source code on GitHub link); the Markdown block in PUBLICATION.md is complete, the CI sends it at the first publication (2026-09-27 ruling)
  - unverified: rollback target (none before the first publish) and the drafted thank-you comments, posted only once the item is public
session:      local_e7fdeacc-7649-4702-9f00-45be2663ced1
updated:      2026-10-10
protocols_read_sha: a5c7cf48b349ae00e7d28fd643e852dc860dfaf2
---

# Dalmatians Renew: status

## Current state (2026-10-10 audit)

Stage retained: **`playTests[1.0.0]`**. Everything up to `writeTests` holds: offline suite re-run today (44 green), translations `complete` (French validated by the owner 2026-10-02), Pickle suites written, the four animal integrations settled (ADS 2 patch, Nocturnal Animals none by decision, Dogs mate patch, Better Crossbreeding patch). No `Source/`: no build, no code review of C# to do beyond `Mod/` XML.

The two replays (pass 9, removal chain) came back green on 2026-10-10. What keeps it at `playTests`: 8.m and 8.d (reading the `@review` captures). No manual test is left for the owner (row 1 dropped, row 4 automated as K, owner 2026-10-02).

Closing pass done in the working tree on 2026-10-10, not committed yet: `_tools/` renamed `scripts/` and the stale `_tools/preview/Preview.html` removed (AGENTS.md rule); `.build/` renamed `build/` (Directory.Build.props, .gitignore, Check-Steps.ps1); `Mod/About/ModIcon.png` regenerated (Lanczos, 128 px, 20435 bytes) and the Preview chain re-rendered (`Mod/About/Preview.png`, `Art/Gallery/0-preview.png` byte copy, `Art/Preview.ico`) because the owner's `Art/ModIcon-source.png` is newer than its derivatives. The three `Art/` files she changed were left as she made them.

Journal up to 2026-10-10: `docs/runs/status-journal-2026-10-10.md` (the former dated sections, text unchanged).

## Gallery

| Index | File | Validated |
| --- | --- | --- |
| 0 | `0-preview.png` (byte copy of `Mod/About/Preview.png`, re-rendered 2026-10-10) | copy of the Preview |
| 1 | `1-the-dalmatian-and-its-puppy.jpg` | owner, 2026-09-27 |
| 2 | `2-the-information-card.png` | owner, 2026-09-29 |

## Pickle tickets

Filed 2026-10-10, both RUN_DONE green (exit 0): 20261010-225052-995-f244 (pass 9 replay, 7 of 7), 20261010-225054-111-21e8 (removal chain K, seq1 and seq2, 1 of 1 each). Tree no longer frozen. Registered with the Ticket Manager on 2026-10-10 as `local_58ad495b-63fb-4c70-ac11-4bf0c025db07`.

## Audit coverage, 2026-10-10 (revision 06648bd + closing pass)

- Dependencies (4): none hard. `loadAfter` Mlie.WhaleysDogs (LoadFolders `IfModActive` Compatibility/WhaleysDogs), `loadBefore` SamBucher.ADogSaidAnimalProsthetics2, `incompatibleWith` cucumpear.dalmatians. Optional guarded patches: ADS 2, Dogs mate (2441132298), Better Crossbreeding (3520675842); Nocturnal Animals none by decision. DLC: none; `supportedVersions` 1.6.
- Settings (5): `not_applicable`, no C#, no page, no shortcut.
- Translations (6): `scripts/Check-DefInjected.ps1 -TransMod DalmatiansRenew/Mod`: 25 keys, 0 errors, the `WD_Dalmatian` keys UNVERIFIED (target created by a patch); `FRENCH_REVIEW.md` regenerated at 06648bd; French validated by the owner 2026-10-02.
- Distributed root: `Mod/ATTRIBUTION.md` and `Mod/LICENSE` byte-identical to the root copies; `Mod/desktop.ini` is gitignored; `*.dds` untracked.
- Em dash: `Mod/About/About.xml` and PUBLICATION.md clean; README.md and CHANGELOG.md (append-only) carry older ones, left as they are.
- Protocols read: AGENTS, PICKLE, PUBLISHING, TRANSLATIONS, MOD_SETTINGS, STYLE_RIMWORLD, WORKSHOP_COMMENTS (section Writing a comment); `protocols_read_sha` written, `Check-Status.ps1`: 0 error, 0 warning.
