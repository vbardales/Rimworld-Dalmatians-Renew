# Pass 6: cucumpear's original Dalmatians (cucumpear.dalmatians) loaded before this mod. English only.
#
# The mod declares the original in <incompatibleWith>: both define CCPDalmatian and
# Leather_Dalmatian. A declaration is a claim and it ages, so this pass goes and looks. The symptom
# documented in TESTING.md scenario J is that the definition loaded last wins, in silence.
#
# The symptom is asserted as a green result. A red means the other mod changed, or the game did:
# corrected, worsened or moved all read the same way, and the documents need a look.

@requires:cucumpear.dalmatians
Feature: The dalmatian beside the original mod it replaces

  Scenario: both mods are loaded and the original first
    Then mod "cucumpear.dalmatians" is loaded
    And mod "cucumpear.dalmatians" loads before "nelim.dalmatiansrenew"

  Scenario: the definition loaded last wins
    Then Dalmatians Renew the thing "CCPDalmatian" comes from the mod "nelim.dalmatiansrenew"
    And Dalmatians Renew the pawn kind "CCPDalmatian" comes from the mod "nelim.dalmatiansrenew"
    And def "Leather_Dalmatian" is defined by mod "nelim.dalmatiansrenew"
