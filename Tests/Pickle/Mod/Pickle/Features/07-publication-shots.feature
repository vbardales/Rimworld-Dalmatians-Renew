# Images for the Workshop page, one story told in three pictures on the Sanctuary of Nelim (the fixture "Nelims-tribe" of
# Sanctuary Backlot; Nelim is Virginie, the one colonist). Owner rules of 2026-10-06 to 2026-10-11 (GALLERY.md): the session is
# the director, one scenario is one picture, every picture is a staged photograph with something alive in it, and each one is
# opened and judged before it reaches the owner.
#
# The story: Nelim brings her dalmatians home. Shooting plan, one line per picture (GALLERY.md):
#   1. Flower garden, mid-morning (hour 10), root size 3.6: the two dogs face the camera, the puppy has picked up a log as if it
#      had been playing fetch, and Nelim, a step to their west, turns toward them and not toward the lens: she is not posing, she is
#      with them. Says what the mod adds: an animal, its spotted coat and its two life stages. Steam shows it large.
#   2. Sofa corner of the salon, the same day at dusk (hour 19), root size 2.8: they followed her indoors; the fire is lit beside
#      the couches, the light is warm and low, the two dogs face the camera and Nelim, standing, looks down at them; says that the
#      animal is a household companion, not a wild thing. Different light, setting and mood from picture 1: it is not a repeat.
#   3. Species card on the bamboo backdrop: Wildness 0 % and the source line, the plain proof (cropped sideways by hand).
#   Nelim's look, the same in 1 and 2 (the story is one day): hair pulled back in a short ponytail so the face shows; a cheerful, smiling
#   face held neutral so no job or mood frowns it; a deep teal collar shirt and dark brown trousers, the two colours the white dogs, the
#   orange flowers and the red carpet all leave free. No other pawn: Nelim is the protagonist, guests are optional (GALLERY.md).
#   The puppy is not asleep and time does not advance between the pictures: no step exists for either, so the story does not claim them.
#
#   - Staged only by wsl-deps.sanctuary.map. Every other pass skips this feature. Run it in English.
#   - Pictures 1 and 2 show the map alone (the game's own screenshot mode): the mod adds an animal, not an interface.
#   - Picture 3 is the species window in front of the bamboo backdrop `window-backdrop-for-height`; it is cropped sideways by hand
#     afterwards (5 px of backdrop each side of the window, full height), as GALLERY.md asks.
#   - What a capture shows that comes from the scene or the shared tools (a pile counter, a name left on screen, a zone painted on
#     the floor) is not worked around here: it goes to NPT with the capture, and the picture is not kept.
#   - The runner starts the game with developer mode on: it is turned off before each capture.
@requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @review
Feature: images for the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: Nelim and her dalmatians in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 10
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 105
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian" beside "Rex"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "BriefPonytail"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthClassicSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (152, 105) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Dalmatians Renew turns "Rex" to face South
    And Dalmatians Renew turns "Pup" to face South
    And Nelim's Pickle Tools: "Pup" carries the item "WoodLog"
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And Nelim's Pickle Tools: the camera root size is set to 3.6
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim and her dalmatians in the flower garden"
    And Nelim's Pickle Tools: the interface is shown again

  Scenario: the dalmatians by the fire in the salon
    Given I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Sanctuary: the animals are removed from the sanctuary "sofa-corner"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 188 123
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian" beside "Rex"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "BriefPonytail"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthClassicSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (186, 123) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Dalmatians Renew turns "Rex" to face South
    And Dalmatians Renew turns "Pup" to face South
    And Nelim's Pickle Tools: I place the decor "Campfire" at (189, 122)
    And Nelim's Pickle Tools: the decor "Campfire" at (189, 122) is lit
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Sanctuary: I frame the sanctuary "sofa-corner"
    And Nelim's Pickle Tools: the camera root size is set to 2.8
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, the dalmatians by the fire"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

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
