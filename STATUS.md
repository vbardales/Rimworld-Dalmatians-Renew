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
automated:    36 passed, 0 failed, 0 skipped on 2026-11-02 (Tests/Run-Tests.ps1, restored from d69dacf^ and cut per LOCAL-SCRIPTS-CUT: the generic def, field, reference and French-coverage tests now belong to the shared checks; Tests/WhaleysDogs.Tests.ps1 and Tests/Crossbreeding.Tests.ps1 run inside it), tree = HEAD
manual:       17 scenarios documented in TESTING.md; K reduced to one check (removal) and L dropped (owner, 2026-09-27), A automated in full (training tab) the same day; rows 1 and K-removal of PUBLICATION.md's table still pending in game
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - open: gallery reshoot. Run a126 (Inbox folder 2026-10-20-gallery, deleted 2026-11-02 after study: red, superseded by shotlist v2) read 2026-10-25 by the director, 2 of 4 passed: feed REFUSED (capture shows only flowers and a campfire icon, no dog, no Nelim: the frame step centres away from (151..157, 103..105)); towel and fire FAILED at "I frame the cells ... filling 85 percent" (camera root size reads 11, wanted 5.29 and 3.64: zoom bounded or not finished). The card passed and is index 2 already. Shotlist (3 photos scored 4, card set aside) is in the 07 header and in the table above.
  - open next (2026-11-08): shotlist v3 plan 5 on every scene, scenarios 1 to 4 of 07-publication-shots.feature rewritten from it, Animal.BedsNew in wsl-deps.sanctuary.map, Check-ShotlistVsScenario OK (f58533e). Next: file scenario 1 alone as a small ticket (DepMap wsl-deps.sanctuary.map, English, Tests/Pickle/Inbox/2026-11-08-gallery-1), open the capture against v3 line 1, then 2 to 4 one at a time. Unproven: GSAnimalBedBig and Hay placement, hauled items drawn in hand, cells standable; 3 has no animal removal (ducks stay, an NSB pet may wander in).
  - 2026-11-09: PiT answer: load `Given the save "Nelims-tribe-decor-mods-z3" is loaded` with wsl-deps.sanctuary-z3.map (this mod; decor mods copied from the shared map). z3 holds TorchLamp (157,102) in flower-garden, Daylily rows at z103 (150..156) and (150,104), NO GSAnimalBedBig, NO campfire, sofa-corner has 2 Couches and milple_TorchLampR (184,120), water-garden west bank has lily pads, reeds, bamboo (143,175), no daylilies. Diag ticket 68f8 (99-diag-flower-garden, 3 places) filed 20261109-234520-126-68f8; then fix scenario cells and repoint 07 on z3, Check-ShotlistVsScenario, refile 1. Guard stop of 6ef6 was not from z3.
  - open (older, superseded by the line above; 2026-11-08, after tickets 121a and 9d54, both red before any capture): scenario 1 places items on cells the fixture already holds (121a Hay on the bed cell, fixed with the item step and then bed placed ok; 9d54 TorchLamp (152,101) holds SculptureGrand: the path touches the statue garden at (155,97)). Diagnostic ticket 6ef6 (untracked then committed feature Tests/Pickle/Mod/Pickle/Features/99-diag-flower-garden.feature, two empty frames (154,100) and (154,108) zoom 6, Inbox 2026-11-08-diag): read the captures, choose free cells for scenes 1 and 2 (same path), update shotlist and scenarios, Check-ShotlistVsScenario, refile scenario 1, then delete the diag feature and its Inbox folder. Scene 1 is now zoom 4 (wide), Hay spawned as an item, Nelim keeps her own hairstyle (rule 3), scene 4 Pup lies asleep in the bed (NPT step). Plan rated 5 on every scene.
  - open (TM missions, 2026-11-08, after the gallery): replace the Run-Checks chain by scripts/Run-OfflineChecks.ps1 -ModRoot <mod> (keep specific checks), new test shape (Tests/Rule-OwnValues.ps1, generated Test-Mod.ps1), OptionalCompat once, translation review (Make-TranslationReview.ps1, FRENCH_REVIEW.md old name), tell Audit when done; gallery reviewed ONCE at the end by the owner (all candidates in one message), subtitles with scripts/Add-Subtitle.ps1 after acceptance; runner auto, never -Runner azure; 1.7 questions to Audit local_10336624.
  - rated 2026-11-08, superseded by v3 above (score-gallery, plan only): plan 1 = 4 (b weak: two daylilies, no props or light; g weak: "have come home" needs the header), 2 = 4.5 (b weak), 3 = 4.5 (b weak: reeds, ducks, pads on a bare bank), 4 = 5; series k ok; mean 4.5. Rework b (dense decor, light in frame) and g (story readable in the image) on 1 to 3 until 5 before any ticket. Scene 1 capture: REDO, deleted.
  - done 2026-11-07: ticket db7c (scenario 1 the arrival) green (1 of 1, exitReason passed, run 2026-11-04), capture opened and judged REDO, Inbox folder deleted. Read: Nelim frowns (angry brows, no smile: -0.5 on d), both dogs seen from behind and walking away (Rex not facing camera, c/e fail), dogs stand in the flower beds not on the path, a green crate and an ornate bed clutter the lower frame, no story readable in the image (g weak). Pup tiny. Next: sync-nsb (shootGallery entry order of GALLERY.md 2026-11-07), rate-gallery on the shotlist (5 on every scene before any ticket), rewrite scenario 1 (smile override, camera on the path, dogs facing camera), Check-ShotlistVsScenario.ps1, refile.
  - open next (superseded by shotlist v2): fix the three scenarios (ask NPT for a step that centres and zooms on cells, or centre then "the camera root size is set to N"), refile as small tickets, open each capture against its plan line, then reindex, Art/Gallery-clean/, subtitles in PUBLICATION.md and Add-Subtitle.ps1 (card gets none), align tables, then mountPreview. Hair: Ponytails/Pigtails/FancyBun are Female hairstyles; no hat in any scene.
  - 2026-10-25: gesture recipe PROVEN by NPT ticket 531b (fix 6c8ba9d): forced walk or haul, pause, advance 20 ticks = about one cell. Scenarios of 07-publication-shots.feature rewritten on it (4 photographs + card, cells and 20 ticks are first guesses, not played). Next: after c5c5 is read, file small tickets one scenario at a time, open each capture against its shotlist v2 line, adjust cells and ticks. Not proven by NPT: jar ingestion (35f9), collar diagnostic.
  - ruled 2026-10-25 by owner: clothes and expressions of shotlist v2 are suggestions, default expression smiling; colonists other than NSB's need special authorization; special requests go to NPT first, owner arbitrates if NPT refuses.
  - decided 2026-10-25, probe ebfe: failed ("Rex should wear 'Apparel_leatherdogcollar'; it wears " nothing), the dalmatian is not fitted: shots stay vanilla, no patch in this mod, no Animal Apparel Collars credit.
  - done 2026-11-03: Preview re-rendered after echo.width/height and echo.color left the config (echo fitted in its max box, right of the panel, no clipping or overlap; badge now bottom-right by renderer default); resume-mod 7b.
  - open: Inbox triage after each run: green minified into Evidence with a RELEASE.md, red studied then deleted or parked with a RELEASE.md naming the scenario; Evidence trims proposed 2026-10-19 (p8, rename-p3, rename-p4: drop "loading the colony logs nothing") not done.
  - partial: AUDIT.md 8.d the `@review` captures: the 24 of 2026-10-02 (p1-french 9, p2-french 14, p9 1) opened 2026-10-11, all read as expected (trimmed 2026-10-18 to 4 JPEG in Tests/Pickle/Evidence, the weak p9 capture deleted after the green replay of 2026-10-10; replay the scenario if one more is needed) (French labels and tooltips, four facings, leather card, Wildness 0%, puppy beside adult, corpses). Two notes: the p9 capture (2026-10-02-p9) shows a map without any dalmatian in frame, weak evidence for its scenario; under Whaleys Dogs the tooltips read "Dalmatien 1 (femelle dalmatien)" while standalone reads "Dalmatienne 1 (femelle dalmatienne)" (Whaleys kind label, French validated by the owner 2026-10-02). The 2026-10-10 replays wrote no screenshots; the 2026-09 captures are older than the cutoff.
  - done 2026-11-02 (Audit ruling): 7.b offline suite restored under Tests/ (deleted by d69dacf, 10.e moves scripts to Tests/), cut to 36 mod-specific tests, 36 green; LOCAL_SCRIPTS rows relisted, Audit to validate. Next: replay-audit --force.
  - unverified: workshop item 3806709979 still carries the description sent by 0.1.0 (lacks IF I GO QUIET, AI-GENERATED, THANKS, Source code on GitHub link); the Markdown block in PUBLICATION.md is complete, the CI sends it at the first publication (2026-09-27 ruling)
  - unverified: rollback target (none before the first publish) and the drafted thank-you comments, posted only once the item is public
