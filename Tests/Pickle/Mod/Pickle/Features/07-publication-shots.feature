# Images for the Workshop page: one day with the dalmatians, told in three staged photographs and one species card, on the Sanctuary
# of Nelim (the fixture "Nelims-tribe" of Sanctuary Backlot; Nelim is Virginie, the one colonist). Owner rules of 2026-10-06 to
# 2026-10-18 (GALLERY.md, "Shotlist : critères d'une scène à 4/5"): the session is the director, one scenario is one picture, and each
# picture is opened and judged before it reaches the owner. The card (scenario 4) is an interface window taken on the bamboo backdrop:
# it is not scored and takes no subtitle; the three photographs are scored a to j below.
#
# THE STORY. WHO: Nelim (Virginie) and her two new dalmatians, Rex the adult and Pup the puppy, who have just come to live with her.
# WHERE: the Sanctuary, from the flower garden to the pond to the salon. WHEN: one day, the day they arrive, with the rhythm 09:00,
# 15:00, 19:00 (six hours, then four; the game is paused at each shot, the hour is set), clear weather. EPISODES, each one moving on:
# (1) morning, the newcomers are fed and she welcomes them; (2) afternoon, trust is made over a swim and a towel; (3) dusk, they have
# settled in and follow her by the fire. Nelim changes clothes and hair between episodes, because the hours do.
#
# SHOT PLAN (a: place, hour, time that passes; b: decor placed then removed; c: living things; d: Nelim; e: action; f: composition;
# g: what it says; h: risk and plan; j: what the mod brings)
#
#   1. THE FEED. a: flower-garden, 09:00, clear; the game is paused, so 09:00 is the whole of the time that passes in this picture
#      (the next one is 15:00, the third 19:00). b: two daylilies grown to full size placed in the foreground at (150, 104) and
#      (157, 107), removed after the shot. c: the adult and the puppy facing the camera, the puppy with a log in its mouth, the
#      garden's own flowers. d: teal collar shirt (22, 110, 115) and dark brown trousers (74, 58, 50), hairstyle Ponytails (the Female
#      one), mouth MouthSmile and cheerful lids. e: Nelim carries a bowl of kibble to them, turned toward the dogs and not the lens.
#      f: frame the cell (154, 104) at zoom 4 (the dogs stand on x 151-157, z 103-105; the garden frame missed them), Nelim at the left edge, the adult centre-right and the puppy a little further and lower, so
#      the three are not in a row; daylilies in front, flowers behind; bright morning light. g: "Nelim has brought her dalmatians
#      home": an animal, its spotted coat and its two life stages. j: the dalmatian, adult and puppy. Steam shows this one large.
#      h: risk = the white dogs get lost among the flowers or the log does not read. Plan = read the capture; if the dogs sink, move
#      them to the bare path two cells south and bring the root size down to 3.2, never recolour the dogs.
#
#   2. THE TOWEL. a: water-garden, 15:00, clear, six hours after picture 1. b: a stool placed at (146, 171) beside her, removed after
#      the shot. c: the dalmatians on the bank facing the camera, the pond's own ducks, lily pads and reeds behind them. d: terracotta
#      shirt (200, 90, 60), slate trousers (60, 60, 80), hairstyle Pigtails, mouth MouthLipsSmallSmile and cheerful lids. e: Nelim carries
#      a towel (cloth) to dry them after the swim, looking at the puppy. f: frame (145, 168) to (158, 176) filling 85 percent of the
#      screen; Nelim at the left, the puppy near the water's edge in the background, the adult nearer the camera and off-axis; water
#      and reeds as background; afternoon light. g: "after the swim": the dalmatian is a water-loving household dog. j: the dalmatian.
#      h: risk = the cell (149, 173) is a burrow-looking hole and the bank cells may be water. Plan = the spawn and stand steps fail on
#      a non-standable cell, so a bad cell stops the run with its name; cells chosen on the bank strip x 143-158, z 168-176, away from 149, 173.
#
#   3. THE FIRE. a: sofa-corner of the salon, 19:00, clear, four hours after picture 2. b: a campfire placed at (190, 120) and lit,
#      removed after the shot, beside the room's own torch lamp and couches. c: the two dogs facing the camera, the room's potted
#      plants. d: indigo shirt (60, 70, 140), cream trousers (225, 215, 190), hairstyle FancyBun, mouth MouthLipsSmallSmile and normal lids
#      (a calm face). e: Nelim carries a log to the fire. f: frame (183, 118) to (193, 123) filling 85 percent of the screen, south of the
#      couches so nothing hides the dogs; the fire right, Nelim left, the adult low centre and the puppy nearer the flame; warm low
#      light at dusk. g: "they followed her indoors": a household companion, not a wild animal. j: the dalmatian.
#      h: risk = the cells (185, 121), (188, 120), (189, 121), (190, 120) come from a 2026-10-06 cell list and were never seen on a photo,
#      and dusk may be too dark. Plan = non-standable cell fails the run by name; if the salon is too dark, light the room's torch lamp too
#      with the lit step, never remove the roof.
#
#   4. THE CARD (interface, not scored). The species window on the bamboo backdrop `window-backdrop-for-height`: Wildness 0 % and the
#      source line, cropped sideways by hand afterwards (5 px of backdrop each side of the window, full height), as GALLERY.md asks.
#
#   Between the shots: hair and clothes change on purpose with the hour; the dogs are the same two (Rex, Pup); the puppy is not asleep
#   (no step exists for it). The dogs are placed on exact cells with the NPT spawn steps: a cell that is not standable fails the step.
#   Collar from Animal Apparel Collars and Kit: pending the probe ticket (08-collar-probe). If it passes, the dogs wear it in 1 to 3.
#
#   - Staged only by wsl-deps.sanctuary.map. Every other pass skips this feature. Run it in English.
#   - Pictures 1 to 3 show the map alone (the game's own screenshot mode): the mod adds an animal, not an interface.
#   - What a capture shows that comes from the scene or the shared tools (a pile counter, a name left on screen, a zone painted on
#     the floor) is not worked around here: it goes to NPT with the capture, and the picture is not kept.
#   - The runner starts the game with developer mode on: it is turned off before each capture.
@requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @review
Feature: images for the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: the feed, Nelim brings kibble to her dalmatians in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 9
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (154, 105)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (157, 103) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt" dyed rgb (22, 110, 115)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (74, 58, 50)
    And Nelim's Pickle Tools: "Nelim" stands at (151, 105) facing East
    And Nelim's Pickle Tools: "Nelim" carries the item "Kibble"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Rex" stands at (154, 105) facing South
    And Nelim's Pickle Tools: the animal "Pup" stands at (157, 103) facing South
    And Nelim's Pickle Tools: "Pup" carries the item "WoodLog"
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (150, 104) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 107) fully grown
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Pickle Tools: I frame the cell (154, 104) at zoom 4
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim feeds her dalmatians in the flower garden"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the towel, Nelim dries her dalmatians by the pond
    Given I set the weather to "Clear"
    And I set the hour to 15
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (152, 172)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (155, 170) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Pigtails"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (200, 90, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (60, 60, 80)
    And Nelim's Pickle Tools: "Nelim" stands at (148, 171) facing East
    And Nelim's Pickle Tools: "Nelim" carries the item "Cloth"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Rex" stands at (152, 172) facing South
    And Nelim's Pickle Tools: the animal "Pup" stands at (155, 170) facing South
    And Nelim's Pickle Tools: I place the decor "Stool" at (146, 171)
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Pickle Tools: I frame the cells (145, 168) to (158, 176) filling 85 percent of the screen
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Workshop page, Nelim dries her dalmatians by the pond"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: the decor is removed

  Scenario: the fire, the dalmatians settle by the fire in the salon
    Given I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Sanctuary: the animals are removed from the sanctuary "sofa-corner"
    And Nelim's Pickle Tools: an adult animal of kind "CCPDalmatian" named "Rex" is spawned at (188, 120)
    And Nelim's Pickle Tools: an animal of kind "CCPDalmatian" named "Pup" is spawned at (189, 121) at life stage 0
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "FancyBun"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (60, 70, 140)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (225, 215, 190)
    And Nelim's Pickle Tools: "Nelim" stands at (185, 121) facing East
    And Nelim's Pickle Tools: "Nelim" carries the item "WoodLog"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Rex" stands at (188, 120) facing South
    And Nelim's Pickle Tools: the animal "Pup" stands at (189, 121) facing South
    And Nelim's Pickle Tools: I place the decor "Campfire" at (190, 120)
    And Nelim's Pickle Tools: the decor "Campfire" at (190, 120) is lit
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Pickle Tools: I frame the cells (183, 118) to (193, 123) filling 85 percent of the screen
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
