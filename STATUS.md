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
maintainer:   Claude Code (the session named for this mod); Codex worked on it earlier
stage:        done
licence:      silent
licence_port: MIT, limited to the port contributions
licence_at:   LICENSE; Mod/LICENSE; ATTRIBUTION.md
dependencies: none
showcase:     complete
settings_audit: not_applicable
xml_tests:    passed
functional_tests: unverified
pickle_tests: written 2026-09-24, 41 scenarios in 6 passes (8 launches); pass 1 English: all 14 scenarios have passed across five small tickets, no single full run yet; the other seven launches never run
audit_revision: 8b734cab75a0579ec33a19db19023c074628af1a (this card is committed on top of it)
tested_on:
automated:    37 passed, 0 failed, 0 skipped on 2026-09-24, with A Dog Said 2 installed; 33 ran and 4 skipped earlier the same day, before it was
manual:       17 scenarios documented in TESTING.md; execution pending
workshop:     3806709979 (item created private by the 0.1.0 prepublication of 2026-09-23; not the prepublished state)
remaining:
  - unverified: seven of the eight Pickle launches have never run, and pass 1 English still needs one full run at the current revision as its initial validation (docs/runs/2026-09-24-pass1-english.md); done -> tested
  - unverified: the litter size reads 1~4 on the game's own card, and the README and the shipped description say one to three; the curve runs from 0.5 to 3.5; a decision is pending on which is right to state
  - unverified: done -> tested needs no @wip scenario, every conditional scenario played (@requires Mlie.WhaleysDogs and SamBucher.ADogSaidAnimalProsthetics2, each on a map that mounts it), and no manual scenario left (A-Q automated and green, or listed not applicable with the reason)
  - unverified: English and French runtime translation checks, with and without WhaleysDogs; TESTING.md scenario M
  - unverified: ADS 2 surgery availability and load order, scenarios C and D
  - defect: the description shipped by 0.1.0 has no IF I GO QUIET, AI-GENERATED or THANKS section and no final Source code on GitHub BBCode link, names Claude but not Codex, and does not thank Pickle and PickleTools although passes now stage them; SetItemDescription runs only at creation, so the Steam page is corrected by hand and About.xml aligned; required for prepublished, not for done or tested
session:      local_e7fdeacc-7649-4702-9f00-45be2663ced1
updated:      2026-09-24
---

# Dalmatians Renew — status

## First Pickle run — 2026-09-24

Pass 1 in English, ticket `20260924-164450-054-c75d`, staged from `0262d74`, report read from
`Tests/Pickle/Evidence/2026-09-24-p1-english` (gitignored). `exitReason` is `failed`, which is a run that
went to the end: 14 scenarios played, 9 passed, 5 failed, 0 skipped, 0 flaky. It waited over 70 minutes to
start because the disk was full; that has no bearing on the result.

The five failures had three causes, all on the test side and none a fault of the mod:

- Pickle's `def` steps refuse a defName shared by two def types, and `CCPDalmatian` is a ThingDef and a
  PawnKindDef (three scenarios). Local steps say the type now.
- The staged Pickle has no step for the language, which the offline check had accepted because it read a
  newer development build (one scenario). The check reads the staged build now, and the language is
  asserted by a local step.
- The husky declares Wildness 0 in 1.6, so it was no control and its card correctly read 0% (one
  scenario). A hare declares 0.75 and is the control. TESTING.md scenario B had the wrong value and is
  corrected.

Captures read: the adult facing east is a white dog with black spots facing right, and the leather beside
plain leather shows the paler stack; both usable. The puppy scene did not show the adult and the animals
were a few pixels wide, so the camera now goes closer and the adult is spawned beside the puppy. The other
rotations and the corpse were not opened yet.

Two small fix tickets are queued: the five failed scenarios, and the six capture scenarios. A full pass 1
follows once they are green, as the initial validation, then the other passes, one ticket each. Nothing here
moves the stage: it stays `done`. The two large redundant report files (`report.html`, `messages.ndjson`,
67 MB) were removed from the evidence folder; the summary, the junit file, the log and the captures stay.

