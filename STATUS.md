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
pickle_tests: 10 features, 52 scenarios, 9 passes plus the removal chain; passes 1 to 6 green (2026-09-24 to 26, French replays 2026-10-02), passes 7 and 8 green 2026-10-02; pass 9 red once on 2026-10-02 (the vanilla-dogs assertion needs Dogs mate absent, fixed by tag @without-dogsmate in 29088f0), replayed green 2026-10-10 (7 of 7, ticket 20261010-225052-995-f244, exitReason passed); removal chain green 2026-10-10 (2 sequences, 1 of 1 each, ticket 20261010-225054-111-21e8, exitReason passed); evidence in Tests/Pickle/Evidence/p9-2026-10-10 and removal-2026-10-10-seq1 and -seq2 (minified greens; fresh runs land in Tests/Pickle/Inbox/<run>, the -EvidenceDir of every ticket; the -EvidenceDir is relative to the mod, no mod name in front)
audit_revision: 06648bd4c28c0a5e0a53855c82025c02eeceaea2 (2026-10-10 audit, working tree not yet committed)
tested_on:    RimWorld 1.6.4871 rev600 (Pickle, WSL), 2026-10-10: pass 9 and removal chain K; earlier passes 2026-09-24 to 2026-10-02
automated:    44 passed, 0 failed, 0 skipped on 2026-10-10 (scripts/Run-Tests.ps1, was _tools/), tree = 06648bd plus the 2026-10-10 closing pass
manual:       17 scenarios documented in TESTING.md; K reduced to one check (removal) and L dropped (owner, 2026-09-27), A automated in full (training tab) the same day; rows 1 and K-removal of PUBLICATION.md's table still pending in game
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - open: gallery reshoot. Run a126 (Tests/Pickle/Inbox/2026-10-20-gallery) read 2026-10-25 by the director, 2 of 4 passed: feed REFUSED (capture shows only flowers and a campfire icon, no dog, no Nelim: the frame step centres away from (151..157, 103..105)); towel and fire FAILED at "I frame the cells ... filling 85 percent" (camera root size reads 11, wanted 5.29 and 3.64: zoom bounded or not finished). The card passed and is index 2 already. Shotlist (3 photos scored 4, card set aside) is in the 07 header and in the table above.
  - queued 2026-10-25: ticket 20261025-143037-361-c5c5 (old three scenes, map with SimpleCameraSetting, commit acfb68a), evidence to Tests/Pickle/Inbox/2026-10-25-gallery. Shotlist v2 below (4 photographs, mid-gesture) is written; its scenarios wait for c5c5 and for NPT's ticket 1071 (gesture steps deployed 89a2970 and 8318f39, not yet played). Open: social preview upload of Mod/About/Preview.png then record social_preview_sha256 (owner).
  - open next (superseded by shotlist v2): fix the three scenarios (ask NPT for a step that centres and zooms on cells, or centre then "the camera root size is set to N"), refile as small tickets, open each capture against its plan line, then reindex, Art/Gallery-clean/, subtitles in PUBLICATION.md and Add-Subtitle.ps1 (card gets none), align tables, then mountPreview. Hair: Ponytails/Pigtails/FancyBun are Female hairstyles; no hat in any scene.
  - decided 2026-10-25, probe ebfe: failed ("Rex should wear 'Apparel_leatherdogcollar'; it wears " nothing), the dalmatian is not fitted: shots stay vanilla, no patch in this mod, no Animal Apparel Collars credit.
  - open: Inbox triage after each run: green minified into Evidence with a RELEASE.md, red studied then deleted or parked with a RELEASE.md naming the scenario; Evidence trims proposed 2026-10-19 (p8, rename-p3, rename-p4: drop "loading the colony logs nothing") not done.
  - partial: AUDIT.md 8.d the `@review` captures: the 24 of 2026-10-02 (p1-french 9, p2-french 14, p9 1) opened 2026-10-11, all read as expected (trimmed 2026-10-18 to 4 JPEG in Tests/Pickle/Evidence, the weak p9 capture deleted after the green replay of 2026-10-10; replay the scenario if one more is needed) (French labels and tooltips, four facings, leather card, Wildness 0%, puppy beside adult, corpses). Two notes: the p9 capture (2026-10-02-p9) shows a map without any dalmatian in frame, weak evidence for its scenario; under Whaleys Dogs the tooltips read "Dalmatien 1 (femelle dalmatien)" while standalone reads "Dalmatienne 1 (femelle dalmatienne)" (Whaleys kind label, French validated by the owner 2026-10-02). The 2026-10-10 replays wrote no screenshots; the 2026-09 captures are older than the cutoff.
  - unverified: workshop item 3806709979 still carries the description sent by 0.1.0 (lacks IF I GO QUIET, AI-GENERATED, THANKS, Source code on GitHub link); the Markdown block in PUBLICATION.md is complete, the CI sends it at the first publication (2026-09-27 ruling)
  - unverified: rollback target (none before the first publish) and the drafted thank-you comments, posted only once the item is public
