---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Dalmatians Renew (unofficial)
packageId:    nelim.dalmatiansrenew
repo:         Rimworld-Dalmatians-Renew
remote:       https://github.com/vbardales/Rimworld-Dalmatians-Renew
local_path:   C:\Users\nelim\Documents\rimworld\DalmatiansRenew
visibility:   public
upstream_visibility: public (Steam API visibility=0; banned=0; checked 2026-09-12)
detached:     yes
maintainer:   Codex, this local repository task
stage:        awaiting in-game verification
licence:      silent
licence_port: MIT, limited to the port contributions
licence_at:   LICENSE; Mod/LICENSE; ATTRIBUTION.md
dependencies: none
showcase:     complete
tested_on:
automated:    37 passed, 0 failed, 0 skipped on 2026-09-13
manual:       17 scenarios documented in TESTING.md; execution pending
workshop:
remaining:
  - unverified: English and French runtime translation checks, with and without WhaleysDogs; TESTING.md scenario M
  - unverified: all seventeen manual scenarios A-Q; no in-game run recorded
  - unverified: ADS 2 surgery availability and load order, scenarios C and D
  - defect: inherited dessicated corpse has only its east texture
session:      local_e7fdeacc-7649-4702-9f00-45be2663ced1
updated:      2026-09-13
---

# Dalmatians Renew — status

## Translation audit — 2026-09-13

Applied the shared PUBLISHING.md / TRANSLATIONS.md gate to the working tree based on
`f1bb6b0`, including the pending WhaleysDogs integration. Inspected all XML in `Mod/Defs`,
both patch folders, `Mod/LoadFolders.xml`, and all five French files. The root loads
always; the integration loads only with Mlie.WhaleysDogs. No owned UI code, Keyed strings,
custom grammar or generated sentences exist. Patches add references, values and graphics,
not displayed sentences.

| Resource | English source / fallback | French entries |
|---|---|---:|
| CCPDalmatian ThingDef | Label, description, three named attack tools | 5 |
| CCPDalmatian PawnKindDef | Adult label, puppy label/plural; engine gender/plural defaults | 8 |
| Leather_Dalmatian ThingDef | Label, description; material adjective defaults to label | 3 |
| WD_Dalmatian ThingDef, conditional | Installed WhaleysDogs 1.6 label, description, three named tools | 5 |
| WD_Dalmatian PawnKindDef, conditional | Installed adult/puppy labels and plural defaults | 4 |

English stays in source Defs; duplicate English injections are unnecessary. French covers
the inventoried literal text and supplies explicit grammatical forms where needed.
Reviewed meaning and terminology, including `fourrure de dalmatien`. The unnamed bite tool
and inherited generic game text use Core resources; no custom dependency Keyed key is
introduced. IDs, Canine enum values, paths, About metadata, licences and documentation
are outside this gate. These language values contain no format parameters, grammar tokens,
rich-text markup or multiline formatting.

Replaced five numeric paths in the optional French files with source handles:
`tools.left_claw`, `tools.right_claw`, `tools.head`, and the two fields under
`lifeStages.Young_Dalmation`. The upstream spelling and case are intentional in the key.
The local integration test now also resolves these label handles.

Validation: 25 nonempty French entries, no duplicate keys within the loaded Def types.
The shared injection checker resolved all 25 paths: **0 errors, no UNVERIFIED findings**.
An initial invocation omitted this mod from explicit targets and was discarded; the final
command includes both this mod and the installed third-party 1.6 definitions:

```powershell
& ..\scripts\Check-DefInjected.ps1 -TransMod (Join-Path $PWD 'Mod') -Targets @(
  (Join-Path $PWD 'Mod'),
  'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2274606936\1.6'
)
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1
```

The local suite passed **37 tests, 0 failed, 0 skipped** after the path changes.
Scenario M covers both languages and both load configurations, including descriptions,
attack labels, plurals and garment material names. All three translation fields certify
offline readiness for preTest only. No in-game translation check was performed.

Codex maintains this file as part of this repository's ongoing work. Update it after changes,
verification runs, and publication, keeping completed checks separate from pending checks.
The session identifier above is retained from the existing card.

## Repository identity

The Git root is `C:\Users\nelim\Documents\rimworld\DalmatiansRenew`, with its own `.git`
directory, no Git superproject, and the origin URL shown above for fetch and push. This task
manages this single local repository independently of the former monorepo. GitHub visibility
was checked with `gh repo view` on 2026-09-12 and returned `PUBLIC`.

## Title and description

The title is `Dalmatians Renew (unofficial)` in About.xml, README.md and this card. Keep the
suffix: this is an unofficial continuation without recorded explicit upstream consent.
No additional suffix is needed. The manual title check and automated identity check match it.
The GitHub URL is present both in About.xml's `url` and inside its description.

## Licence and justification

`licence: silent` describes the upstream material, not the licence of the whole repository.
The existing attribution audit records no declared upstream licence; that historical finding
was not rechecked against the Steam page during this audit.

