@requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.colonistrace
Feature: temporary diagnostic of the three gallery places on z3 (deleted after reading)

  Scenario: diag flower garden z3
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 8
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    Then I take a screenshot "diag flower garden"

  Scenario: diag water garden z3
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 15
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    Then I take a screenshot "diag water garden"

  Scenario: diag sofa corner z3
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 19
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sofa-corner"
    Then I take a screenshot "diag sofa corner"
