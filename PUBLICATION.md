# Publication

What the Workshop page needs and the rest of the repository does not hold. It serves twice: for the
first release, and for whoever takes the mod over.

**Status: drafted, 2026-09-25.** Workshop item `3806709979` was created private by the 0.1.0
prepublication of 2026-09-23 and its `PublishedFileId.txt` is committed and pushed. No Git tag and no
GitHub release exist, and none is made by hand: the CI creates them after a successful upload.
Nothing below has been posted or pasted anywhere. The stage is `done`, not `prepublished`
(see `STATUS.md`).

## What blocks the publication

Not restated from `AUDIT.md`; only what is specific to this mod.

- The Pickle suite: all eight launches are green (`docs/runs/`); the seven smoke tickets that prove the
  `packageId` rename of 2026-09-28 are in the queue.
- The gallery is half made: the information card is validated, the dog shot is in the queue (see below).
- The rollback target cannot exist before the first publish: the tag is created by the CI after a successful
  upload, and no artificial tag is made (CI/CD session, 2026-09-27; see "Fail fast").
- The description on the Steam page is the one 0.1.0 sent. The one-source Markdown standard is adopted at the
  first publication (see "Description"); until then, no action.
- The owner's manual validations: the installed copy (row 1) and removing the mod from a save (row 4).

## Description

**Standard announced on 2026-09-25 by the CI/CD session (Rimworld-Release-Admin `f196148`, `OPERATIONS.md`,
"Changing where the Steam description comes from"; not adopted here yet, nothing forces it).** The description is
written once, in Markdown, in a ```markdown block under `## Steam description`; the CI converts it to BBCode and
generates the plain-text `<description>` of `About.xml` from it, and a dry-run or publish stops if they differ.
The block holds no code fence and ends with `[Source code on GitHub](URL)`. The block below is still BBCode under
`## Description`, as the manual path read it before; **at the first publication it is rewritten in Markdown under
the new heading, `About.xml` is regenerated (the first `--write` changes its text, so the diff is read), and the
SHA changes, so the dry-run is redone.** `OPERATIONS.md` says the dry-run cannot compare with a private item's
page, so the text is read by hand, and its printed SHA-256 identifies what would replace the page. The change note
must carry its version on the first line, `[b]1.0.0[/b]`, or the CI refuses it.

`SetItemDescription` runs only when an item is created, so the page keeps what 0.1.0 sent. The shipped
`About.xml` was aligned on 2026-09-25 (litter wording, the three closing sections, Codex, Pickle and
PickleTools, Workshop links, the final GitHub link). The same text, as it should read on the page, in
Steam BBCode. **Read it once more before pasting**, and refresh the sentence that says what the
automated runs cover to whatever `docs/runs/` shows that day.

