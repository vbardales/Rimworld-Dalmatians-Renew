# Dalmatians Renew Pickle suite

Development only. Nothing under `Tests/` is part of the Workshop payload. The suite is written for the
shared WSL runner. **Pass 1 in English has been played on 2026-09-24 and 25: 5 of its 14 scenarios failed at
first** on causes the offline check could not see (see below), and all 14 have passed since. One full run of all
14, filed on 2026-09-25 with the tree unchanged, passed 14 of 14 with none skipped; its nine captures were read,
and the puppy scene showed no adult, so that one scenario was replayed after a step fix and its capture read. Every other pass has never
been run. Nothing here claims an in-game result that the reports do not show.

## Scope

The offline suite, `_tools/Run-Tests.ps1` and `_tools/WhaleysDogs.Tests.ps1`, owns everything that can
be proved without a game: the XML, the field mapping, the parent and reference resolution, the patch
structure and predicates, the real Verse patch operations run on isolated fixtures, WhaleysDogs' balance
being unchanged, the saved identities, the images' dimensions, the metadata and the French keys.

Pickle is limited to what needs a running game: the values the game kept after loading a whole mod list,
the operations an animal is actually offered, the stock generators, an information card, a butchered corpse,
a coat drawn, a rotation drawn, the text in the language a pass was launched in, and the pictures a person
reads. A scenario that only repeats an offline assertion was not written.

`TESTING.md` says what each of the seventeen manual scenarios A-Q became, and which are not automated and
why. Read it with this file.

## Passes

Six passes, eight launches. Optional mods are staged in the order the mod declares, and the order is the
order of the lines in the map: the staging script places every overlay mod before the mod under test unless
a line for the mod itself stands among them, which is why passes 2 to 6 name `nelim.dalmatiansrenew` in
their map.

| Pass | Map | Features | Language | What it establishes |
| --- | --- | --- | --- | --- |
| 1. Without optional mods | `wsl-deps.sans-facultatifs.map` | `01` | English, then French | The mod stands alone: defs, values, information card, leather, trade, rotations, corpse, text |
| 2. WhaleysDogs | `wsl-deps.avec-whaleysdogs.map` | `02` | English, then French | The integration: patch applied, coats, reload, trade pool, leather, corpses, text |
| 3. A Dog Said 2, declared order | `wsl-deps.avec-ads2.map` | `03` | English | The dalmatian is offered the husky's operations |
| 4. Every optional mod | `wsl-deps.avec-whaleysdogs-ads2.map` | `04` | English | Both saved races are offered the husky's operations |
| 5. A Dog Said 2, wrong order | `wsl-deps.ads2-ordre-inverse.map` | `05` | English | What happens in the order the metadata forbids |
| 6. The original mod | `wsl-deps.incompatible-original.map` | `06` | English | What happens beside the mod declared incompatible |

WhaleysDogs and A Dog Said 2 do not exclude each other, so passes 2 to 4 cover them alone and together.
Passes 5 and 6 step outside the supported configurations on purpose, to check that what is documented about
them is still true. Their scenarios assert the documented symptom as a green result. They are replayed when
the other mod changes, not at every release.

From the collection root, once `scripts/Pickle-Status.ps1` says the machine is free:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.sans-facultatifs.map -Filter '01-standalone,!@french'  -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.sans-facultatifs.map -Filter '01-standalone,!@english' -Language French
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.avec-whaleysdogs.map -Filter '02-whaleysdogs,!@french'  -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.avec-whaleysdogs.map -Filter '02-whaleysdogs,!@english' -Language French
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.avec-ads2.map -Filter '03-ads2' -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.avec-whaleysdogs-ads2.map -Filter '04-whaleysdogs-ads2' -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.ads2-ordre-inverse.map -Filter '05-ads2-wrong-order' -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DalmatiansRenew -DepMap wsl-deps.incompatible-original.map -Filter '06-incompatible-original' -Language English
```

Add `-EvidenceDir DalmatiansRenew/Tests/Pickle/Evidence/<date>-<pass>-<language>` to each, so the report is
copied into the mod before the shared folder is overwritten. `TESTING.md` says what to keep afterwards.
Do not run the Windows game, do not stage by hand, and do not switch language inside a scenario.

### Preconditions that are not in this repository

- **A Dog Said... Animal Prosthetics 2** (Workshop `3238353862`) reached the Windows Workshop folder on
  2026-09-24, so passes 3, 4 and 5 can be staged. Before that they could not: `scripts/stage-pickle-wsl.sh`
  stops on a mod present in none of its folders rather than skip it.
- WhaleysDogs (`2274606936`) and cucumpear's original (`1513691963`) are in the Windows Workshop folder.
- The scenarios use the `test-colony` fixture that ships with Pickle, and need at least one free colonist.

## Tags

- `@requires:<packageId>` skips the scenario when that package is absent. It does not stage it: the pass map
  does. A skipped scenario is not a validated one, so a report is read for what was skipped.
- `@review` marks a scenario whose only claim is the captures it attaches. Its green says the path ran, not
  that the picture is right. Each capture is opened and read before the pass counts.
- `@english` and `@french` are written against the language the pass was launched in. The filter excludes
  the other one, and each carries a `this pass runs in ...` assertion so that a pass which silently fell back
  to English cannot pass as French. It is a local step: the staged Pickle has no step for the language.

## Offline validation

```powershell
dotnet build Tests/Pickle/Source/DalmatiansRenew.PickleSteps.csproj -c Release
powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
```

The build writes `Tests/Pickle/Mod/Pickle/Assemblies/DalmatiansRenew.PickleSteps.dll`, against RimWorld 1.6
and Pickle 4. `Check-Steps.ps1` parses every feature with Pickle's own Gherkin parser, and checks that every
step line matches exactly one pattern among this suite's, the staged Pickle's and the staged tools', that no
local pattern is unused, that no Pickle `def` step names a defName shared by two def types, that every `@requires` names a package some map stages, and that every map line points at
a folder whose `About.xml` carries the packageId the line names. A step Pickle's engine plays itself, the
fixture load and the save and reload, is accepted when Pickle's own features use the same words, and listed.

What it cannot prove is that a step does what its sentence says, and that Pickle's runtime accepts what it
parses. The first run found three causes it had missed, and each is now checked or fixed:

- It read Pickle's steps from a newer development build. The WSL stages the Workshop build, which has no
  `the language is` step. The check reads the Workshop build now.
- Pickle's `def` steps refuse a defName that two def types share, and `CCPDalmatian` is a ThingDef and a
  PawnKindDef. Three scenarios failed on it. The check now flags it, and local steps say the type.
- The husky declares Wildness 0 in 1.6, not 0.75. The control is a hare.

Three things are worth reading first when a run fails:

- `Dalmatians Renew ... lists the stat "Wildness"` reads the information card's entries through
  `StatsReportUtility.StatsToDraw`, and compares the displayed text, `0%` for the dalmatian and `75%` for a hare.
- `Dalmatians Renew tames` calls `InteractionWorker_RecruitAttempt.DoRecruit`, and expects a name to come
  with it. If naming on taming lives elsewhere in the game, the step is where to look.
- Pass 6 asserts that the definition loaded last wins, as TESTING.md scenario J documents it. It is the one
  assertion here that rests on a documented behaviour nobody has observed this year.