session:      local_e07388d7-8c73-4619-af3d-44de8bbb400f
updated:      2026-11-02
code_review_sha: 103690ac09387031cbffd0d1327e1903bd17acd1
protocols_read_sha: 01ba2e9cfe0b307ec9f0aef7d1edfd39f2458666
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

## Gallery shotlist v3 (2026-11-08, supersedes the v2 table above; Opus director pass kept in part)

Lessons of capture db7c (scene 1, REDO): face steps ran before the tick advance (Nelim frowned: the face is the LAST step before the screenshot); the forced walk went from z 103 to 106 and a higher z is NORTH, away from the camera (walk toward the camera means a LOWER target z); flowers filled the frame, no light, no props. Opus remarks kept: a hauled item reads as play in progress (Hay in 1, Kibble in 2, Cloth in 3, WoodLog in 4); Pup on a diagonal, not in Rex's column; no Bedroll (reads human); bed placement consistent (south end of the path, lower z, foreground in 2); Nelim never shown from behind; Rex not "lifts his head" (a lying sprite has one pose): Rex stands at the fire, Pup on the bed. Dropped: outfit change in 4 (fails d continuity): teal shirt, brown trousers all day. Bed = More animal beds `Animal.BedsNew` (3107972819) `GSAnimalBedBig`, added to the scenario's own DepMap (not in the Sanctuary map; not yet played).

