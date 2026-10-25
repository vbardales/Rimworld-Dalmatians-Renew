# Images for the Workshop page: one day with the dalmatians, told in four staged photographs and one species card, on the Sanctuary
# of Nelim (the fixture "Nelims-tribe" of Sanctuary Backlot; Nelim is Virginie, the one colonist). Owner rules of 2026-10-06 to
# 2026-10-25 (GALLERY.md, "Shotlist : critères d'une scène à 4/5"): the session is the director, one scenario is one picture, and each
# picture is opened and judged before it reaches the owner. The card (last scenario) is an interface window taken on the bamboo
# backdrop: it is not scored and takes no subtitle; the four photographs are scored a to k in STATUS.md, "Gallery shotlist v2".
#
# THE STORY. WHO: Nelim (Virginie) and her two new dalmatians, Rex the adult and Pup the puppy. WHERE: the Sanctuary, flower garden,
# water garden, salon. WHEN: the day they arrive, 08:00, 09:00, 15:00, 19:00, clear weather, the game paused at each shot.
# (1) arrival, they walk into the garden; (2) breakfast; (3) a swim and a towel; (4) dusk, settled by the fire. Nelim keeps the teal
# shirt, brown trousers and Ponytails in 1 to 3; she changes for the evening in 4 because Pup soaked her in 3 (indigo shirt, cream
# trousers, FancyBun). Clothes and expressions are suggestions (owner, 2026-10-25): default expression smiling. No apparel on the
# animals (collar probe ebfe failed, 2026-10-25): the dalmatians stay vanilla.
#
# GESTURE RECIPE (NPT ticket 531b, proven 2026-10-25, fix 6c8ba9d): force the walk or the haul, then
# `I advance the paused game by exactly N ticks` (20 ticks is about one cell), then frame and shoot. The pawns are caught in stride.
# The ticks (20) and the path cells are first guesses: judge each capture and adjust. A cell that is not standable fails the spawn
# step by name. The studio presentation mode and the ended eclipse come from the proven recipe; if one of them hides or changes
# what the capture chain below expects, say so to NPT.
#
#   - Staged only by wsl-deps.sanctuary.map. Every other pass skips this feature. Run it in English.
#   - Photographs show the map alone (the game's own screenshot mode): the mod adds an animal, not an interface.
#   - What a capture shows that comes from the scene or the shared tools (a pile counter, a name left on screen, a zone painted on
#     the floor) is not worked around here: it goes to NPT with the capture, and the picture is not kept.
#   - The runner starts the game with developer mode on: it is turned off before each capture.
@requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @review
Feature: images for the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: the arrival, Nelim walks the new dalmatians into the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 8
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (154, 103)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (157, 102) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (151, 103) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 107) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (151, 106)
    And Nelim's Pickle Tools: "Rex" is forced to walk to (154, 106)
    And Nelim's Pickle Tools: "Pup" is forced to walk to (157, 105)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (154, 104) at zoom 4
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, the dalmatians arrive in the flower garden"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the feed, Nelim brings kibble to Rex in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 9
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (157, 105)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (158, 103) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (150, 105) facing East
    And Nelim's Pickle Tools: the animal "Pup" stands at (158, 103) facing West
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 107) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 5 of the item "Kibble" to (153, 105)
    And Nelim's Pickle Tools: "Rex" is forced to walk to (154, 105)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (154, 104) at zoom 3.2
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings kibble to Rex"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the towel, Nelim brings a cloth to Pup by the pond
    Given I set the weather to "Clear"
    And I set the hour to 15
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (152, 172)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (155, 170) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (148, 171) facing East
    And Nelim's Pickle Tools: the animal "Rex" stands at (152, 172) facing West
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 1 of the item "Cloth" to (150, 171)
    And Nelim's Pickle Tools: "Pup" is forced to walk to (153, 171)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (151, 171) at zoom 2.8
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings a towel to Pup by the pond"
    And Nelim's Pickle Tools: the interface is shown again

  Scenario: the fire, Nelim brings a log to the fire while the dalmatians settle in the salon
    Given I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "sofa-corner"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (188, 120)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (189, 122) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "FancyBun"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (60, 70, 140)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (225, 215, 190)
    And Nelim's Pickle Tools: "Nelim" stands at (184, 121) facing East
    And Nelim's Pickle Tools: the animal "Rex" stands at (188, 120) facing West
    And Nelim's Pickle Tools: the animal "Pup" stands at (189, 122) facing West
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "Campfire" at (190, 120)
    And Nelim's Pickle Tools: the decor "Campfire" at (190, 120) is lit
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 1 of the item "WoodLog" to (189, 120)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (187, 121) at zoom 2
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings a log to the fire, the dalmatians settled"
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
