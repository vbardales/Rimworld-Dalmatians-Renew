# Images for the Workshop page, one story told in three pictures on the Sanctuary of Nelim (the fixture "Nelims-tribe" of
# Sanctuary Backlot; Nelim is Virginie, the one colonist). Owner rules of 2026-10-06 to 2026-10-11 (GALLERY.md): the session is
# the director, one scenario is one picture, every picture is a staged photograph with something alive in it, and each one is
# opened and judged before it reaches the owner.
#
# The story: Nelim and her dalmatians. A walk in the flower garden at noon, the puppy at her heels (1); the same pair indoors,
# in the salon by the fire hall, the puppy asleep and the adult watching (2); then the species card, the plain proof of what the
# mod adds (3). The first picture is the one Steam shows large: the animal, its coat, its puppy, and a person who gives scale.
#
#   - Staged only by wsl-deps.sanctuary.map. Every other pass skips this feature. Run it in English.
#   - Pictures 1 and 2 show the map alone (the game's own screenshot mode): the mod adds an animal, not an interface.
#   - Picture 3 is the species window in front of the bamboo backdrop `window-backdrop-for-height`; it is cropped sideways by hand
#     afterwards (5 px of backdrop each side of the window, full height), as GALLERY.md asks.
#   - What a capture shows that comes from the scene or the shared tools (a pile counter, a name left on screen, a zone painted on
#     the floor) is not worked around here: it goes to NPT with the capture, and the picture is not kept.
#   - The runner starts the game with developer mode on: it is turned off before each capture.
@requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @review
Feature: images for the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: Nelim and her dalmatians in the flower garden
    Given Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 105
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian" beside "Rex"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" stands at (152, 105) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    When Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim and her dalmatians in the flower garden"
    And Nelim's Pickle Tools: the interface is shown again

  Scenario: the dalmatians by the fire in the salon
    Given Nelim's Sanctuary: the animals are removed from the sanctuary "sofa-corner"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 187 122
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian" beside "Rex"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" stands at (185, 124) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    When Nelim's Sanctuary: I frame the sanctuary "sofa-corner"
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, the dalmatians by the fire"
    And Nelim's Pickle Tools: the interface is shown again

  Scenario: the information card of the dalmatian, with Wildness at zero
    Given Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 105
    When Nelim's Sanctuary: I frame the sanctuary "window-backdrop-for-height"
    And Dalmatians Renew opens the information card of "Rex"
    Then Dalmatians Renew the information card of "Rex" lists the stat "Wildness" at "0%"
    When Dalmatians Renew filters the open information card to "wildness"
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    Then I take a screenshot "Workshop page, the information card"
    And Nelim's Pickle Tools: screenshot mode is disabled
