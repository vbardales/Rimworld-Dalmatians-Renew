# Images for the Workshop page, on the owner's showcase colony (her ruling of 2026-09-25: the rules of
# Work Studio's PUBLICATION.md, "Workshop screenshots", apply here).
#
#   - The scene is the fixture "nelim-zen-meadow-studio" of PickleTools/ScreenshotStudio, staged only by
#     wsl-deps.studio.map. Every other pass skips this feature.
#   - Run it in English: the Workshop page is English.
#   - The dalmatians stand in the flower glade, near cell 154,98 (the studio's "flowers" preset).
#   - The map shot shows a game window the mod changes: the whole interface, uncropped, screenshot mode off.
#     The information card is this mod's own window in front of the interface: screenshot mode hides the HUD
#     around it, the same pattern 01-standalone.feature uses for its Wildness capture. The runner starts the
#     game with developer mode on: it is turned off for the map capture.
#   - A capture on the map aims at the glade, never at the black tiles. What is worth seeing is circled in red
#     by hand afterwards, since the meadow is busy.
#   - Each image is opened and looked at before it is called ready; its composition is the owner's call.
#
# Raw captures land in Art/Workshop/studio-raw/ (ignored by git) and the finished images are copied into
# Art/Workshop/ numbered 01-, 02-.
@review @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.screenshotstudio
Feature: images for the Workshop page

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused

  Scenario: a dalmatian and its puppy in the flower glade
    Given Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 98
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian" near the cell 154 98
    When Dalmatians Renew centres the camera two cells south of "Rex"
    And Dalmatians Renew shows "Rex" facing south
    And Dalmatians Renew shows "Pup" facing south
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    Then I take a screenshot "Workshop page, the dalmatian and its puppy"

  Scenario: the information card of the dalmatian, with Wildness at zero
    Given Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 98
    When Dalmatians Renew centres the camera two cells south of "Rex"
    And Dalmatians Renew opens the information card of "Rex"
    Then Dalmatians Renew the information card of "Rex" lists the stat "Wildness" at "0%"
    When Dalmatians Renew filters the open information card to "wildness"
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    Then I take a screenshot "Workshop page, the information card"
    And Nelim's Pickle Tools: screenshot mode is disabled