Story: the day Nelim's two new dalmatians, Rex (adult) and Pup (puppy), arrive and settle: 08:00 she brings them to their new bed, 09:00 breakfast, 15:00 Pup out of the pond, 19:00 all three at the fire, the bed now slept on. Clear weather, game paused at each shot. Nelim: teal shirt (22,110,115), brown trousers (74,58,50), her own NSB hairstyle (Roo_HD_Hair_Highpony, a colonist property: no override without owner validation), MouthSmile, LidCheerful in every scene; her face steps come last.

| # | a time frame | b decor | c living | d pawns | e action, instant, how | f composition | g subject | j mod | est. |
|---|---|---|---|---|---|---|---|---|---|
| 1 arrival | flower-garden path, 08:00, clear, +40 ticks | TorchLamp lit (152,101); GSAnimalBedBig (154,99) with Hay on it; Plant_Daylily fully grown (150,100) (153,98) (157,100); 4 Plant_YellowTallGrass clumps (no PlantPot); flower beds behind | Rex facing the camera, Pup on the diagonal (155,105) | Nelim teal, brown, smile | Nelim hauls Hay toward the bed, Rex at her heel; instant: they just stepped onto the path, the bed waits; Nelim, Rex, Pup spawned at z 104-105, forced to walk to z 101, advance 40 ticks | zoom 4 (wide, opening) centred (154,102), bed in the lower frame, lamp left, beds behind, morning light | Nelim brings the dalmatians to their new bed (hay, bed, lamp say it) | Rex about 12 % of height | 5 |
| 2 breakfast | same path, 09:00, clear | same lamp, daylilies, tall grass; the bed in the foreground (lower z); Kibble stack | Rex coming at the camera, Pup (153,101) nose to the kibble | same outfit, smile | Nelim carries Kibble from (156,103) to (156,101) facing South, instant just before the drop, Rex forced to walk from (154,104) toward it; advance 20 ticks | zoom 2.2 centred (154,101), Rex large, bed in front | breakfast for the dalmatians (Kibble in hand, dogs coming) | Rex about 20 % | 5 |
| 3 towel | water-garden west bank x 143-158 z 168-176, 15:00, clear | willows (171,162) (165,162), reeds (168,163), lily pads, ducks 4 or more cells off; daylily clumps at x 146-147 and tall yellow grass on the bank; Cloth in Nelim's hands | Pup walking out of the shallows onto the bank (150,170), ducks | same outfit, smile | Nelim walks south with Cloth toward Pup; instant: Pup just stepped out of the pond, the towel is about to reach him; forced walks, advance 30 ticks; burrow (149,173) avoided | zoom 2.8 centred (150,170), pond behind, reeds and daylilies at the sides | Pup out of the water, Nelim brings the towel (pond, ducks, cloth) | Pup about 20 %, spotted coat | 5 |
| 4 fire | sofa corner of the salon, 19:00, clear | campfire (190,120) lit, torch lamp lit within 3 cells of the dogs, GSAnimalBedBig by the fire, couches | Rex standing, facing the fire and the camera, Pup on the bed | same outfit, small calm smile (MouthLipsSmallSmile, LidNormal) | Nelim from (190,123) walks south hauling a WoodLog to the fire; instant: the log is about to drop on the embers; forced walks, advance 20 ticks | zoom 2 on Nelim's head, Rex, the bed, warm low light | all three at the fire, the bed they were brought to is theirs now | Rex about 25 %, Pup about 15 % of height | 5 |
| card | interface, not scored | - | - | - | - | window-backdrop-for-height, cropped | species card, Wildness 0 % | - | - |

