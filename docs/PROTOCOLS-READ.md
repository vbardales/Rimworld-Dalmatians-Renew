# Protocols read by the Dalmatians Renew session

The owner asked (2026-09-25) that this session reread the protocol documents at the start of a session and after
every compaction of its context, and write down which version of each it read, so that a decision can be traced to
the rule it rested on, and so that a document that did not help is not read again for nothing. `WELCOME.md` of the
TicketDispatcher, section 5, states the rule; the dispatcher keeps its own record in
`Rimworld-Ticket-Dispatcher/docs/DOCS_READ.md`.

**Version.** The protocol documents are tracked by the protocols repository (`vbardales/Rimworld-protocols`, git-dir
`C:\Users\nelim\Documents\rimworld-protocols.git`, work tree the monorepo folder), not by the monorepo any more. The
version below is the last commit of that repository that touched the file, with the date, plus the first eight hex
digits of the SHA-256 of the file as it was read, which stays true even if history is rewritten. "Working copy" says
whether `git status --short` showed the file as modified.

## Read on 2026-09-25, after the protocols repository's commit `0743ff9` (17:52)

Read whole, line by line, unless the last column says otherwise.

| Document | Version read | SHA-256 | Working copy | Useful to this mod? |
| --- | --- | --- | --- | --- |
| `AGENTS.md` | `3a1d2cb` (2026-09-24 12:08) | `36631e73` | clean | **Yes, every session.** Evidence policy, the CI rules, `docs/runs/` as one line per run. |
| `AUDIT.md` | `49cd841` (2026-09-25 17:09) | `f46fe88e` | clean | **Yes, every session.** The stage chain and its criteria, the Pickle rules, fail fast, the 32 px icon control. |
| `PUBLISHING.md` | `0743ff9` (2026-09-25 17:52) | `d3660c50` | clean | **Yes, before `prepublished`.** Description sections, thanks, comments registry, change note format. |
| `TRANSLATIONS.md` | `b83933b` (2026-09-23 20:46) | `3368579d` | clean | Read, **nothing new for this mod**: the gate was passed and no text has changed since. Reread only if a label, a def or a French file changes. |
| `STYLE_RIMWORLD.md` | `7311308` (2026-09-25 15:50) | `de13cbe5` | clean | Read the parts that concern a delivered file only (the ModIcon check at 32 px, tags, palette record, file limits, the counts rule). **The image-generation parts are the owner's and never mine.** Reread only if the icon or the preview is audited. |
| `scripts/SEARCHING.md` | `372c447` (2026-09-23 21:01) | `9dbd52b2` | clean | **Not useful now.** Reread only when a defName, a class or a texture path has to be searched across the corpus, and then use `Search-Workshop.sh`. |
| `PickleTools/README.md` | `2b7b6d0` (2026-09-25) | `6ea97418` | clean | Read for the tool catalogue. **Not needed again** unless a shared tool is considered. `NewColony` is the one worth remembering. |
| `PickleTools/Headless/README.md` | `b2712fc` (2026-09-25) | `988dbf0d` | clean | **Partly useful.** Read whole are the sections on running, filter terms, several passes, waiting, dlc-free passes, reports and traps; the restart, hang and staging sections were skimmed. |
| `PickleTools/Docs/steps.md` (on disk as `docs/steps.md`) | `d6d8db1` (2026-09-25) | `61750eca` | clean | **Yes when writing steps.** Tool steps only; Pickle's own catalogue is on GitHub, and I read the built-in steps from the staged Pickle's own assemblies. |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `d403592` (2026-09-25) | `6f556de4` | clean | **Not yet.** Needed at `prepublished`: dry-run, `dispatch-publish.sh`, `generate-publish-workflow.sh`, the gallery being manual. Reread then. |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `79668cc` (2026-09-25) | `b9f93a68` | clean | **Yes, every session.** How to file a run, filter terms, no watcher, no SHA in a request, deleting archives. |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `79668cc` (2026-09-25) | `9ac5e37b` | clean | **Yes when filing.** Every option, the exit codes, `-DepMap` as a bare file name. |

