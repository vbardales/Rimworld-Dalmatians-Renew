Feature: temporary diagnostic of the flower garden cells (deleted after reading)

  Scenario: flower garden bare, two frames
    Given I set the weather to "Clear"
    And I set the hour to 8
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Pickle Tools: the other colonists are out of frame
    When Nelim's Pickle Tools: I frame the cell (154, 100) at zoom 6
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "diag flower garden south"
    And Nelim's Pickle Tools: the interface is shown again
    When Nelim's Pickle Tools: I frame the cell (154, 108) at zoom 6
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "diag flower garden north"
    And Nelim's Pickle Tools: the interface is shown again
