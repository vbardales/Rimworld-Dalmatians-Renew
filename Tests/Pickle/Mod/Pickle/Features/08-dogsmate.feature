# Pass 7 (alone) and pass 9 (with Better Crossbreeding): Dogs mate (Continued) beside this mod. English only.
#
# Mod/Patches/Compat_DogsMate.xml appends CCPDalmatian to Dogs mate's group "Dog", which holds Husky,
# LabradorRetriever and YorkshireTerrier. Dogs mate then fills race.canCrossBreedWith of every race of the
# group at startup. The game reads that list on the MALE only, so both directions are asserted.
# The wolf and the red fox are the controls: they sit in other groups, and a pass where the dalmatian
# seeks them means the patch put it in the wrong group.
#
# The effect lives in a list another mod builds while the game loads, and the failure is silent: no
# error, no warning, a dog that simply never courts the husky.

@requires:Mlie.DogsMate
Feature: The dalmatian beside Dogs mate (Continued)

  Scenario: the dalmatian courts the vanilla dogs and they court it
    Then mod "Mlie.DogsMate" is loaded
    And Dalmatians Renew the male "CCPDalmatian" will seek "Husky" to mate with
    And Dalmatians Renew the male "CCPDalmatian" will seek "LabradorRetriever" to mate with
    And Dalmatians Renew the male "CCPDalmatian" will seek "YorkshireTerrier" to mate with
    And Dalmatians Renew the male "Husky" will seek "CCPDalmatian" to mate with
    And Dalmatians Renew the male "LabradorRetriever" will seek "CCPDalmatian" to mate with
    And Dalmatians Renew the male "YorkshireTerrier" will seek "CCPDalmatian" to mate with

  Scenario: the dalmatian is not put among wolves or foxes
    Then Dalmatians Renew the male "CCPDalmatian" does not seek "Wolf_Timber" to mate with
    And Dalmatians Renew the male "CCPDalmatian" does not seek "Fox_Red" to mate with
    And Dalmatians Renew the male "Wolf_Timber" does not seek "CCPDalmatian" to mate with

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.dalmatians"