`PUBLISHING.md` had been read earlier the same day at an older version; what changed since is that a Steam change note
starts with its version number alone on the first line (`[b]1.3.0[/b]`), and the fail-fast paragraph was rewritten.
`AUDIT.md` had been read at 220 lines and is 232 now: runs are filed as requests rather than launched, the only
watcher is the TicketDispatcher, the 32 px icon control was added, and the fail-fast policy was written out.

### This repository's own documents

| Document | Version (this repository) | State |
| --- | --- | --- |
| `STATUS.md` | `62edd2c` | current; its own history sections are kept. |
| `README.md` | `2e820f8` (2026-09-13) | **stale**: no mention of `Tests/Pickle/`, `docs/`, or the 0.1.0 Workshop item, and it still says litters of one to three. Not touched yet. |
| `CHANGELOG.md` | `25cc2d9` | current: `0.1.0` and an unreleased `1.0.0`. |
| `ATTRIBUTION.md` | `958ad88` | current; its copy in `Mod/` is byte-identical. |
| `LICENSE` | `9838310` | current; its copy in `Mod/` is byte-identical. |
| `TESTING.md` | `94a82e0` | current: scenarios A-Q, what each became, the evidence rule. |
| `docs/runs/` | `62edd2c` | one file, one line per run. |
| `Tests/Pickle/` | `62edd2c` | the suite, its README, six pass maps. |
| `Mod/About/About.xml` | `a9782c0` | the description sent to Steam by the 0.1.0 upload; **lacks** the closing sections. |
| `PUBLICATION.md`, `BACKLOG.md`, `NOTES.md`, `BUGS.md` | **absent** | `PUBLICATION.md` is required before `prepublished` (description, change note, gallery order, comments, dependencies, adult-content answers). The three others have no rule asking for them and were not created. |

## What the reading changed, and what it left open

Found by comparing the documents with what this session did:

- **A request carries no SHA.** The mod is staged from the working tree when the ticket is played, sometimes hours
  after filing, and the tree changed while my tickets were pending. The "staged from `<sha>`" in `docs/runs/` is the
  commit that was current when the ticket was filed, not a proof of what ran. Labels carried no SHA until now: they
  will, and the tree stays still until `RUN_DONE`.
- **A full validation run of pass 1 in English does not exist.** All fourteen scenarios have passed, across five
  tickets and several revisions. The initial validation is one run of all of them, filed once the tree is frozen.
- **The suite needs a feature filter per pass**, where `WELCOME.md` says a validation plays everything without one.
  The reason is that `01` assumes the optional mods are absent and `02` to `06` assume one is present.
- **Fail fast** (owner, 2026-09-25) applies to the `1.0.0` of an item created by the `0.1.0` prepublication. Before
  a `publish`: no red scenario without a green replay, the Workshop gallery, and the owner's manual validations;
  the rollback target chosen beforehand. The regression pass may follow the publication.
- **Icon at 32 px.** `AUDIT.md` now asks for the delivered icon to be checked at 32 px, and for a failure to be put to
  the owner. This session generates no icon and has not run the check.
- **`.gitattributes`** marks PNG as binary but not DLL, which `PUBLISHING.md` asks for; a DLL is committed under
  `Tests/`.
- **The description sent by 0.1.0** lacks `IF I GO QUIET`, `AI-GENERATED`, `THANKS` and the closing GitHub link.
  Codex is not named, Pickle and PickleTools are not thanked, and no mod name carries its Workshop link. The comments
  registry covers Pickle, and does not cover WhaleysDogs, A Dog Said 2 or the original mod.
- **One search of the Workshop was done with a recursive `grep`** (the A Dog Said 2 lookup). `SEARCHING.md` says
  never to; `Search-Workshop.sh` is the tool.
- **Deleting long-named reports:** `Remove-Item` fails on capture names past `MAX_PATH`; a `rmdir` with the `\\?\`
  prefix worked here, and `robocopy /MIR` from an empty folder is the documented way.

## When to reread

At the start of a session and after every compaction: `AGENTS.md`, `AUDIT.md`, `WELCOME.md`. Before filing a run:
`SUBMIT.md`. Before writing steps: `docs/steps.md`. Before `prepublished`: `PUBLISHING.md` and `OPERATIONS.md`. Not
unless something moves: `TRANSLATIONS.md`, `STYLE_RIMWORLD.md`, `SEARCHING.md`, `PickleTools/README.md`.