The actual licence files, `LICENSE` and `Mod/LICENSE`, grant **MIT only for the port's own
contributions**: XML corrections, the rewritten ADS patch, French translation, packaging,
documentation and the new preview/icon artwork. MIT permits reuse and continuation of those
contributions while retaining the copyright and permission notice.

The original animal definitions, balance, leather and four textures belong to cucumpear and
lavie2k and are excluded from that grant. No licence to those original contributions is granted
here. Public GitHub visibility, abandonment, attribution and removal on request do not constitute
an upstream licence. Credit and removal on request describe the existing publication policy.
The two licence copies were reconciled with ATTRIBUTION.md: the current preview is port artwork,
not the original screenshot.

## Verification on 2026-09-12

Command: `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1`

Result: **28 tests passed, 0 failed, 0 skipped**. The initial run found one stale expected title;
that expectation was updated to include `(unofficial)` and the suite was rerun successfully.

The local suite needs no monorepo checkout. It uses installed RimWorld data and assemblies and,
for ADS integration data checks, the installed A Dog Said 2 files. All were available for this run.

Coverage includes XML parsing, fields and classes against RimWorld 1.6, parent resolution,
28 def references, vanilla name collisions, textures, metadata, Wildness, leather values,
patch structure, XPath targeting and the absent-ADS guard, category membership, and French keys.
This is a content-only mod with no C# assembly to unit-test.

TESTING.md contains thirteen functional manual scenarios A-M with steps and expected results:
animal spawning/taming, stats, ADS present/absent and load order, leather, pet behaviour, trade,
textures, conflicting mods, saves, mod-list presentation and French translation.
They have not been run in this audit. Runtime surgery availability, save compatibility and
rendering remain unverified; offline success must not be reported as an in-game pass.

Workshop publication is not recorded. The existing PublishedFileId was removed because it
identified the original mod. The inherited corpse texture limitation remains documented.

## Explicit upstream visibility check — 2026-09-12

Original item: https://steamcommunity.com/sharedfiles/filedetails/?id=1513691963

Checked without a Steam login. The page returns HTTP 200 and is titled `[Retired] Dalmatians`.
The public Steam API `ISteamRemoteStorage/GetPublishedFileDetails/v1/`, queried for publishedfileid
1513691963, returns `result=1`, `visibility=0` (public), `banned=0`, and an empty `ban_reason`.
Thus the original item is public, not private or unlisted. Retired describes maintenance status;
it does not mean private. The HTML also includes a removal-warning string, so the visibility
conclusion is based on the explicit API fields rather than that ambiguous page text.
This check does not change the licence scope or the visibility of this port's GitHub repository.
## Preview overlay recomposed — 2026-09-12

Retained the existing illustration; no replacement was generated. The original remains at
`Art/Preview-source.png`, copied unchanged to canonical unlettered source `Art/Preview.png`.
Final output: `Mod/About/Preview.png`. Composition: `Art/Preview.html`; reproducible renderer:
`Art/Render-Preview.cjs` (Node.js, playwright and sharp; CHROME_PATH optionally overrides Chrome).
Palette source of truth: `Art/preview-palette.json`. The renderer reads it and supplies the
CSS variables; there is no independent overlay palette in the HTML.

The veil and secondary ink come from the cool slate-blue floorboards occupying the large quiet
left area. The secondary ink is a lightened blue that retains that chromatic family. The amber
accent comes from the lamp and the straw bed surrounding the dog: its warm hue and increased
saturation separate it clearly from the cool blue secondary ink. Primary ink is ivory on the
dark veil; shadows follow the guide. No palette HEX values are duplicated here.

Name is preserved. Following user feedback, the summary now reads "One dog, spotted and sweet-natured, brought forward."; the version appears only in the badge. Renew is 65% of the 46 px title, all at weight 600;
(unofficial) occupies its own tag line. The badge is derived from supportedVersions in the
shipped About.xml: 1.6. The crop retains the dog, its bed, bowl and lamp.

Chrome rendering at 896 x 504 waited for document.fonts.ready and the background image decode.
Chrome's platform-font report confirms Segoe UI, Segoe UI Semibold and Segoe UI Bold, with no
fallback. Visually inspected the final image and `Art/preview-268.png`: no clipped text or
overlap, readable title/Renew/version, visible rule and clearly distinct blue/amber accents.
The summary is intended for full-size viewing, as specified by the guide.

Measured contrast across every pixel of each text bounding rectangle on the separate text-free
render `Art/preview-background.png`, not merely against the CSS veil colour. Minimum ratios:
main title 12.467:1, Renew 8.387:1, tag 8.070:1, summary 11.267:1, badge 9.766:1.
All exceed 4.5:1. Font, bounds, contrast and file-size evidence: `Art/preview-qa.json`.
Final PNG: 896 x 504, 514087 bytes, below 900 KB. Nothing published.

## Visibility policy reviewed — 2026-09-12

Re-read the shared PUBLISHING.md licence rules (lines 112-139). Upstream Steam visibility,
upstream maintenance/licensing status, and this port's repository visibility are distinct.
A public upstream item is not permission to redistribute it. An `alive` source without
permission requires a private port marked `(prohibited)`, even if the port was public before.
A public `silent` port with no recorded prohibition uses `(unofficial)`; every private build
uses `(prohibited)`. Explicit permission in Steam descriptions or comments must be recorded
and its scope checked, even when no licence file exists.

