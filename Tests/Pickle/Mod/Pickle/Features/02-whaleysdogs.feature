# Pass 2: WhaleysDogs (Mlie.WhaleysDogs) loaded before this mod, no A Dog Said 2. Run once in English
# and once in French. WD_Dalmatian is the canonical breed here; CCPDalmatian stays for saves.
#
# Offline, _tools/WhaleysDogs.Tests.ps1 runs the real Verse patch operations on the installed
# WhaleysDogs data and proves that its balance is unchanged and that saved identities survive.
# These scenarios read what the game kept after loading the whole mod list.

@requires:Mlie.WhaleysDogs
Feature: The dalmatian beside WhaleysDogs

  Scenario: the integration loads after WhaleysDogs and patches its dalmatian
    Then mod "Mlie.WhaleysDogs" is loaded
    And mod "Mlie.WhaleysDogs" loads before "nelim.dalmatiansrenew"
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded
    And Dalmatians Renew the race of "WD_Dalmatian" reads "leatherDef" as "Leather_Dalmatian"
    And Dalmatians Renew the race of "WD_Dalmatian" reads "animalType" as "Canine"

  # N. Native per-pawn coats: roughly half each, not an exact quota. The coat is a function of the
  #    animal's thingIDNumber, so forty animals all sharing one coat would be a fault of the patch.
  Scenario: both coats are drawn among forty wild dalmatians
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns 40 wild animals as "WD_Dalmatian"
    Then Dalmatians Renew both coats are drawn, each by at least 25 percent of the spawned batch
    And no errors were logged

  # N. Each pawn keeps its coat through a save and reload. P. A dog saved as CCPDalmatian is still
  #    there, still the player's, after the reload, with WhaleysDogs loaded beside it.
  Scenario: coats and a legacy dog survive a save and reload
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player animal "Current" as "WD_Dalmatian"
    And Dalmatians Renew spawns the player animal "Legacy" as "CCPDalmatian"
    When Dalmatians Renew records the coat of "Current"
    And Dalmatians Renew records the coat of "Legacy"
    And I save and reload
    Then Dalmatians Renew the coat of "Current" is the one recorded
    And Dalmatians Renew the coat of "Legacy" is the one recorded
    And Dalmatians Renew "Legacy" belongs to the player
    And no errors were logged
    And no warnings from mod "nelim.dalmatiansrenew"

  # N. Only WD_Dalmatian is newly offered by traders. P. An old dog can still be sold to them.
  Scenario: traders stock only the canonical breed and the legacy breed stays sellable
    Then Dalmatians Renew some trader kind stocks "WD_Dalmatian"
    And Dalmatians Renew no trader kind stocks "CCPDalmatian"
    And Dalmatians Renew the player can sell "CCPDalmatian"
    And Dalmatians Renew the player can sell "WD_Dalmatian"

  # O. The leather of the canonical breed becomes ours.
  Scenario: butchering the canonical dalmatian yields Dalmatian leather
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the wild animal "Rex" as "WD_Dalmatian"
    When Dalmatians Renew butchers "Rex"
    Then Dalmatians Renew the butchering produced "Leather_Dalmatian"

  # O. Without A Dog Said 2: no patch error and no added surgery.
  Scenario: without A Dog Said 2 neither breed is offered more than a vanilla animal
    Then Dalmatians Renew "WD_Dalmatian" offers the same operations as "Rat"
    And Dalmatians Renew "CCPDalmatian" offers the same operations as "Rat"

  # N. Both coats of the canonical breed, at every stage of decay. The corpse fallback belongs to
  #    WhaleysDogs and is complete; a person checks that our alternate coat did not break it.
  @review
  Scenario Outline: the <coat> coat draws a <rot> corpse
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player animal "Rex" as "WD_Dalmatian" wearing the <coat> coat
    When Dalmatians Renew kills "Rex" and lets the corpse reach <rot> rot
    And Dalmatians Renew centres the camera on "Rex"
    Then I take a screenshot "whaleysdogs <coat> coat, <rot> corpse"
    And no errors were logged

    Examples:
      | coat      | rot        |
      | original  | fresh      |
      | original  | rotting    |
      | original  | dessicated |
      | alternate | fresh      |
      | alternate | rotting    |
      | alternate | dessicated |

  @review
  Scenario Outline: the <coat> coat is drawn facing every way
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player animal "Rex" as "WD_Dalmatian" wearing the <coat> coat
    When Dalmatians Renew centres the camera on "Rex"
    And Dalmatians Renew shows "Rex" facing north
    Then I take a screenshot "whaleysdogs <coat> coat facing north"
    When Dalmatians Renew shows "Rex" facing east
    Then I take a screenshot "whaleysdogs <coat> coat facing east"
    When Dalmatians Renew shows "Rex" facing south
    Then I take a screenshot "whaleysdogs <coat> coat facing south"
    When Dalmatians Renew shows "Rex" facing west
    Then I take a screenshot "whaleysdogs <coat> coat facing west"
    And no errors were logged

    Examples:
      | coat      |
      | original  |
      | alternate |

  # M. The integration's own text, in the language of this pass. English is WhaleysDogs' source
  #    text, typos included: the puppy stage really is spelled "Young Dalmation" upstream.
  @english
  Scenario: the canonical dalmatian reads in English
    Then Dalmatians Renew this pass runs in English
    And Dalmatians Renew the pawn kind "WD_Dalmatian" is labelled "Dalmatian" and pluralised "Dalmatians"
    And Dalmatians Renew the first life stage of pawn kind "WD_Dalmatian" is labelled "Young Dalmation" and pluralised "Young Dalmatians"
    And Dalmatians Renew the thing "WD_Dalmatian" has the attack labels "left claw, right claw, head"

  @french
  Scenario: the canonical dalmatian reads in French
    Then Dalmatians Renew this pass runs in French
    And Dalmatians Renew the thing "WD_Dalmatian" is labelled "dalmatien"
    And Dalmatians Renew the thing "WD_Dalmatian" has a description beginning "Grand chien au pelage tacheté."
    And Dalmatians Renew the thing "WD_Dalmatian" has the attack labels "griffe gauche, griffe droite, tête"
    And Dalmatians Renew the pawn kind "WD_Dalmatian" is labelled "dalmatien" and pluralised "dalmatiens"
    And Dalmatians Renew the first life stage of pawn kind "WD_Dalmatian" is labelled "chiot dalmatien" and pluralised "chiots dalmatiens"
    And Dalmatians Renew the material "Leather_Dalmatian" is called "fourrure de dalmatien" when it names a garment
    And Dalmatians Renew the thing "CCPDalmatian" is labelled "dalmatien"
    And Dalmatians Renew the first life stage of pawn kind "CCPDalmatian" is labelled "chiot dalmatien" and pluralised "chiots dalmatiens"
