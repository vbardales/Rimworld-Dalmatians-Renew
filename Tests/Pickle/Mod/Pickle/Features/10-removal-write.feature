# Launch 1 of the removal chain (pass wsl-deps.removal.map): an adult and a puppy dalmatian and a stack of
# dalmatian leather in the colony, saved, and the saved game handed to the removal companion.
# Launch 2 is ../../../Removal/Mod/Pickle/Features/removal-check.feature, run with this mod and its test
# companion taken out of the list. No job is running when the game is saved: a save taken while a pawn runs
# a mod's JobDriver crashes every tick once the mod is gone (AnimaSong, 06-removal-write).

@requires:nelim.dalmatians.pickleremoval
Feature: Dalmatians Renew, a save with the mod, handed over for removal

  Scenario: save with a dalmatian, its puppy and its leather, and hand over
    Given the save "test-colony" is loaded
    And game speed is paused
    And Dalmatians Renew spawns the player animal "adult" as "CCPDalmatian"
    And Dalmatians Renew spawns the player puppy "puppy" as "CCPDalmatian"
    And 20 "Leather_Dalmatian" is spawned at the stockpile
    Then the stockpile holds 20 "Leather_Dalmatian"
    When Dalmatians Renew saves the game as "dalmatians-removal-with-mod"
    And Dalmatians Renew hands the saved game "dalmatians-removal-with-mod" to the mod "nelim.dalmatians.pickleremoval"
    Then no errors were logged