session:      local_e07388d7-8c73-4619-af3d-44de8bbb400f
updated:      2026-10-17
code_review_sha: 103690ac09387031cbffd0d1327e1903bd17acd1
protocols_read_sha: c94c7bd9c6954f001038a6202ae288fd8c078915
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

## Gallery shotlist v2 (2026-10-25, director pass by an Opus sub-agent; scored against GALLERY.md a to g, j, k; nothing is played under 4)

Story (k): the day Nelim's two new dalmatians, Rex (adult) and Pup (puppy), arrive and settle in. Nelim is the protagonist, the Sanctuary the place, clear weather, game paused at each shot. Rhythm 08:00, 09:00, 15:00, 19:00. Ladder of zoom (adult dog about 1 cell, 135 px at zoom 4 = 12.5 % of a 1080 px frame, the least that reads in a 268 px thumbnail; nothing below zoom 2, the game's bound): wide 4, medium 3.2, medium-tight 2.8, close 2. Outfit continuity (d): teal shirt, brown trousers, Ponytails, smile in 1 to 3; one change, justified in 4 (Pup shook the pond water over her in 3, she changed for the evening: indigo shirt, cream trousers, FancyBun). No apparel on animals (collar probe ebfe failed). Gesture recipe (e): force the walk or haul, let the game run, pause, then `I advance the paused game by exactly N ticks` (NPT, ScreenshotStudio, written and compiled, not yet in the bundle: asked 2026-10-25). Places 1 to 3 chosen in the 2026-10-12 pass after reading the place catalogues; not re-read today.

| # | a time frame | b decor | c living | d pawns | e action, instant, how | f composition | g subject, sentence | j mod, thumbnail | est. | main risk |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 arrival | flower-garden, 08:00, clear, first shot of the day | the garden's own beds, two daylilies grown (150,104) and (157,107), removed | Rex and Pup walking toward the camera, faces visible | Nelim teal shirt (22,110,115), trousers (74,58,50), Ponytails, MouthSmile, LidCheerful | Nelim, Rex and Pup forced to walk along the bare path toward the camera; instant: they have just entered the garden, Pup lags one cell behind, Rex at her heel; run, pause, advance about 40 ticks | zoom 4 centred on the path cell between them, flowers either side, morning light | the pair: "the dalmatians have come home" | Rex 12.5 % of frame height | 4.5 | path cells and tick count unknown until played |
| 2 feed | flower-garden bare path, 09:00, clear, one hour later | two daylilies in the foreground | Rex facing Nelim, Pup at the frame edge | same outfit as 1 (same morning) | Nelim forced to haul Kibble toward Rex; instant: one step from setting it down, Rex trotting in (forced walk); advance N ticks | zoom 3.2, Rex off-centre, daylilies in front | Rex, the adult: "breakfast" | Rex 17 % of height | 4.5 | haul of Kibble defName portable? Rex facing camera not guaranteed |
| 3 towel | water-garden bank, 15:00, clear | reeds in front, the pond's ducks and lily pads behind; no stool | Pup just out of the water, ducks | same outfit as 1 | Pup forced to walk from the shallows to the first dry cell, Nelim hauling Cloth one cell away; instant: Pup just climbed out, the towel is about to land; pause with Pup on the bank | zoom 2.8 centred between Pup and Nelim | Pup, the puppy: "after the swim" | Pup 20 % of height, spotted coat | 4 | bank cells standable? burrow hole (149,173) avoided |
| 4 fire | sofa-corner of the salon, 19:00, clear (dusk to confirm), closing shot | a lit campfire (190,120) and the room's torch lamp lit, couches | Rex head up toward her, Pup curled in a corner of the frame | Nelim indigo (60,70,140), cream (225,215,190), FancyBun, calm small smile (MouthLipsSmallSmile, LidNormal); changed because Pup soaked her in 3 | Nelim hauls WoodLog to the fire; instant: the log is about to drop on the embers, Rex lifts his head | zoom 2 on Nelim's head and Rex (frames the head of "Nelim" and "Rex"), warm low light | all three gathered: "they have settled in" | Rex and Pup large | 4 | campfire indoors looks staged (judge on the capture), 19:00 may be night, Pup lying near the fire not forced |
| card | interface, not scored | - | - | - | - | window-backdrop-for-height, cropped | species card, Wildness 0 % | - | - | already index 2, becomes the last index |