## Pass 1 English, after the fixes — 2026-09-25

Five small tickets in all. The first run failed 5 scenarios of 14; a fix run replayed those 5 and all passed
(`exitReason: passed`, 5 played). Three capture scenarios were then replayed one at a time because their images
were not readable: the information card, the puppy scene, and the corpse and rotations from the first run.

Captures read, all eight kept, recompressed to JPEG: the four rotations (north seen from behind, south from
the front, east facing right, west facing left, a white dog with black spots each time); the leather beside plain
leather, paler; its information card; the dessicated corpse, a small skeleton labelled "Dalmatian 1 (dead)",
drawn without a crash; the puppy beside an adult, smaller, from the same texture; and the information card
scrolled to Wildness 0%, highlighted, next to Trainability Advanced, Nuzzle interval 20 hours, Gestation 25
days and Source Dalmatians Renew (unofficial).

What went wrong on the way, so it is not repeated: two attempts to improve the camera were worse than the first
run's, one because `SetRootPosAndSize` takes a Vector3 and was given a Vector2, the other because the default
zoom, 24, was mistaken for the first run's `SetRootSize(8)`. And a green run of six capture scenarios had shown
the edge of the map: a green run says the path ran, not that the image shows anything.

The card also shows a litter size of **1~4**, where the documents say one to three. Not corrected: which is
right to state is a decision. The evidence folder went from 50 MB to 2.7 MB. Still to do for pass 1 English: one
full run of all 14 at the current revision, then passes 1 French to 6.

## Stage moves to done — 2026-09-24

**Decision: preTest -> done.** A Dog Said 2 (Workshop 3238353862, packageId
`SamBucher.ADogSaidAnimalProsthetics2`, declares 1.6) is now on disk. `_tools/Run-Tests.ps1` was rerun
against revision `a3a1cd4` and reports **37 tests, 0 failed, 0 skipped**, where it had reported 33 run
and 4 skipped. The last preTest -> done criterion that was open, an executed and green automated suite,
is established. The others were already: scenarios A-Q written with preconditions, actions and expected
results; the Pickle suites written, with their scope justified in TESTING.md; XML tests green; and
the results describe the delivered `Mod/`, which has changed only in `ATTRIBUTION.md` since the upload.

`done` means ready for the final validation in a game. It does not mean `tested`: nothing has run in
RimWorld, the eight Pickle launches are still to play, and their passes 3 to 5 can now be staged.
The session title follows the stage: `Dalmatians Renew / done`.

The audit of the same day below, and the Pickle section, keep their text as history. Where they say the
stage is preTest or that four tests are skipped, this section supersedes them.

## Workflow audit — 2026-09-24

**Decision: done -> preTest.** The 2026-09-13 audit below set `done`. Two criteria of
preTest -> done are not established today, and the session title follows the stage: `Dalmatians
Renew / preTest`. Neither is a defect of the mod; both are checks that have not been made.
This section supersedes the 2026-09-13 one on the stage and on the test counts. The stage code
is the workflow state itself, with no translation between the two.

Audited revision: `8b734cab75a0579ec33a19db19023c074628af1a`, with the five commits made in
this session on top of `9838310`. Local changes before the audit: `STATUS.md` (the 2026-09-13
audit, uncommitted), and untracked `Mod/About/PublishedFileId.txt` and four `.dds` files, all
written by the 0.1.0 upload of 2026-09-23. The distributed root is `Mod/`, 20 tracked files.
Nothing was published, no image was generated, and no RimWorld was launched: no Pickle suite
exists, so there was nothing to queue and no watcher to start.

### Ordered transition results

