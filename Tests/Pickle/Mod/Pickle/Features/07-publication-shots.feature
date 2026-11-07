# Images for the Workshop page: one day with the dalmatians, told in four staged photographs and one species card, on the Sanctuary
# of Nelim (the fixture "Nelims-tribe" of Sanctuary Backlot; Nelim is Virginie, the one colonist). Owner rules of 2026-10-06 to
# 2026-11-08 (GALLERY.md, "Shotlist : critères d'une scène à 4/5"): the session is the director, one scenario is one picture, and each
# picture is opened and judged before it reaches the owner. The card (last scenario) is an interface window taken on the bamboo
# backdrop: it is not scored and takes no subtitle; the four photographs are scored a to k in STATUS.md, "Gallery shotlist v3".
#
# THE STORY. WHO: Nelim (Virginie) and her two new dalmatians, Rex the adult and Pup the puppy. WHERE: the Sanctuary, flower garden,
# water garden, salon. WHEN: the day they arrive, 8h, 9h, 15h, 19h, clear weather, the game paused at each shot.
# (1) arrival, she brings them to their new bed; (2) breakfast; (3) Pup out of the pond and a towel; (4) dusk, all three by the fire
# (shotlist v3, STATUS.md, 2026-11-08). Nelim keeps the teal shirt, brown trousers and Ponytails all day (continuity). Clothes and
# expressions are suggestions (owner, 2026-10-25): default expression smiling. No apparel on the animals (collar probe ebfe failed,
# 2026-10-25): the dalmatians stay vanilla. The dog bed is More animal beds (Animal.BedsNew, 3107972819), in the DepMap of this pass.
#
# THE SHOTLIST (one line per photograph, checked against the scenarios by scripts/Check-ShotlistVsScenario.ps1):
#
#   1. arrival: flower-garden path at 8h, clear, +40 ticks. The dirt path along the south edge, a new dog bed at its end.
#         Decor: TorchLamp lit (152, 101), the bed GSAnimalBedBig (154, 99) with Hay on it, Plant_Daylily fully grown at (150, 100),
#         (153, 98) and (157, 100), Plant_YellowTallGrass at (150, 102), (157, 102), (158, 100) and (149, 101), flower beds behind.
#         Nelim Apparel_CollarShirt rgb (22, 110, 115), Apparel_Pants rgb (74, 58, 50), Ponytails, MouthSmile, LidCheerful.
#         Action: Nelim hauls Hay to (153, 101) toward the bed, Rex at her heel walks to (154, 101) facing the camera, Pup on the diagonal
#         walks to (155, 102). The instant: they have just stepped onto the path, the bed waits. Zoom 3.2 on (154, 102).
#         Says: Nelim brings the dalmatians to their new bed. THUMBNAIL: Rex about 12 percent of the height.
#   2. breakfast: the same path at 9h, clear. The same lamp (152, 101), bed (154, 99) in the foreground (lower z), the same Plant_Daylily
#         and Plant_YellowTallGrass, a Kibble stack. Nelim in the same outfit Apparel_CollarShirt rgb (22, 110, 115), Apparel_Pants
#         rgb (74, 58, 50), smile. Action: Nelim walks south from (156, 103) hauling Kibble to (155, 101), just before the drop; Rex
#         walks from (154, 104) to (154, 101) toward her, facing the camera; Pup stands at (153, 101) nose to the kibble.
#         Zoom 2.2 on (154, 101). Says: breakfast for the dalmatians. THUMBNAIL: Rex about 20 percent of the height.
#   3. towel: water-garden west bank at 15h, clear. Willows, reeds, lily pads, the pond's ducks (not removed), Plant_Daylily at (146, 171)
#         and (147, 169), Plant_YellowTallGrass at (146, 173), (148, 170) and (150, 168) so the bank is not bare, a Cloth in Nelim's hands.
#         Nelim same outfit Apparel_CollarShirt rgb (22, 110, 115), Apparel_Pants rgb (74, 58, 50), smile. Action: Nelim walks south
#         from (151, 173) hauling Cloth to (151, 171); Pup walks out of the shallows from (154, 170) to (152, 170). The instant: Pup has just
#         stepped out of the pond, the towel is about to reach him. Zoom 2.8 on (151, 171).
#         Says: Pup out of the water, Nelim brings the towel. THUMBNAIL: Pup about 20 percent of the height.
#   4. fire: sofa corner of the salon at 19h, clear. Campfire at (190, 120) lit, TorchLamp lit at (189, 123), the bed GSAnimalBedBig
#         near (187, 120) by the fire, the couches. Nelim same outfit Apparel_CollarShirt rgb (22, 110, 115), Apparel_Pants rgb (74, 58, 50),
#         Ponytails, a small calm smile MouthLipsSmallSmile, LidNormal. Action: Nelim walks south from (190, 123) hauling a WoodLog to
#         (190, 121), just before it drops on the embers; Rex stands at (188, 121) facing South toward the camera, Pup stands on the
#         bed at (187, 120). Zoom 2 on (188, 121), warm low light. Says: all three at the fire, the bed is theirs now.
#         THUMBNAIL: Rex and Pup large.
#
# GESTURE RECIPE (NPT ticket 531b, proven 2026-10-25, fix 6c8ba9d): force the walk or the haul, then
# `I advance the paused game by exactly N ticks` (20 ticks is about one cell), then frame and shoot. The pawns are caught in stride.
# North is a HIGHER z: a walk toward the camera ends on a LOWER z (capture db7c walked away by mistake). Nelim's face steps come
# last, after the ticks (the face of db7c frowned with them first). The ticks and the cells are first guesses: judge each capture and
# adjust. A cell that is not standable fails the spawn step by name.
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

  Scenario: the arrival, Nelim brings the new dalmatians to their bed in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 8
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (154, 105)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (155, 106) at life stage 0
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (153, 104) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "GSAnimalBedBig" near (154, 99)
    And Nelim's Pickle Tools: I place the decor "Hay" at (154, 99)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (152, 101)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (152, 101) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (153, 98) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 102) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (157, 102) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (158, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (149, 101) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 3 of the item "Hay" to (153, 101)
    And Nelim's Pickle Tools: "Rex" is forced to walk to (154, 101)
    And Nelim's Pickle Tools: "Pup" is forced to walk to (155, 102)
    When Nelim's Pickle Tools: I advance the paused game by exactly 40 ticks
    And Nelim's Pickle Tools: I frame the cell (154, 102) at zoom 3.2
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings the dalmatians to their new bed"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the feed, Nelim brings kibble to Rex in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 9
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (154, 104)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (153, 101) at life stage 0
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (156, 103) facing South
    And Nelim's Pickle Tools: the animal "Pup" stands at (153, 101) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "GSAnimalBedBig" near (154, 99)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (152, 101)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (152, 101) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (153, 98) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 102) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (157, 102) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (158, 100) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (149, 101) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 5 of the item "Kibble" to (155, 101)
    And Nelim's Pickle Tools: "Rex" is forced to walk to (154, 101)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (154, 101) at zoom 2.2
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
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
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (154, 170) at life stage 0
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (151, 173) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (146, 171) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (147, 169) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (146, 173) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (148, 170) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 168) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 1 of the item "Cloth" to (151, 171)
    And Nelim's Pickle Tools: "Pup" is forced to walk to (152, 170)
    When Nelim's Pickle Tools: I advance the paused game by exactly 30 ticks
    And Nelim's Pickle Tools: I frame the cell (151, 171) at zoom 2.8
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings a towel to Pup by the pond"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the fire, Nelim brings a log to the fire while the dalmatians settle in the salon
    Given I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "sofa-corner"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (188, 121)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (187, 120) at life stage 0
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (190, 123) facing South
    And Nelim's Pickle Tools: the animal "Rex" stands at (188, 121) facing South
    And Nelim's Pickle Tools: the animal "Pup" stands at (187, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I place the decor "GSAnimalBedBig" near (187, 120)
    And Nelim's Pickle Tools: I place the decor "Campfire" at (190, 120)
    And Nelim's Pickle Tools: the decor "Campfire" at (190, 120) is lit
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (189, 123)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (189, 123) is lit
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: "Nelim" is forced to haul 1 of the item "WoodLog" to (190, 121)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (188, 121) at zoom 2
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim brings a log to the fire, the dalmatians settled"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the information card window of the dalmatian, with Wildness at zero
    Given Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian" near the cell 154 105
    When Nelim's Sanctuary: I frame the sanctuary "window-backdrop-for-height"
    And Dalmatians Renew opens the information card of "Rex"
    Then Dalmatians Renew the information card of "Rex" lists the stat "Wildness" at "0%"
    When Dalmatians Renew filters the open information card to "wildness"
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    Then I take a screenshot "Workshop page, the information card"
    And Nelim's Pickle Tools: screenshot mode is disabled
