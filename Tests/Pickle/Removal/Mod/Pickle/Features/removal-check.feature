Feature: A game saved with Dalmatians Renew, loaded without it

  # Scenario K of TESTING.md. The README promises: "removing it mid-save destroys any dalmatian already
  # in the colony". What the mod answers for is what comes after RimWorld's missing-def handling: the colony
  # runs and the log does not fill with errors about the vanished animal and leather. That the animal is
  # dropped is the game's own handling of a changed mod list, so it is not asserted.
  # Launch 2 of a chain (see ../../README.md): the mod and its test companion are taken out of the list.

  Scenario: the save loads and runs without the mod
    Given mod "nelim.dalmatians" is not loaded
    And the save "dalmatians-removal-with-mod" is loaded
    And game speed is fast
    When I wait 250 ticks
    Then no errors were logged
    And the engine is alive
    When I save and reload as "dalmatians-removal-without-mod"
    Then no errors were logged
    And the engine is alive