```
[b]UNOFFICIAL.[/b] This mod is published without the original author's explicit consent. If the original author contacts me to request its removal, I undertake to take it down promptly.

One dog. A dalmatian: a medium-sized, spotted, sweet-natured pet that nuzzles, trains to Advanced, tames easily, and is bought and sold like a husky.

No DLC, no dependencies, no assembly. Three defs, four textures and two optional patches.

I am not the author of this mod. The animal, its artwork and its stats are cucumpear's and lavie2k's - all I did was bring it forward to 1.6, repair what the port turned up, and write the French. Credit goes to them; mistakes in the port are mine.

Original mod: [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1513691963]Dalmatians[/url] - declares 1.0 to 1.4 and nothing further.

[h2]What's in it[/h2]
[list]
[*]The dalmatian. Body size 0.70, market value 250, comfortable down to -30C, omnivore, Advanced trainability, wildness 0, gestation 25 days, litters peaking at two puppies, lives about 12 years. It nuzzles, it takes a name the moment it is tamed, and it never turns manhunter.
[*]Dalmatian leather, an almost white leather of its own. It insulates a little less against cold than plain leather does, 14 against 16, and is worth a shade less.
[*]Support for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3238353862]A Dog Said... Animal Prosthetics 2[/url], if you use it: the dalmatian is offered the same animal surgeries as vanilla's huskies and labradors. Inert if the mod is absent. It must load before A Dog Said 2, which the mod's metadata declares.
[/list]

[h2]With WhaleysDogs (Continued)[/h2]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2274606936]WhaleysDogs (Continued)[/url] supplies the main dalmatian and its balance when both mods are enabled. This port adds an alternate spotted coat, French labels, dedicated leather and ADS 2 support. Its original coat and complete corpse graphics remain. Load WhaleysDogs first, this mod next, then ADS 2 if used.

Existing dogs from this port remain and can still be sold; their ordinary random acquisition is disabled while WhaleysDogs is active. Old dogs can still reproduce, and explicit spawning remains possible. No saved animal is converted or deleted. Without WhaleysDogs, standalone behaviour is unchanged.

[h2]What changed[/h2]
Two things, and the second is the one that was actually broken.

Wildness stopped being a property of the animal and became a stat. The def declared it the old way; in 1.6 that element matches no field, so the game logs one line and loads the animal without it. It is now a stat, written the way vanilla's own dogs write it.

The A Dog Said patch had stopped working: it looked for recipe names that A Dog Said used up to 2023, so it found nothing and did nothing. It now adds the dalmatian to the three categories A Dog Said... Animal Prosthetics 2 uses, where vanilla's huskies and labradors already are. Its condition was also a test that matched every recipe in the game; each name is now compared properly.

Otherwise nothing moved: the stats, the tools, the litter curve, the sounds, the trade tags, the leather and the four textures are as cucumpear and lavie2k left them. French was added. The defName is unchanged, so a save moves between the two mods without losing a dog.

[h2]Credit and removal[/h2]
cucumpear and lavie2k declared no licence: no file in the mod, nothing in its About.xml, no linked repository, and nothing in the body of the description on its Steam page. It is republished here under the usual convention for abandoned mods - full credit, a link to the original, and removal on request. If either author would rather this port did not exist, say so and it comes down: no argument, no delay.

The two mods cannot run together - the original is declared incompatible. Run one or the other.

Content mod: removing it mid-save destroys any dalmatian already in the colony.

[h2]If I go quiet[/h2]
If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

[h2]AI-generated[/h2]
The port work (the XML, the patches, the tests and the documentation) was done with the help of AI assistants, Claude (Anthropic) and Codex (OpenAI), under human direction. Automated in-game runs cover the mod on its own, in English; the other configurations are still being run.

[h2]Thanks[/h2]
[list]
[*]cucumpear and lavie2k, for the dog, its artwork and its balance.
[*]Mlie, who maintains [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2274606936]WhaleysDogs (Continued)[/url], and Whaley, its original author: this mod is arranged around theirs when both are enabled.
[*]SamBucher, for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3238353862]A Dog Said... Animal Prosthetics 2[/url], whose surgery categories the dalmatian joins.
[*]The authors of [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url] and of [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3806142401]PickleTools[/url], used to test the port in game. They are for development only and never a dependency of this mod.
[/list]

Licence and what was carried over: see ATTRIBUTION.md in the source repository.

[url=https://github.com/vbardales/Rimworld-Dalmatians-Renew]Source code on GitHub[/url]
```

Checked against `About.xml` on 2026-09-25: every Workshop name carries its link, the closing sections come
in the order the protocol gives, and the last line is the GitHub link. The GitHub page itself was not
opened from this session, so the link's target is coherent with the remote and the `<url>` field but not
seen live.

## Images

- **Preview** (`Mod/About/Preview.png`): a dalmatian asleep on straw in lamplight, with a compact top-left
  panel generated by the shared `scripts/Render-Preview.cjs` renderer. The RimWorld title is followed on
  one secondary-colour line by `Renew (unofficial)`. `Art/echo.png` is the final pre-sized transparent
  line-art mask redrawn from the adult dalmatian visible in `Art/Gallery/1-the-dalmatian-and-its-puppy.jpg`:
  it is used unchanged, tinted with the accent colour, flipped horizontally and limited to
  less than half the panel. The transparent mascot source `Art/ModIcon-cutout.png` sits bottom-left at
  `+15°`, without outline, over its local radial veil. Placement is explicit in `Art/preview-copy.json`;
  it is not selected from an "emptiest corner" rule.
