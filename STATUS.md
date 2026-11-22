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
workflow_stage:  writeShotlist[1.0.0]
ecosystem_line: 1.0   # PiI DELTA 2026-11-23 (docs/inventory/ecosystem-steam/DalmatiansRenew.md, commit 24c60ac); AUDIT 2.h
licence:      silent
licence_port: MIT, limited to the port contributions
licence_at:   LICENSE; Mod/LICENSE; ATTRIBUTION.md
upstream_mod_remotes: N/A (source mod cucumpear/lavie2k's Dalmatians, 1513691963: no <url> in its About.xml; rechecked 2026-10-02: github.com/cucumpear has 30 repositories, none holds this mod, and the nearest (All-The-Puppers for 0.17, AnimalCollabProject, Beasties) contain no Dalmatian def; a repository found later would still not be a licence)
dependencies: none
showcase:     complete
settings_audit: not_applicable
xml_tests:    passed
functional_tests: passed
pickle_tests: 10 features, 52 scenarios, 9 passes plus the removal chain; passes 1 to 6 green (2026-09-24 to 26, French replays 2026-10-02), passes 7 and 8 green 2026-10-02; pass 9 red once on 2026-10-02 (the vanilla-dogs assertion needs Dogs mate absent, fixed by tag @without-dogsmate in 29088f0), replayed green 2026-10-10 (7 of 7, ticket 20261010-225052-995-f244, exitReason passed); removal chain green 2026-10-10 (2 sequences, 1 of 1 each, ticket 20261010-225054-111-21e8, exitReason passed); evidence in Tests/Pickle/Evidence/p9-2026-10-10 and removal-2026-10-10-seq1 and -seq2 (minified greens; fresh runs land in Tests/Pickle/Inbox/<run>, the -EvidenceDir of every ticket; the -EvidenceDir is relative to the mod, no mod name in front)
audit_revision: 06648bd4c28c0a5e0a53855c82025c02eeceaea2 (2026-10-10 audit, working tree not yet committed)
tested_on:    2026-11-18 pickle c87e7f2 (RimWorld 1.6, Pickle, WSL): ticket 8fb4 French under WhaleysDogs green; text greens dd35 (French, 00a22c6) and e903 (English, 784ff5b); earlier 2026-10-10 pass 9 and removal chain K, passes 2026-09-24 to 2026-10-02
automated:    36 passed, 0 failed, 0 skipped on 2026-11-02 (Tests/Run-Tests.ps1, restored from d69dacf^ and cut per LOCAL-SCRIPTS-CUT: the generic def, field, reference and French-coverage tests now belong to the shared checks; Tests/WhaleysDogs.Tests.ps1 and Tests/Crossbreeding.Tests.ps1 run inside it), tree = HEAD
manual:       17 scenarios documented in TESTING.md; K reduced to one check (removal) and L dropped (owner, 2026-09-27), A automated in full (training tab) the same day; row 1 dropped (2026-10-02), K-removal automated and green 2026-10-10 (ticket 21e8): no manual validation left, as PUBLICATION.md says
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - 2026-11-23 second replay (run by the session after PiI delta 24c60ac, ecosystem_line 1.0 written): 1.a to 8.n done or n/a, first open 9.0 (last plan rating 3.5 per scene, scenes 2 to 4 of the v4 shotlist to rewrite, sync-nsb-npt due since 2026-11-22). Stage writeShotlist[1.0.0] written 2026-11-23 by replay-audit ecosystem.. typed by Virginie. 8.m done 2026-11-23 (revue du diff 784ff5b..HEAD, About.xml description text only, code_review_sha set); tested_on refreshed (8fb4, dd35, e903 green); Docs/PROTOCOLS-READ.md deleted. Also due: STATUS.md trim (47 KB).
  - Audit state 2026-11-23: 8.a to 8.m closed (greens dd35 French, e903 English, 8fb4 French under WhaleysDogs, 2026-10-10 passes; Mod/ diff since is text only plus OptionalCompat.xml). Real publish waits for STEAM_REFRESH_TOKEN (Virginie). social_preview_sha256 stale. Older journal lines deleted 2026-11-23 (git keeps them).
  - Gallery state 2026-11-17 (fixture z3 `Nelims-tribe-decor-mods-z3` via wsl-deps.sanctuary-z3.map; scenarios of 07-publication-shots.feature): scene 1 v7 ticket 84ee ACCEPT (replaces c1); scene 2 v7 ticket 8a47 REDO-light (Rex faces the camera, Pup nose to kibble, but Nelim head cut at the top: raise centre z or root size so head and bed fit, refile alone); scene 3 c3 candidate (ticket 85d5, Pup not visibly wet is a limit, say so); scene 4 c4 candidate (ticket cf16, all three face the camera, fire, bed behind). Candidates c1 to c4 in Art/Gallery-clean and Art/Gallery (1280x720, subtitled 2026-11-15, score-gallery plan 3.5 each then). Rules in force: P1 carrying Nelim walks in profile, P2 at most one animal faces the camera (step `the animal X stands at (x, z) facing South`), P3 Pup within 2 cells of Rex, P4 hay is the thread; GALLERY.md f vary orientations; final names without `c` prefix, no reindex pass. NSB plans to rebuild the Sanctuary save as Nelims-tribe-v2 (RECONSTRUCTION-SAUVEGARDE.md): z3 stays valid until it exists, then repoint 07 and replay. Evidence kept: Tests/Pickle/Evidence 2026-11-14-gallery-1e, -2b, 2026-11-15-gallery-1f, -3b, -4h.
  - open (TM missions, 2026-11-08, after the gallery): replace the Run-Checks chain by scripts/Run-OfflineChecks.ps1 -ModRoot <mod> (keep specific checks), new test shape (Tests/Rule-OwnValues.ps1, generated Test-Mod.ps1), OptionalCompat once, translation review (Make-TranslationReview.ps1, FRENCH_REVIEW.md old name), tell Audit when done; gallery reviewed ONCE at the end by the owner (all candidates in one message), subtitles with scripts/Add-Subtitle.ps1 after acceptance; runner auto, never -Runner azure; 1.7 questions to Audit local_10336624.
  - 2026-10-25: gesture recipe PROVEN by NPT ticket 531b (fix 6c8ba9d): forced walk or haul, pause, advance 20 ticks = about one cell. Scenarios of 07-publication-shots.feature rewritten on it (4 photographs + card, cells and 20 ticks are first guesses, not played). Next: after c5c5 is read, file small tickets one scenario at a time, open each capture against its shotlist v2 line, adjust cells and ticks. Not proven by NPT: jar ingestion (35f9), collar diagnostic.
  - ruled 2026-10-25 by owner: clothes and expressions of shotlist v2 are suggestions, default expression smiling; colonists other than NSB's need special authorization; special requests go to NPT first, owner arbitrates if NPT refuses.
  - decided 2026-10-25, probe ebfe: failed ("Rex should wear 'Apparel_leatherdogcollar'; it wears " nothing), the dalmatian is not fitted: shots stay vanilla, no patch in this mod, no Animal Apparel Collars credit.
  - done 2026-11-03: Preview re-rendered after echo.width/height and echo.color left the config (echo fitted in its max box, right of the panel, no clipping or overlap; badge now bottom-right by renderer default); resume-mod 7b.
  - open: Inbox triage after each run: green minified into Evidence with a RELEASE.md, red studied then deleted or parked with a RELEASE.md naming the scenario; Evidence trims proposed 2026-10-19 (p8, rename-p3, rename-p4: drop "loading the colony logs nothing") not done.
  - partial: AUDIT.md 8.d the `@review` captures: the 24 of 2026-10-02 (p1-french 9, p2-french 14, p9 1) opened 2026-10-11, all read as expected (trimmed 2026-10-18 to 4 JPEG in Tests/Pickle/Evidence, the weak p9 capture deleted after the green replay of 2026-10-10; replay the scenario if one more is needed) (French labels and tooltips, four facings, leather card, Wildness 0%, puppy beside adult, corpses). Two notes: the p9 capture (2026-10-02-p9) shows a map without any dalmatian in frame, weak evidence for its scenario; under Whaleys Dogs the tooltips read "Dalmatien 1 (femelle dalmatien)" while standalone read "Dalmatienne 1 (femelle dalmatienne)" before 2026-11-13 (owner: "dalmatien" is invariable, so "femelle dalmatien"; labels fixed, standalone now reads "Dalmatien 1 (femelle dalmatien)") (Whaleys kind label, French validated by the owner 2026-10-02). The 2026-10-10 replays wrote no screenshots; the 2026-09 captures are older than the cutoff.
  - done 2026-11-02 (Audit ruling): 7.b offline suite restored under Tests/ (deleted by d69dacf, 10.e moves scripts to Tests/), cut to 36 mod-specific tests, 36 green; LOCAL_SCRIPTS rows relisted, Audit to validate. Next: replay-audit --force.
  - unverified: workshop item 3806709979 still carries the description sent by 0.1.0 (lacks IF I GO QUIET, AI-GENERATED, THANKS, Source code on GitHub link); the Markdown block in PUBLICATION.md is complete, the CI sends it at the first publication (2026-09-27 ruling)
  - unverified: rollback target (none before the first publish) and the drafted thank-you comments, posted only once the item is public
session:      local_e07388d7-8c73-4619-af3d-44de8bbb400f
updated:      2026-11-23
code_review_sha: b17b6ea03d74be7d935450a465cedaf7610d89ba
protocols_read_sha: 9b5e5946582d6e3cf408d28fb53b9c29d27385c3
social_preview_sha256: eed949dc392a63b2f56299ae1eeea7dc0d903cabe76da539748cf25557c5ae42
---
# Dalmatians Renew: status

## Current state (2026-10-10 audit)

Stage: **`shootGallery[1.0.0]`**, back from mountPreview 2026-10-12: director (this session) judged picture 1 and 2 too weak, reshooting series on Sanctuary (07-publication-shots.feature rewritten, wsl-deps.sanctuary.map). Before: 8.n done (replays green, 8.d captures read, 8.m recorded). Audit text below written at `playTests[1.0.0]` 2026-10-10. Everything up to `writeTests` holds: offline suite re-run today (44 green), translations `complete` (French validated by owner 2026-10-02), Pickle suites written, four animal integrations settled (ADS 2 patch, Nocturnal Animals none by decision, Dogs mate patch, Better Crossbreeding patch). No `Source/`: no build, no C# code review beyond `Mod/` XML.

Two replays (pass 9, removal chain) green 2026-10-10. Keeping it at `playTests`: social preview upload and reread of protocols changed since a5c7cf48. 8.m done 2026-10-11 (no C#; every patch file of `Mod/` read, one finding on Tests/Run-Tests.ps1 fixed in 103690a), `code_review_sha` recorded. No manual test left for owner (row 1 dropped, row 4 automated as K, owner 2026-10-02).

Closing pass done in working tree 2026-10-10, not committed: `_tools/` renamed `scripts/`, stale `_tools/preview/Preview.html` removed (AGENTS.md rule); `.build/` renamed `build/` (Directory.Build.props, .gitignore, Check-Steps.ps1); `Mod/About/ModIcon.png` regenerated (Lanczos, 128 px, 20435 bytes), Preview chain re-rendered (`Mod/About/Preview.png`, `Art/Gallery/0-preview.png` byte copy, `Art/Preview.ico`) because owner's `Art/ModIcon-source.png` newer than derivatives. Three `Art/` files she changed left as she made them.

Replays of 2026-10-10: `docs/runs/2026-10-10-replays.md`. Journal up to 2026-10-10: `docs/runs/status-journal-2026-10-10.md` (former dated sections, text unchanged).

## Gallery

| Index | File | Validated |
| --- | --- | --- |
| 0 | `0-preview.png` (byte copy of `Mod/About/Preview.png`, re-rendered 2026-10-10) | copy of the Preview |
| 1 | `1-the-dalmatian-and-its-puppy.jpg` | owner, 2026-09-27 |
| 2 | `2-the-information-card.png` | owner, 2026-09-29 |
Order (9.c, 2026-10-12): index 0 is Preview; Steam shows 1 large, so most demonstrative image goes there: adult and puppy side by side (animal, colouring, life stages in one frame), then 2, information card, proves species data (Wildness 0%, source line). Indexes 0 to 2 contiguous. Owner opened and looked at every image on dates above; `cmp` confirms `0-preview.png` equals `Mod/About/Preview.png`.

## Gallery shotlist v4 (2026-11-13, amends v3 after the capture of ticket 6d59; Opus director pass kept in part)

Lessons of 6d59 (scene 1 on z3, REDO): a carried item hides Nelim's face when she faces the camera; Rex seen from behind; Pup tiny at the top; an unidentified solid green rectangle in the lower left (asked of NPT 2026-11-13); two beds in frame (z3 own wooden bed at the right, our GSAnimalBedBig). The daylily field, torches and light were good (b ok).

Rules added: P1 Nelim carrying an item walks in profile (East or West), never facing the camera; facing the camera only empty-handed. P2 at most one animal faces the camera per scene (Opus: a second one posed for the photo breaks criterion e), by the NPT step `the animal X stands at (x, z) facing South` as the last gesture, only on the animal meant to stand still; to be proven on the capture (it may cancel the stride). P3 Pup within 2 cells of Rex, lower half of the frame. P4 hay is the thread: in her arms in 1, on the bed in 2, under the sleeping Pup in 4 (no hay pre-placed on the bed in 1).

| # | change from v3 | status |
|---|---|---|
| 1 arrival | played as scenario: Hay stack (152,102) hauled East to (156,102) ((157,102) holds the z3 TorchLamp, not standable: ticket 7116 red), Nelim from (151,102) facing East, 60 ticks; Rex walks to (155,101) then stands facing South; Pup walks (154,104) to (153,100); bed GSAnimalBedBig (154,99) empty; zoom 3.2 on (155,101) (Rex 15 percent: j ok at 268 px). Frame may move once NPT names the green object | scenario and header rewritten 2026-11-13, Check-ShotlistVsScenario OK, ticket 7116 red at the haul (cell (157,102) not standable), refiled as ticket 20261113-225610-017-6442 (haul to (156,102), Inbox 2026-11-13-gallery-1b) |
| 2 breakfast | Nelim walks West (not South) with the Kibble toward the dogs; Pup nose to the kibble, not facing the camera; Rex the one facing the camera; hay still on the bed | header and scenario to rewrite after capture 1 is read |
| 3 towel | Nelim walks East or West with the Cloth, not South; Pup facing the camera, dripping, in stride | same |
| 4 fire | instant just AFTER the log drops: Nelim empty-handed facing the camera, her face clear (series closes on it); Rex faces the fire and Nelim; Pup asleep on the hay in the bed | same |

Plan rated 2026-11-13 (score-gallery, no capture yet: rating the plan): scene 1 = 5 (j was weak at zoom 4, Rex 12 percent at 268 px = 18 px, fixed by zoom 3.2 on (155,101)); scenes 2 to 4 keep their v3 text (5) until their header and scenario are rewritten with the amendments above after capture 1 is read; series k ok (one story, opening 1 wide, closing 4 close, hay thread); mean 5. Not verified: stride kept after the facing step (P2), the green object (NPT).

## NSB (sync 2026-11-23)

Places read: 2026-11-23 (git log of NSB docs since 2026-11-18: no change to SANCTUAIRE-LIEUX, SANCTUAIRE-CASES, EMBELLISSEMENT-LIEUX). Tribe read: 2026-11-23 (no change to NSB-ROSTER, APPARENCES-CANON, CATALOGUE-ANIMAUX or Nelim's profile; 2026-11-22 commits: bridge railings in VALIDE.md, Jiro wardrobe photos, Miel and Soren roster steps, none used here; Nelim validated, unchanged). Steps read: 2026-11-23 (PickleTools Docs/steps.md since 2026-11-18: new ScreenshotStudio steps for status icons, lamp glow, sun dimming, taming and wild designation, ClickDiagnostics logs, DefFieldSteps `has no value`, ColonistRace `X turns toward Y` (renamed from `X faces Y`), zoom floor 0.3 to 0.1; none called by our scenarios, no rename of a step we use; Check-Steps rerun after this sync). NSB 2026-11-18 plan to rebuild the Sanctuary save as Nelims-tribe-v2 (RECONSTRUCTION-SAUVEGARDE.md): nothing built; z3 fixture stays valid until v2 exists, then the gallery scenarios (07, DepMap wsl-deps.sanctuary-z3.map) repoint and replay. No shotlist or scenario change from this sync; no owner question (rule 2 or 3): Nelim and the mod's own dalmatians only.

| Place | Shots | Changes for the gallery | Last read |
| --- | --- | --- | --- |
| flower-garden (154,110) | 1, 2 | TorchLamp, GSAnimalBedBig, Hay, daylilies, tall grass; animals removed | 2026-11-08 |
| water-garden (167,173) | 3 | daylilies and tall grass on the west bank; ducks stay | 2026-11-08 |
| sofa-corner (187,122), hearth-hall | 4 | Campfire (190,120), TorchLamp (189,123), GSAnimalBedBig; animals removed | 2026-11-08 |

| Colonist | Shots | Outfit per shot | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Nelim | 1 to 4 | Apparel_CollarShirt (22,110,115) and Apparel_Pants (74,58,50) all day: free outfit, continuity; MouthSmile and LidCheerful, scene scenery freedom (smile); 4: MouthLipsSmallSmile, LidNormal | 2026-11-08 (VALIDE.md; profile not reopened) | none (hairstyle override removed) |

| Animal | Shots | Outfit | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Rex, Pup (CCPDalmatian, the mod's animal) | 1 to 4 | none | n/a (mod animal, authorized by default 2026-11-07) | none |

| Included animal | Shots |
| --- | --- |
| CCPDalmatian (adult Rex, puppy Pup) | 1, 2, 3, 4 |

## Pickle tickets

Filed 2026-10-10, both RUN_DONE green (exit 0): 20261010-225052-995-f244 (pass 9 replay, 7 of 7), 20261010-225054-111-21e8 (removal chain K, seq1 and seq2, 1 of 1 each). Tree no longer frozen. Registered with Ticket Manager 2026-10-10 as `local_58ad495b-63fb-4c70-ac11-4bf0c025db07`.

## Audit coverage, 2026-10-10 (revision 06648bd + closing pass)

- Dependencies (4): none hard. `loadAfter` Mlie.WhaleysDogs (LoadFolders `IfModActive` Compatibility/WhaleysDogs), `loadBefore` SamBucher.ADogSaidAnimalProsthetics2, `incompatibleWith` cucumpear.dalmatians. Optional guarded patches: ADS 2, Dogs mate (2441132298), Better Crossbreeding (3520675842); Nocturnal Animals none by decision. DLC: none; `supportedVersions` 1.6.
- Settings (5): `not_applicable`, no C#, no page, no shortcut.
- Translations (6): `scripts/Check-DefInjected.ps1 -TransMod DalmatiansRenew/Mod`: 25 keys, 0 errors, `WD_Dalmatian` keys UNVERIFIED (target created by patch); `FRENCH_REVIEW.md` regenerated at 06648bd; French validated by owner 2026-10-02.
- Distributed root: `Mod/ATTRIBUTION.md` and `Mod/LICENSE` byte-identical to root copies; `Mod/desktop.ini` gitignored; `*.dds` untracked.
- Em dash: `Mod/About/About.xml` and PUBLICATION.md clean; README.md and CHANGELOG.md (append-only) carry older ones, left as is.
- Protocols read: AGENTS, PICKLE, PUBLISHING, TRANSLATIONS, MOD_SETTINGS, STYLE_RIMWORLD, WORKSHOP_COMMENTS (section Writing a comment); `protocols_read_sha` written, `Check-Status.ps1`: 0 error, 0 warning.

## Ecosystem

2026-11-13, PiI (`docs/inventory/ecosystem-steam/DalmatiansRenew.md` of the protocols repository): no duplicate, no fork. The original, Dalmatians 1513691963 (`cucumpear.dalmatians`), is tagged [Retired] since 2022-10, versions 1.0 to 1.4, dead for 1.6: this mod is the only 1.6 Dalmatian. Corpus scan of this mod's defNames: the original (2 shared, expected), WhaleysDogs and WhaleysDogs (Continued) 2274606936 as weak hits (0 shared defName). Optional patch targets are alive for 1.6: WhaleysDogs (Continued), A Dog Said Animal Prosthetics 2 3238353862, Dogs mate 2441132298. Note: Dog Retexture 3284798441 may recolour dog coats, a Pickle check is worth considering (not filed, needs the owner's call on installing it). Nothing subscribed.

2026-11-17, PiI links block (3877cdd): parent Dalmatians 1513691963 [Retired] (1.0 to 1.4); linked, all 1.6: WhaleysDogs (Continued) 2274606936, A Dog Said... Animal Prosthetics 2 3238353862, Dogs mate (Continued) 2441132298, Dog Retexture 3284798441, Animals at Work - Herding Dogs 3766198296; versions unknown: Better Crossbreeding 3520675842, WhaleysDogs 1174618231. No translation, no retexture patch, no replacement found. Verdict: the only 1.6 Dalmatian.
