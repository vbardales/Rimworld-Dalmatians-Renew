# Pass 4: every optional mod at once, in the order the mod declares: WhaleysDogs, this mod, then
# A Dog Said 2. English only. WhaleysDogs and A Dog Said 2 are not exclusive, so one combined pass
# covers "with the optional mods"; passes 2 and 3 cover each of them alone.
#
# O. With A Dog Said 2 enabled, both saved races must offer the husky's surgery list.

@requires:Mlie.WhaleysDogs @requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: The dalmatian beside WhaleysDogs and A Dog Said 2

  Scenario: the load order is WhaleysDogs, this mod, then A Dog Said 2
    Then mod "Mlie.WhaleysDogs" loads before "nelim.dalmatiansrenew"
    And mod "nelim.dalmatiansrenew" loads before "SamBucher.ADogSaidAnimalProsthetics2"

  Scenario: both races are offered the same operations as the husky
    Then Dalmatians Renew "Husky" offers more operations than "Rat"
    And Dalmatians Renew "WD_Dalmatian" offers the same operations as "Husky"
    And Dalmatians Renew "CCPDalmatian" offers the same operations as "Husky"

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.dalmatiansrenew"