- **ModIcon** (`Mod/About/ModIcon.png`, 128 px): a winking spotted mascot with a sparkle, regenerated from
  the same design on true transparency. Its black outline, spots, eye, wink and smile remain opaque.

## Screenshots, in this order

Steam shows the first image large under the Preview, and the gallery is uploaded by hand (`OPERATIONS.md`)
from `Art/Gallery/`, which is also the workflow's gallery directory. It holds only the images to upload,
numbered `0-`, `1-`, `2-` in page order: no old version, no raw capture, no subfolder (`PUBLISHING.md`, Images).

**The owner ruled on 2026-09-25 that Work Studio's rules apply here too** (`WorkStudio/PUBLICATION.md`,
"Workshop screenshots"): the shots are taken on her showcase colony, the fixture `nelim-zen-meadow-studio` of
`PickleTools/ScreenshotStudio`, in English, by a feature skipped in every other pass. Ours is
`Tests/Pickle/Mod/Pickle/Features/07-publication-shots.feature`, played with `wsl-deps.studio.map`. An option
window is cropped tight with 16 px of margin; a game window the mod changes is the full interface. Every upload
under 2 MB, cropped and never resampled, named as a player would name it, each opened and looked at; a green
capture scenario proves the journey ran, not that the image shows anything.

**The owner's ruling of 2026-09-27**: the information card may be cropped; the dog shot must fill at least half
the frame's height. The game's camera stops at `RootSize` 11 (`CameraMapConfig.sizeRange.min`, off Steam Deck),
at which a dog is about 45 px, so the shot lowers that minimum in its own step and zooms to 0.9 on the pair,
standing side by side.

**The owner's ruling of 2026-09-29**: the gallery now opens on a copy of the Preview itself. `0-preview.png`
is `Mod/About/Preview.png` as it ships (with the mascot, see Images above), so the first thing a visitor sees
on the page and in the gallery is the same image.

| Order | File | What it shows | State |
|---|---|---|---|
| 0 | `0-preview.png` | A byte-identical copy of `Mod/About/Preview.png` | Generated showcase |
| 1 | `1-the-dalmatian-and-its-puppy.jpg` | The dalmatian and its puppy side by side, in the flower glade, filling about half the frame, no tooltip over them | Opened and read 2026-09-29; saved as JPEG q95 (the 1920x1080 PNG was 2.1 MB, over the 2 MB cap), 383 KB. **Validated by the owner on 2026-09-29** |
| 2 | `2-the-information-card.png` | The card filtered to Wildness (0%), with the litter size and the source line, in the window and 16 px | Cropped to 980x787, 0.21 MB, **validated by the owner on 2026-09-27** |

The captures taken on the test fixture stay `@review` evidence, not gallery images.

## Dependencies and DLCs

**No DLC is required, and no mod.** `supportedVersions` declares 1.6 only.

| Declared | packageId | Actually required |
|---|---|---|
| `loadAfter` | `Mlie.WhaleysDogs` | **No.** Optional. Its folder `Compatibility/WhaleysDogs` is read only when it is active (`LoadFolders.xml`, `IfModActive`) |
| `loadBefore` | `SamBucher.ADogSaidAnimalProsthetics2` | **No.** Optional. The order matters: A Dog Said 2 copies its category lists with its own last patch, so this mod has to have added the dalmatian before |
| `incompatibleWith` | `cucumpear.dalmatians` | Same `defName`s as the original; run one or the other |

Pass 5 of the Pickle suite plays the wrong order on purpose, and pass 6 plays the original beside this
mod, to check that what the documents say about them is still true. Neither has been run.

## Manual validations of the owner

