---
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
automated:    28 passed, 0 failed, 0 skipped on 2026-09-12
manual:       13 scenarios documented in TESTING.md; execution pending
workshop:
remaining:
  - unverified: all thirteen manual scenarios A-M; no in-game run recorded
  - unverified: ADS 2 surgery availability and load order, scenarios C and D
  - defect: inherited dessicated corpse has only its east texture
session:      local_e7fdeacc-7649-4702-9f00-45be2663ced1
updated:      2026-09-12
---

# Dalmatians Renew — status

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