For this mod, retain the documented `silent` classification and `(unofficial)` marking.
The evidence for discontinued maintenance is stronger than the old 1.4 compatibility ceiling:
the source is titled `[Retired] Dalmatians`, and cucumpear stated on 2025-01-16 that there
was not enough interest to keep it updated (source item 1513691963, comments, retrieved during
this task). This is about maintenance of this mod, not whether its author is active elsewhere.
No explicit permission or prohibition has been recorded in the attribution audit. The public
Steam API result establishes accessibility only; it does not establish publication rights.
GitHub is public; Workshop publication of this port remains unrecorded. No visibility setting
was changed by this review.

## Commit handoff — 2026-09-12

The repository audit, unofficial marking, licence clarification and recomposed preview are
complete. The full local suite was rerun before commit: 28 passed, 0 failed, 0 skipped;
`git diff --check` passed. The remaining gate is in-game verification of scenarios A-M,
especially ADS 2 scenarios C/D, followed by Workshop publication when authorized.
The inherited single-direction dessicated corpse texture remains unchanged.

## Installed dalmatian collision audit — 2026-09-13

Searched installed XML with ripgrep, --hidden --no-ignore --follow, after the shared Bash
search helper failed to locate its Unix utilities. Enumerated 400591 Workshop XML files,
23828 local Mods XML files (junctions followed), and 1672 Core/DLC XML files. Searches completed;
the final no-match exit code for Data was 1, not an I/O error. Broad terms included dalmatian
and dalmatien alongside CCPDalmatian and Leather_Dalmatian.

- Core and all five installed DLC: no matches.
- Original Dalmatians, Workshop 1513691963, cucumpear.dalmatians: the only external exact
  identifier collision found; already declared incompatible. Installed, currently inactive.
- WhaleysDogs (Continued), Workshop 2274606936, Mlie.WhaleysDogs: defines WD_Dalmatian in its
  active 1.6 folder and uses Leather_Dog. Can duplicate the animal concept, but does not collide
  with our identifiers. Installed, currently inactive.
- AOC The Cleanup Devil, Workshop 2469449551, Millap.AOC: a PawnKindDef labelled Dalmatian
  PooPoo uses PooPoo_For_Trader and race PooPoo; no identifier collision. Currently inactive.
- Local Mods: exact identifiers occur only in DalmatiansRenew. ReequilibrageAnimaux patches
  WD_Dalmatian, and DustBunniesRenew mentions dalmatian leather in a translation comment;
  neither adds a duplicate of CCPDalmatian. Current AnimalArk contains neither exact identifier.

The current ModsConfig.xml also does not enable nelim.dalmatiansrenew. Thus no active collision
was found. Enabling this port together with the original would introduce the known conflict;
enabling it with WhaleysDogs would leave two distinct dalmatian definitions. This is a static
installed-content audit, not an in-game compatibility test. No mod configuration was changed.

## WhaleysDogs integration — 2026-09-13

Comparison and proposed content ownership are recorded in WHALEYSDOGS.md. No defName collision;
the overlap is the breed. WhaleysDogs has its own 1.6 data and three directional sprites in an
asset bundle. Our living sprites are potentially an alternate appearance, not extra directions.
A consolidation would retain WD_Dalmatian as the canonical breed and preserve old CCPDalmatian
save data. User preference between consolidation and two variants is pending; no gameplay patch
has been applied. Current bundle pixel comparison and implementation remain outstanding.

## WhaleysDogs implementation completed — 2026-09-13

Supersedes the earlier pending-preference assessment. The approved canonical-breed integration
is implemented without an assembly or new required dependency. Mod/LoadFolders.xml conditionally
loads Mod/Compatibility/WhaleysDogs; About.xml declares after WhaleysDogs and before ADS 2.
WD_Dalmatian retains its balance, original graphics and complete corpse fallback and receives
our native alternate coat, leather, Canine type, French text and ADS category support.

Legacy CCPDalmatian defs remain for saves, with ordinary acquisition retired in combined mode.
Existing dogs stay sellable and may reproduce. Explicit/debug spawning and external mods that
request the old kind remain possible; no destructive migration or universal spawn interceptor
is attempted. See WHALEYSDOGS.md for exact scope, including the unchanged standalone behaviour.

The original 28 tests plus nine integration tests pass (37 total, 0 failed, 0 skipped). The
integration tests execute real installed Verse patch classes on isolated XML fixtures, with
only the offline Unity profiler disabled. They cover optional loading, unchanged canonical
stats, retained saved identifiers, legacy acquisition fields, coat variants, repeated application,
third-party variants, ADS targeting, field validity and conditional French keys. All runtime
save/graphics/selection checks remain pending in TESTING.md N-Q; no in-game pass is claimed.
Integration prepared for the requested Git commit and push on 2026-09-13. All 37 tests passed again before commit. Workshop publication remains pending.