| Transition | Result | Evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Own `.git`, `origin` fetches, and `origin/main` equalled the local HEAD `9838310` before this session's commits. README, ATTRIBUTION, LICENSE and CHANGELOG exist; LICENSE and ATTRIBUTION are byte-identical to their copies in `Mod/` (`cmp`). Visibility `PUBLIC` is retained from 2026-09-13 and was not queried again. |
| horsMonoRepo -> ModIcon generated | Validated, build not applicable | No C# and no assembly. `git log` shows no change to `Mod/About/ModIcon.png` or `Art/` since the revision audited on 2026-09-13, where the 128 x 128 icon was inspected. Not re-inspected today. No icon was generated. |
| ModIcon generated -> Preview generated | Validated | Same: `Preview.png` is unchanged since it was inspected on 2026-09-13 (896 x 504, 514087 bytes). |
| Preview generated -> preOptions | Validated | `About.xml` name is `Dalmatians Renew (unofficial)` and the description is in English. Only the author line changed since 2026-09-13, to `1.6 adapted by Nelim`. |
| preOptions -> options | Not applicable, justified | No `.dll`, no `.cs`, and no `MainButtonDef`, `ModSettings` or settings dialog anywhere in `Mod/`, so no empty page and no shortcut. |
| options -> l10n | Validated offline | `Check-DefInjected.ps1` rerun today: 31 patch operations, 11598 defs indexed, 25 keys, 0 errors. English lives in the source defs. |
| l10n -> preTest | Validated | About declares `loadAfter` Mlie.WhaleysDogs, `loadBefore` SamBucher.ADogSaidAnimalProsthetics2 and `incompatibleWith` cucumpear.dalmatians, and the suite's load-order test passes. WhaleysDogs is installed (Workshop 2274606936). ADS 2 is not installed here, so its package ID was not re-read from disk today; the 2026-09-13 check stands. |
| preTest -> done | **Not established** | (1) Scenarios A-Q are written in TESTING.md, with preconditions, actions and expected results. (2) The suite is green where it runs, but 4 of 37 tests were skipped today for lack of A Dog Said 2: 33 ran, 0 failed. A skipped test is not a green test. (3) No Pickle (Gherkin) suite is written, and TESTING.md neither declares the passes nor justifies what stays in Gherkin. No in-game run is required for `done`. |
| done -> tested | Not reached | See the criteria under next work. No scenario has been played. |

### Checks run

- `_tools/Run-Tests.ps1`: first run 33 ran, 1 failed, 4 skipped. The failure was the test that
  asserted `About/PublishedFileId.txt` is absent, which the prepublication made false; it now
  asserts the file is present, numeric and not the original authors' item (commit `8c391e1`).
  Second run: **33 ran, 0 failed, 4 skipped**. Skipped: the predicate test, the absent-ADS guard,
  the category test, and WhaleysDogs plus ADS. Reason given by the suite: A Dog Said 2 not found at
  the Workshop path `3238353862`; searched the Workshop and Mods folders, it is not installed.
- `Check-DefInjected.ps1`: 25 keys, 0 errors.
- `git diff 2e820f8 9838310`: only the licence and name text, the author line and the two
  ATTRIBUTION copies changed since the previous audit.
- Evidence: no tracked evidence, no `.feature` file, no `Tests/` folder, and no run naming this
  mod in `pickle-reports-archive/`. Nothing was deleted; there was nothing to delete.

### Housekeeping done in this session

- `*.dds`, `Tests/Pickle/Evidence/` and `evidence/` are in `.gitignore`. No `.dds` was ever
  tracked, so none had to leave the index. The duplicate `.build/` entry was folded into one.
- The Workshop ID `3806709979` is committed (`8c391e1`, `Add published Workshop file ID for 0.1.0`).
- `CHANGELOG.md` opens with `## [0.1.0]`, the upload that created the item, and keeps 1.0.0 as
  `unreleased` above it.
- `ATTRIBUTION.md` and its copy in `Mod/` no longer say the ID file was simply dropped.
- `TESTING.md` says which evidence is worth keeping, and what is deleted and when.

### Strictly necessary next work

For `done`: write the Pickle suites and justify their scope (only what a running game can show:
the information card, the three rotations and the single-texture corpse, the two coats, the
operations tab), declare in TESTING.md how many passes there are and what each covers, and reinstall
A Dog Said 2 so the four skipped tests run. No in-game run is needed for `done`.

