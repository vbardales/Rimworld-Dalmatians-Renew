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
workflow_stage:  shootGallery[1.0.0]
licence:      silent
licence_port: MIT, limited to the port contributions
licence_at:   LICENSE; Mod/LICENSE; ATTRIBUTION.md
upstream_mod_remotes: N/A (source mod cucumpear/lavie2k's Dalmatians, 1513691963: no <url> in its About.xml; rechecked 2026-10-02: github.com/cucumpear has 30 repositories, none holds this mod, and the nearest (All-The-Puppers for 0.17, AnimalCollabProject, Beasties) contain no Dalmatian def; a repository found later would still not be a licence)
dependencies: none
showcase:     complete
settings_audit: not_applicable
xml_tests:    passed
functional_tests: passed
pickle_tests: 10 features, 52 scenarios, 9 passes plus the removal chain; passes 1 to 6 green (2026-09-24 to 26, French replays 2026-10-02), passes 7 and 8 green 2026-10-02; pass 9 red once on 2026-10-02 (the vanilla-dogs assertion needs Dogs mate absent, fixed by tag @without-dogsmate in 29088f0), replayed green 2026-10-10 (7 of 7, ticket 20261010-225052-995-f244, exitReason passed); removal chain green 2026-10-10 (2 sequences, 1 of 1 each, ticket 20261010-225054-111-21e8, exitReason passed); evidence in Tests/Pickle/Evidence/2026-10-10-p9 and 2026-10-10-removal (moved from a doubled DalmatiansRenew/ path: the -EvidenceDir is relative to the mod, no mod name in front)
audit_revision: 06648bd4c28c0a5e0a53855c82025c02eeceaea2 (2026-10-10 audit, working tree not yet committed)
tested_on:    RimWorld 1.6.4871 rev600 (Pickle, WSL), 2026-10-10: pass 9 and removal chain K; earlier passes 2026-09-24 to 2026-10-02
automated:    44 passed, 0 failed, 0 skipped on 2026-10-10 (scripts/Run-Tests.ps1, was _tools/), tree = 06648bd plus the 2026-10-10 closing pass
manual:       17 scenarios documented in TESTING.md; K reduced to one check (removal) and L dropped (owner, 2026-09-27), A automated in full (training tab) the same day; rows 1 and K-removal of PUBLICATION.md's table still pending in game
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - open: gallery reshoot, ticket 20261017-164819-259-87d0 (07-publication-shots, 316b888, full Backlot map, owner local_e07388d7) in queue; at RUN_DONE read summary.json, open every capture and judge it (garden, salon fire, card), redo weak ones; then reindex 1 garden, 2 salon, 3 card, make Art/Gallery-clean/ and apply the subtitles of PUBLICATION.md "Gallery subtitles" with scripts/Add-Subtitle.ps1 (card gets none), align the tables, then mountPreview
  - partial: AUDIT.md 8.d the `@review` captures: the 24 of 2026-10-02 (p1-french 9, p2-french 14, p9 1) opened 2026-10-11, all read as expected (French labels and tooltips, four facings, leather card, Wildness 0%, puppy beside adult, corpses). Two notes: the p9 capture (2026-10-02-p9) shows a map without any dalmatian in frame, weak evidence for its scenario; under Whaleys Dogs the tooltips read "Dalmatien 1 (femelle dalmatien)" while standalone reads "Dalmatienne 1 (femelle dalmatienne)" (Whaleys kind label, French validated by the owner 2026-10-02). The 2026-10-10 replays wrote no screenshots; the 2026-09 captures are older than the cutoff.
  - unverified: workshop item 3806709979 still carries the description sent by 0.1.0 (lacks IF I GO QUIET, AI-GENERATED, THANKS, Source code on GitHub link); the Markdown block in PUBLICATION.md is complete, the CI sends it at the first publication (2026-09-27 ruling)
  - unverified: rollback target (none before the first publish) and the drafted thank-you comments, posted only once the item is public
session:      local_e07388d7-8c73-4619-af3d-44de8bbb400f
updated:      2026-10-15
code_review_sha: 103690ac09387031cbffd0d1327e1903bd17acd1
protocols_read_sha: fdeda717e510098fb1f37e9f3b4ace9975dac9bc
social_preview_sha256: 2dbfb607196485fa1538fe924c9b203762a143faea416e3e98ebbcf7f90d6bbf
---
# Dalmatians Renew: status

## Current state (2026-10-10 audit)

Stage: **`shootGallery[1.0.0]`**, back from mountPreview 2026-10-12: director (this session) judged picture 1 and 2 too weak, reshooting series on Sanctuary (07-publication-shots.feature rewritten, wsl-deps.sanctuary.map). Before: 8.n done (replays green, 8.d captures read, 8.m recorded). Audit text below written at `playTests[1.0.0]` 2026-10-10. Everything up to `writeTests` holds: offline suite re-run today (44 green), translations `complete` (French validated by owner 2026-10-02), Pickle suites written, four animal integrations settled (ADS 2 patch, Nocturnal Animals none by decision, Dogs mate patch, Better Crossbreeding patch). No `Source/`: no build, no C# code review beyond `Mod/` XML.

Two replays (pass 9, removal chain) green 2026-10-10. Keeping it at `playTests`: social preview upload and reread of protocols changed since a5c7cf48. 8.m done 2026-10-11 (no C#; every patch file of `Mod/` read, one finding on scripts/Run-Tests.ps1 fixed in 103690a), `code_review_sha` recorded. No manual test left for owner (row 1 dropped, row 4 automated as K, owner 2026-10-02).

Closing pass done in working tree 2026-10-10, not committed: `_tools/` renamed `scripts/`, stale `_tools/preview/Preview.html` removed (AGENTS.md rule); `.build/` renamed `build/` (Directory.Build.props, .gitignore, Check-Steps.ps1); `Mod/About/ModIcon.png` regenerated (Lanczos, 128 px, 20435 bytes), Preview chain re-rendered (`Mod/About/Preview.png`, `Art/Gallery/0-preview.png` byte copy, `Art/Preview.ico`) because owner's `Art/ModIcon-source.png` newer than derivatives. Three `Art/` files she changed left as she made them.

Replays of 2026-10-10: `docs/runs/2026-10-10-replays.md`. Journal up to 2026-10-10: `docs/runs/status-journal-2026-10-10.md` (former dated sections, text unchanged).

## Gallery

| Index | File | Validated |
| --- | --- | --- |
| 0 | `0-preview.png` (byte copy of `Mod/About/Preview.png`, re-rendered 2026-10-10) | copy of the Preview |
| 1 | `1-the-dalmatian-and-its-puppy.jpg` | owner, 2026-09-27 |
| 2 | `2-the-information-card.png` | owner, 2026-09-29 |
Order (9.c, 2026-10-12): index 0 is Preview; Steam shows 1 large, so most demonstrative image goes there: adult and puppy side by side (animal, colouring, life stages in one frame), then 2, information card, proves species data (Wildness 0%, source line). Indexes 0 to 2 contiguous. Owner opened and looked at every image on dates above; `cmp` confirms `0-preview.png` equals `Mod/About/Preview.png`.

## Pickle tickets

Filed 2026-10-10, both RUN_DONE green (exit 0): 20261010-225052-995-f244 (pass 9 replay, 7 of 7), 20261010-225054-111-21e8 (removal chain K, seq1 and seq2, 1 of 1 each). Tree no longer frozen. Registered with Ticket Manager 2026-10-10 as `local_58ad495b-63fb-4c70-ac11-4bf0c025db07`.

## Audit coverage, 2026-10-10 (revision 06648bd + closing pass)

- Dependencies (4): none hard. `loadAfter` Mlie.WhaleysDogs (LoadFolders `IfModActive` Compatibility/WhaleysDogs), `loadBefore` SamBucher.ADogSaidAnimalProsthetics2, `incompatibleWith` cucumpear.dalmatians. Optional guarded patches: ADS 2, Dogs mate (2441132298), Better Crossbreeding (3520675842); Nocturnal Animals none by decision. DLC: none; `supportedVersions` 1.6.
- Settings (5): `not_applicable`, no C#, no page, no shortcut.
- Translations (6): `scripts/Check-DefInjected.ps1 -TransMod DalmatiansRenew/Mod`: 25 keys, 0 errors, `WD_Dalmatian` keys UNVERIFIED (target created by patch); `FRENCH_REVIEW.md` regenerated at 06648bd; French validated by owner 2026-10-02.
- Distributed root: `Mod/ATTRIBUTION.md` and `Mod/LICENSE` byte-identical to root copies; `Mod/desktop.ini` gitignored; `*.dds` untracked.
- Em dash: `Mod/About/About.xml` and PUBLICATION.md clean; README.md and CHANGELOG.md (append-only) carry older ones, left as is.
- Protocols read: AGENTS, PICKLE, PUBLISHING, TRANSLATIONS, MOD_SETTINGS, STYLE_RIMWORLD, WORKSHOP_COMMENTS (section Writing a comment); `protocols_read_sha` written, `Check-Status.ps1`: 0 error, 0 warning.