`AUDIT.md` asks for none at `tested`: every scenario A-Q is automated and green, or listed in `TESTING.md` with the
reason it is not. `AUDIT.md` also lists "the owner's manual validations" among the things a `publish` does not
skip, without saying which. What follows is a proposal drawn from the "stays manual" column of `TESTING.md` and
from `PUBLISHING.md` ("Juste après"); it is hers to change.

| # | What to look at | Why a test cannot |
|---|---|---|
| 1 | Subscribe to item `3806709979`, start a game with the installed copy, tame a dalmatian: it takes a name, and the information card reads as the capture did | The installed copy is what players get; the suite plays the working tree |
| 2 | With A Dog Said 2: the Health tab offers the animal surgeries a husky is offered (scenario C) | The look of the Health tab is vanilla's; the operations are asserted |
| 3 | A duster made from the leather: the garment's colour (F) | Vanilla's reaction to `stuffProps.color` |
| 4 | A real save with a dalmatian, then the mod removed: the dog is destroyed (K). Adding the mod to a save is not checked separately, every Pickle scenario already does it; swapping with the original, declined by the owner on 2026-09-27, stays an offline check that the `defName`s are unchanged | A changed mod list is the game's handling |
| 5 | ~~The mod list entry: name, icon and preview render (L).~~ Not needed, the owner ruled on 2026-09-27: it is the game's rendering, already checked offline (name, icon and preview dimensions) | The list's rendering is the game's |
| 6 | The gallery: which captures, in which order, on which colony (see Screenshots) | A composition is a choice |
| 7 | The description pasted on the page, read once more | It is sent only at creation, so the page is edited by hand |
| 8 | Then, and only then, the visibility, the comments subscription and "Watch all activity" (`PUBLISHING.md`) | Steam, by hand, by the owner |

A dog seen nuzzling, a litter born, a trader rolling one are random and are not asked of anyone.

## Mature content checkboxes

**None of them.** The mod adds one dog and its leather. The two pictures it ships were opened: a
dalmatian asleep on straw, and a winking mascot. The Workshop screenshots are not produced yet; each one
must be opened before this answer is final.

## Steam change notes

Written at upload time, in the Change Notes tab. Unlike the description they go out again on every
update. The version stands alone on the first line.

### 1.0.0

```
[b]1.0.0[/b]

First release. Port of cucumpear's and lavie2k's Dalmatians to RimWorld 1.6.

[list]
[*]Wildness is a stat now, as in 1.6, so it shows on the information card.
[*]The A Dog Said... Animal Prosthetics 2 patch works again: the dalmatian is offered the animal surgeries.
[*]With WhaleysDogs (Continued): its dalmatian stays the main one, this mod adds an alternate coat, French labels and its own leather. Saved dogs are kept.
[*]English and French.
[/list]

Nothing else was rebalanced.
```

## Fail fast: the rollback target

A rollback is a **new publication**, not an unpublication: the workflow is dispatched with `ref` = the full SHA
of the last good commit and the next patch number, and the change note reads "Rolls back to <what>, because
<what failed>". The version numbers only go up and a tag that exists is refused. The item's visibility is not
touched by the CI: making it private again is a manual act of the owner on Steam.

`AUDIT.md`, `prepublished → published`: before the `publish`, every scenario that failed has a green
replay, the gallery is done and the owner's manual validations are made. The regression pass may follow.
**The rollback target is not chosen.** The only earlier upload is the private 0.1.0 prepublication,
made from the folder as it stood on 2026-09-23 and not from a tagged commit, so it is not a target that
can be reproduced; the first real target is the SHA of the 1.0.0 that passes its dry-run, and it is
written here at that moment.

## Comments on other mods' pages

`WORKSHOP_COMMENTS.md` decides; it is keyed by Workshop id. Rows added on 2026-09-25 as `drafted`, to
post **only after item 3806709979 is public**. Under 1000 characters each, a bare URL on the last line.