For `done -> tested`, once that exists: no scenario left in `@wip`; every conditional scenario
played on a map that mounts its mod, with the report read (`setName`, suite and scenario names,
`exitReason` before the numbers, scenarios played against features discovered); the passes without
the optional mods, with WhaleysDogs and ADS 2, and one for the declared incompatibility with
`cucumpear.dalmatians`; English and French, each in developer mode; the `@review` captures opened;
the logs read; a new game and disposable copies of an existing save; and no manual scenario left,
each of A-Q either automated and green or listed as not applicable with its reason.

### Optional, not blocking

- TESTING.md's opening line still says one patch, and its log table says two patch classes,
  though the WhaleysDogs integration exists. It is a wording fix.
- Scenario D, the wrong load order, may exercise the game's own ordering rather than what this mod
  declares. If so it is the kind of scenario the audit says not to write. Decide when the suites
  are written.
- The inherited standalone dessicated corpse still has only its east texture. Accepted and
  documented; its in-game fallback rendering is unverified.

## Pickle suites written — 2026-09-24

Written after the audit above, at the owner's request. They supersede the audit's first blocker
(no Pickle suite) and leave the second one, the four skipped tests, as the only thing between the
mod and `done`. **Nothing was run in a game.** No RimWorld was launched, and no run was queued.

What exists, all under `Tests/Pickle/`:

- A test companion, `Dalmatians Renew - Pickle tests`, six feature files with 41 scenarios to play
  across eight launches, and a step assembly of 34 local steps, prefixed with the mod's name.
- Six pass maps: no optional mod (English and French), WhaleysDogs (English and French), A Dog Said 2
  in the declared order, every optional mod together, A Dog Said 2 in the wrong order, and the
  original mod. Each map names `nelim.dalmatiansrenew` where the order matters, because the staging
  script otherwise places the mod under test after every overlay mod.
- `README.md` with the pass matrix and commands, and `Check-Steps.ps1`.
- In `TESTING.md`: a table saying what each manual scenario A-Q became, and the evidence section
  now points at the declared passes.

Checked offline, on 2026-09-24:

- `dotnet build`: 0 warnings, 0 errors, against RimWorld 1.6 and Pickle 4.
- `Check-Steps.ps1`: every feature parses with Pickle's own Gherkin parser; each of the 185 step
  lines matches exactly one pattern among this suite's, Pickle's 200-odd built-ins and the staged
  tool's, with none ambiguous and no local pattern unused; every `@requires` names a package some
  map stages; every map line points at a folder whose `About.xml` carries that packageId. The fixture
  load and the save and reload are accepted as runner steps because Pickle's own features use them.

Not established, and the reason the suites prove nothing yet:

- That any step does what its sentence says. Three are worth reading first on a failing run: the
  information card reading, which goes through `StatsReportUtility.StatsToDraw`; taming through
  `InteractionWorker_RecruitAttempt.DoRecruit`, which should bring the name; and pass 6, which asserts
  that the definition loaded last wins, a behaviour documented in TESTING.md J and not observed since.
- That Pickle captures the log lines written while the game loads its defs. `no warnings from mod` is
  used after a save loads; it is not relied on for startup warnings.
- Passes 3, 4 and 5 cannot even stage: A Dog Said 2 is in neither the Windows Workshop folder nor the
  WSL cache, and the staging script stops on a missing mod.