Series k: ok (one story, opening 1 at 4, closing 4 at 2, variety wide 4 / 2.2 / 2.8 / close 2, rhythm 08, 09, 15, 19, the bed opens and closes the day). Main risks, not scored: `GSAnimalBedBig` never played here; hauled Hay, Kibble, Cloth drawn in hand not proven; a campfire indoors may look staged; Pup in scene 4 lies asleep in the bed by the NPT step "lies asleep in the bed" (2026-11-08, not played yet; the bed must sit exactly at (187,120)).

Plan rated 2026-11-08 after the NSB/NPT sync (score-gallery, no capture yet): 1 = 5, 2 = 5, 3 = 5, 4 = 5; series k ok; mean 5. Fixed before rating: scene 1 zoom 3.2 became 4 (a wide opening, variety), scene 2 "pots" became daylilies and tall grass (scene 1 has no PlantPot), scene 4 thumbnail "large" became Rex about 25 %, Pup about 15 %, Nelim hairstyle override dropped (rule 3). No new Opus pass: v3 of today keeps the Opus director remarks. Capture verdicts: none yet (db7c REDO is v2/v1 era).

## NSB (sync 2026-11-08)

Places read: 2026-11-09. Tribe read: 2026-11-09. Steps read: 2026-11-09.

Sync 2026-11-09: NSB finished the redecoration, all places validated, final fixture `Nelims-tribe-decor-mods-z3.rws` copied to NSB `Mod/Pickle/Fixtures` (sha256 6bfb4a48...); `Nelims-tribe.rws` stays the OLD undecorated Sanctuary until scenarios are repointed. Scenario 07 still loads "Nelims-tribe" (old): OPEN, ask NPT how to load z3 for a gallery (DepMap, decor map) and which of the decor the scenarios add (TorchLamp, Hay, daylilies, campfire) z3 already holds (cell conflicts of tickets 121a, 9d54). Quill and Beauty2 mouth changes (cc61d17): no effect on Nelim. New NPT steps: "I frame the area centred on the point (x, z) at root size N" (compiled, played green on ACG 6e93; may fix the frame step that failed in a126/6ef6), "carries the item X made of Y", "the colonist does not flee from hostile pawns", "flecks of def are not thrown" (sleeping Z), "the drawing of the class is skipped". Left alone: shotlist and scenarios (no rewrite before z3 answer). Ticket 6ef6 ended exit 3 "guard stop (game silent or blocked)", no report: infrastructure, not the scenario; refile after the z3 answer.

Earlier sync (2026-11-08): NSB validated hearth-hall, fire-pit, sleeping-nook, sofa-corner and enclosure on 2026-11-08; NPT added the steps "lies asleep in the bed" and "the animal lies at ... facing", "put out", made-of placement. Updated: scene 4 Pup now lies asleep in the bed (NPT step, replaces "stands on the bed"); Nelim's hairstyle override Ponytails dropped from the four scenarios and the shotlist (hairstyle is a colonist property, canon Roo_HD_Hair_Highpony, no owner validation: rule 3). Left alone: campfire at (190,120) in scene 4 (the validated fire-pit hearth (181,115) could replace it, judge on the capture); outfit teal shirt and brown trousers (every outfit is free, rule 4). Open: scenario 4 must remove the thrumbos Atticus and Rain from the hall if they stand in frame (the scenario removes the animals of "sofa-corner" only).

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