Series k: ok. One story at the top, opening (1, wide) and closing (4, close), variety wide 4 / medium 3.2 / medium-tight 2.8 / close 2, rhythm 08, 09, 15, 19. Scores by the rule (5, minus 0.5 per weak or missing cell, minus 1 per missing step): every cell filled; the 0.5 off 1 and 2 is the two unproven gesture steps (compiled, not played, so no -1), the 1 off 3 and 4 is their named risks. Collar dropped (probe failed, owner's rule: stays vanilla). Scenarios 07 not rewritten yet: waiting for NPT to deploy the gesture steps; ticket c5c5 still plays the old three.

## Pickle tickets

Filed 2026-10-10, both RUN_DONE green (exit 0): 20261010-225052-995-f244 (pass 9 replay, 7 of 7), 20261010-225054-111-21e8 (removal chain K, seq1 and seq2, 1 of 1 each). Tree no longer frozen. Registered with Ticket Manager 2026-10-10 as `local_58ad495b-63fb-4c70-ac11-4bf0c025db07`.

## Audit coverage, 2026-10-10 (revision 06648bd + closing pass)

- Dependencies (4): none hard. `loadAfter` Mlie.WhaleysDogs (LoadFolders `IfModActive` Compatibility/WhaleysDogs), `loadBefore` SamBucher.ADogSaidAnimalProsthetics2, `incompatibleWith` cucumpear.dalmatians. Optional guarded patches: ADS 2, Dogs mate (2441132298), Better Crossbreeding (3520675842); Nocturnal Animals none by decision. DLC: none; `supportedVersions` 1.6.
- Settings (5): `not_applicable`, no C#, no page, no shortcut.
- Translations (6): `scripts/Check-DefInjected.ps1 -TransMod DalmatiansRenew/Mod`: 25 keys, 0 errors, `WD_Dalmatian` keys UNVERIFIED (target created by patch); `FRENCH_REVIEW.md` regenerated at 06648bd; French validated by owner 2026-10-02.
- Distributed root: `Mod/ATTRIBUTION.md` and `Mod/LICENSE` byte-identical to root copies; `Mod/desktop.ini` gitignored; `*.dds` untracked.
- Em dash: `Mod/About/About.xml` and PUBLICATION.md clean; README.md and CHANGELOG.md (append-only) carry older ones, left as is.
- Protocols read: AGENTS, PICKLE, PUBLISHING, TRANSLATIONS, MOD_SETTINGS, STYLE_RIMWORLD, WORKSHOP_COMMENTS (section Writing a comment); `protocols_read_sha` written, `Check-Status.ps1`: 0 error, 0 warning.
