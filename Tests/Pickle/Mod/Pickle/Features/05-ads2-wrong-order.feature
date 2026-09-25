# Pass 5: A Dog Said 2 loaded BEFORE this mod, the order the mod's metadata forbids. English only.
#
# D. The negative control, and the scenario that justifies <loadBefore>. Without it the mod would
# look correct for a reason that is not the declared one. A Dog Said 2's own last patch,
# z_Category_Patches.xml, copies the three categories' recipeUsers onto the real surgery recipes,
# taking each list as it stands at that moment. This mod's addition, made afterwards, goes into a
# list nothing reads any more, and nothing is logged.
#
# Not compared with a plain animal: every vanilla animal sits in at least one of A Dog Said 2's categories,
# the rat in the first (dentures and wooden limbs), so the rat is not a base list. The first run of this pass
# (2026-09-25) failed on exactly that reading. The dalmatian must offer fewer than the rat and none of what
# only the husky offers.
#
# The symptom is asserted as a green result, not awaited as a red one. If these steps fail, the
# mechanism ATTRIBUTION.md and README.md describe is not what the game does, and the documents
# need correcting.
#
# This is the one pass that steps outside the supported configuration on purpose. It only says what
# happens there; it does not make that configuration supported.

@requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: The dalmatian beside A Dog Said 2, in the wrong load order

  Scenario: A Dog Said 2 really is loaded first
    Then mod "SamBucher.ADogSaidAnimalProsthetics2" loads before "nelim.dalmatiansrenew"
    And mod "Mlie.WhaleysDogs" is not loaded

  Scenario: the husky keeps its operations and the dalmatian loses them
    Then Dalmatians Renew "Husky" offers more operations than "Rat"
    And Dalmatians Renew "CCPDalmatian" offers fewer operations than "Husky"
    And Dalmatians Renew "CCPDalmatian" offers fewer operations than "Rat"
    And Dalmatians Renew "CCPDalmatian" offers none of the operations that "Husky" offers and "Rat" does not