Scenarios not automated, with the reason in `TESTING.md`: K (an existing save under a changed mod
list), L (the mod list's rendering), and the emergent parts of G, H and P, which are the game's
reaction to values the suites do assert. Scenario J's second half, an old build of Nelim's Animal Ark,
cannot be reproduced. Each is a justified non-applicability and not a scenario left over.

Next work for `done`: subscribe to A Dog Said 2 so that the four skipped tests run. Next work for
`done -> tested`: play the eight launches under the machine lock, read every report (`exitReason`
first, then the scenarios played against the 41 written), open the `@review` captures, and clear or
justify each skipped scenario. Nothing in either list asks for more development.

## Workflow audit — 2026-09-13

*Superseded on the stage and on the test counts by the 2026-09-24 audit above. Kept as history.*

**Decision: awaiting in-game verification -> done.** `done` is the literal workflow
state: ready for final functional validation in game. It does not mean `tested`.
This section supersedes conflicting current conclusions in the historical entries below;
historical results and implementation notes are preserved.

Audited revision: `2e820f86eae81f816c42ac53886587ef10def825`. The working tree and index
were clean before the audit. Only STATUS.md is changed by this audit; shipped content,
images, tests and historical QA artifacts are unchanged. The distributed root is
`C:\Users\nelim\Documents\rimworld\DalmatiansRenew\Mod` (19 files), not the repository root.
Read the parent AGENTS.md, PUBLISHING.md, STYLE_RIMWORLD.md, MOD_SETTINGS.md and
TRANSLATIONS.md, applying the user's overriding workflow and interpretation rules.

### Ordered transition results

| Transition | Result | Evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Own .git directory and Git root, no superproject; origin configured; live GitHub check returns PUBLIC and remote HEAD equals audited commit. Identity is coherent across folder, repository, packageId and display name. English README, attribution, licence and changelog exist. Distributed licence and attribution are byte-identical to root copies (SHA256). |
| horsMonoRepo -> ModIcon generated | Validated; build not applicable | Content implementation is present, including optional WhaleysDogs integration. No C# source, project or shipped assembly requiring compilation. Tests passed. Directly inspected installed PNG icon: 128 x 128, 21682 bytes, outlined spotted mascot. |
| ModIcon generated -> Preview generated | Validated | Direct inspection of shipped 896 x 504 PNG, 514087 bytes, and existing 268 px thumbnail. Subject, high overhead camera, restrained colour families and text placement conform; no concrete camera concern. No historical generation report or screenshot comparison required. |
| Preview generated -> preOptions | Validated | English description and preview summary; Renew rendered at 65 percent in secondary blue; exact unofficial tag on its own line; no linking words requiring treatment. Amber rule/badge clearly separate from blue secondary text. Palette and composition retained in Art. |
| preOptions -> options | Not applicable justified; gate passed | Settings inventory below establishes no relevant settings and no empty page or MainButtons shortcut. |
| options -> l10n | Validated offline | All five French resources reviewed against owned and optional source text; 25 populated entries, native English source fallback. Shared injection checker: 25 keys, 0 errors, no unresolved targets. |
| l10n -> preTest | Validated | Core supplies base classes, inherited definitions and generic text. No DLC or required third-party dependency. WhaleysDogs and ADS 2 are optional; package IDs verified against installed About files supporting 1.6. Load order and conditional patch/root behaviour pass the suite. |
| preTest -> done | Validated | Existing automated/XML suite executed against delivered content: 37 passed, 0 failed, 0 skipped. TESTING.md A-Q supplies functional actions and expected results with relevant load configurations and save preconditions. |
| done -> tested | Unverified | No in-game scenario execution, FR/EN interface check or attributable runtime log review performed. New-game and existing-save coverage remains pending. |

### Settings audit

Inventory covered both base definitions, leather, both patches, every loaded folder,
README.md and WHALEYSDOGS.md. The animal's stats, training, leather and graphics are fixed
content/balance, not an existing user configuration contract. Optional integrations follow
the enabled mod list on load. The alternate coat is native per-pawn variation, with a default
0.5 chance (an existing third-party chance is preserved); legacy acquisition restrictions
implement the documented combined-mode behaviour while retaining saved identities.
There is no documented player need requiring an additional control for this content port,
and no supported setting currently requiring manual XML editing. Exposing all balance
constants or introducing an integration toggle would be new development, not necessary
settings work for this audit.

The complete distributed inventory contains XML, textures, metadata and legal documents;
no settings class/assembly, MainButtonDef, configuration page or shortcut is supplied.
Source search for settings/configuration/UI access confirms the only settings references
refer to ADS documentation. Therefore `settings_audit: not_applicable` is justified.
Input limits, reset, settings persistence and shortcut interactions are not applicable.
RIMMSQOL and other customization tools were not tested and no compatibility claim is made.
Per the user's explicit override, in-game verification is not needed to pass this absent-settings gate.

### Executed checks and scope

- `git status --porcelain=v1`, `git rev-parse --show-toplevel --show-superproject-working-tree`,
  `git remote -v`, `git log -1`: clean initial revision and independent repository established.
- `gh repo view vbardales/Rimworld-Dalmatians-Renew --json name,visibility,url` and
  `git ls-remote origin HEAD`: succeeded on read-only retry outside sandbox restrictions;
  PUBLIC and `2e820f86eae81f816c42ac53886587ef10def825` respectively.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1`: exit 0,
  **37 tests, 0 failed, 0 skipped**. Uses installed RimWorld 1.6 data/assemblies, ADS 2
  (installed metadata version 1.3.7) and WhaleysDogs 1.6 data. Covers XML fields/classes,
  inheritance/references, textures, metadata, base patch predicates/absence guard and
  actual Verse patch operations for combined-mode fixtures, saved IDs, coat data,
  idempotence and third-party variant preservation. This is offline integration testing.
- `& ..\scripts\Check-DefInjected.ps1 -TransMod (Join-Path $PWD 'Mod') -Targets @((Join-Path $PWD 'Mod'), 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2274606936\1.6')`:
  exit 0, 31 patch operations applied, 11598 definitions indexed, **25 keys, 0 errors**.
- Reviewed all displayed text in definitions and five French files: labels, descriptions,
  named tools, puppy/plural forms and material adjective. Patches add data/references, not
  UI sentences. No custom Keyed UI, grammar or formatting parameters exist. English source
  values provide native coverage; unnamed/inherited game text uses Core resources.
- Direct image inspection performed on Mod/About/Preview.png, Mod/About/ModIcon.png and
  Art/preview-268.png. Existing Art/preview-qa.json font/contrast figures were read as
  historical measurements, not represented as freshly rerendered measurements.

### Findings outside the next transition

**Publication defect:** PUBLISHING.md requires a final
`[url=https://github.com/vbardales/Rimworld-Dalmatians-Renew]Source code on GitHub[/url]`
link after credits. About.xml instead has a bare repository URL before its final paragraphs.
Correct this before publication. It does not invalidate the user's explicit preOptions
criteria (English description and naming), offline tests or readiness for in-game testing.
No description was edited and nothing was published by this audit.

**Nonblocking documentation cleanup:** TESTING.md's opening still says one patch and its
log table says two patch classes, despite the implemented integration. Its early Animal Ark
warning is broader than its later scenario J, which specifies older versions. Use the current
inventory and the scenario's version qualification; optional editorial updates should reconcile
these statements. Existing scenarios remain usable with the stated base/combined configurations.

**Accepted limitation, not a required correction:** the inherited standalone dessicated corpse
has only an east texture. This is deliberate and documented in TESTING.md I and attribution;
it is no longer classified as a blocking defect in remaining. Actual in-game fallback rendering
is still unverified. The combined mode preserves WhaleysDogs corpse graphics.

The upstream `silent` classification and retirement evidence are retained from the documented
2026-09-12 review; no new upstream permission is claimed. The MIT grant is explicitly limited
to port contributions and excludes original definitions/textures. Publication convention and
public visibility do not grant rights to upstream material. This audit did not repeat the
historical Steam description/comment search or change legal/visibility policy.

### Strictly necessary next work

Execute and record applicable TESTING.md A-Q scenarios in RimWorld 1.6, including English
and French, standalone and WhaleysDogs/ADS configurations, new games and disposable copies
of existing saves. Verify actual surgeries, coat rendering and save retention; review related
logs and rerun affected regressions after any fix. Record game build, load order, date and
per-scenario result. Settings and MainButtons tests remain not applicable unless that content
changes. No new feature, image generation or publication is required for `done -> tested`.

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
