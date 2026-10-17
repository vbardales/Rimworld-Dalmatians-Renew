# Probe, 2026-10-18: can a dalmatian wear a collar of Animal Apparel: Collars and Kit Renew, and does it read on a white coat?
# Only if it can does the Workshop gallery use it (07-publication-shots stays vanilla until then). Not part of the mod's test suite:
# it asks for another mod, so every other pass skips it. Run it in English, on wsl-deps.sanctuary-collar.map.
# The collar is the other mod's: a picture that shows it says so in its subtitle (GALLERY.md, "Mods tiers").
@requires:nelim.animalapparelcollarsandkit @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @review
Feature: a dalmatian in a collar, probe for the Workshop gallery

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: the dalmatian wears a red leather collar in the flower garden
    Given I set the weather to "Clear"
    And I set the hour to 10
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Animal Apparel Collars: a tame "CCPDalmatian" named "Rex" stands at (154, 105)
    And Nelim's Pickle Tools: "Rex" faces South
    And Animal Apparel Collars: "Rex" is dressed in "Apparel_leatherdogcollar" dyed "#c8202a"
    Then Animal Apparel Collars: the render tree of "Rex" draws "Apparel_leatherdogcollar"
    When Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And Nelim's Pickle Tools: the camera root size is set to 2.5
    And Nelim's Pickle Tools: I move the mouse to (960, 1000)
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Nelim's Pickle Tools: the map is shown alone for a capture
    Then I take a screenshot "Collar probe, the dalmatian in a red leather collar"
    And Nelim's Pickle Tools: the interface is shown again
    And no errors were logged
