# Pass 3: A Dog Said... Animal Prosthetics 2 loaded AFTER this mod, no WhaleysDogs. English only.
#
# C. The second repair, and the reason the patch was rewritten. The assertion is not "the dalmatian
# has some operations" but "it has the same ones vanilla's husky has": both sit in all three of
# A Dog Said 2's categories, so any difference is a fault. The husky and the rat are the controls:
# the husky must offer more than a plain animal, or the comparison proves nothing.
#
# The effect lives in a list another mod builds while the game loads, and the failure is silent:
# no error, no warning, only operations that are not there.

@requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: The dalmatian beside A Dog Said 2, in the declared load order

  Scenario: the load order is the one the mod declares, and WhaleysDogs is absent
    Then mod "SamBucher.ADogSaidAnimalProsthetics2" is loaded
    And mod "nelim.dalmatiansrenew" loads before "SamBucher.ADogSaidAnimalProsthetics2"
    And mod "Mlie.WhaleysDogs" is not loaded

  Scenario: the dalmatian is offered the same operations as the husky
    Then Dalmatians Renew "Husky" offers more operations than "Rat"
    And Dalmatians Renew "CCPDalmatian" offers more operations than "Rat"
    And Dalmatians Renew "CCPDalmatian" offers the same operations as "Husky"

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.dalmatiansrenew"