| Recipient | Id | State | Reason |
|---|---|---|---|
| WhaleysDogs (Continued) | 2274606936 | drafted | Integration declared, patched and played by passes 2 and 4 |
| A Dog Said... Animal Prosthetics 2 | 3238353862 | drafted | Integration declared, patched and played by passes 3, 4 and 5 |
| Dalmatians (original) | 1513691963 | drafted | The mod this one is a port of; factual, not a compatibility claim |
| Dogs mate (Continued) | 2441132298 | drafted | Patch joins its Dog group; played by passes 7 and 9 |
| Better Crossbreeding | 3520675842 | drafted | Patch crosses with the three vanilla dogs; played by passes 8 and 9 |
| Pickle | 3791648678 | already `posted` | Only `Covers` changes: add `Dalmatians Renew` |
| PickleTools | 3806142401 | `not_applicable` | Same author, private page; no comment to oneself |
| Harmony, RimLogging | | not concerned | Neither is used by this mod or staged by its suite |

### WhaleysDogs (Continued), 2274606936

```
Hello Mlie, and thank you for keeping WhaleysDogs alive! 😊

I've been porting an old dalmatian mod to 1.6 (Dalmatians Renew, unofficial) and I wanted it to sit nicely beside yours rather than fight it. When both are on, your dalmatian stays the main one with your balance; mine only adds a second spotted coat, French labels and a leather, and steps out of trading and wild spawning. Nothing of yours is copied and nothing saved is deleted.

Your dalmatian is the reason the two coexist at all, so: thank you ✨ If anything in there bothers you, just say and I'll change it.

https://steamcommunity.com/sharedfiles/filedetails/?id=3806709979
```

### A Dog Said... Animal Prosthetics 2, 3238353862

```
Hello SamBucher, and thank you for A Dog Said 2! 🐕✨

I ported an old dalmatian mod to 1.6 (Dalmatians Renew, unofficial) and its surgery patch was pointing at the recipe names the earlier A Dog Said used, so it had stopped doing anything. It now joins your ADS_Cat1 to ADS_Cat3 categories, and I noticed why load order matters: your final patch copies the category lists onto the real recipes, so the dalmatian has to be added before it. The mod declares loadBefore for that.

Thanks for making the categories so easy to hook into 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806709979
```

### Dogs mate (Continued), 2441132298

```
Hello Mlie, and thank you for keeping Dogs mate going! 🐶

I brought an old dalmatian mod up to 1.6 (Dalmatians Renew, unofficial) and read how your own compatibility patches work, so mine does the same: it appends the dalmatian to your Dog group when your mod is there and does nothing otherwise. The husky, labrador and Yorkshire terrier now seek it and it seeks them.

Your patch files made it very easy to do it the way you intended. Thank you 💛 If I put it in the wrong group, tell me.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3806709979]Dalmatians Renew[/url]
```

### Better Crossbreeding, 3520675842

```
Hello DizzyEevee, and thank you for Better Crossbreeding! 🐕

In Dalmatians Renew (unofficial, an old dalmatian mod brought to 1.6) the dalmatian can now cross with the husky, labrador and Yorkshire terrier, each way, and the pup is either parent's breed. I found that the game reads the male's canCrossBreedWith and your mod reads the mother's extension, so the patch writes both halves, and I used your class name as compiled (CrossBreeding) rather than the one in the Example folder.

Thanks for a mod that left the choice of outcome to the other mods 💛

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3806709979]Dalmatians Renew[/url]
```

### Dalmatians (original), 1513691963

```
Hello cucumpear and lavie2k! 🐾

Thank you for the dalmatian: I loved this little dog and could not bear that it stopped at 1.4, so I brought it forward to 1.6 as Dalmatians Renew (unofficial), with its stats and artwork as you left them. It fixes the wildness stat, repairs the A Dog Said patch and adds French; the defName is unchanged, so saves move between the two.

It is credited to you everywhere, and if you would rather it did not exist, say so and it comes down, no argument, no delay. Thank you for the dog 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806709979
```
