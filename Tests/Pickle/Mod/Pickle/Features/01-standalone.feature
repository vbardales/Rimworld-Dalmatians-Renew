# Pass 1: the mod and its hard dependencies, no optional mod. Run once in English and once in French
# (see Tests/Pickle/README.md for the exact commands). Scenarios tagged @english or @french are
# written against the language their pass was launched in; the language is never switched here.
#
# Only what a running game can show is kept in Gherkin. The XML, the field mapping, the patch
# structure and the shipped images are checked offline by _tools/Run-Tests.ps1.

Feature: The dalmatian on its own

  Scenario: the mod owns the animal and its leather, and the optional integrations are not loaded
    Then mod "nelim.dalmatiansrenew" is loaded
    And def "CCPDalmatian" is defined by mod "nelim.dalmatiansrenew"
    And def "Leather_Dalmatian" is defined by mod "nelim.dalmatiansrenew"
    And no def "WD_Dalmatian" exists
    And mod "Mlie.WhaleysDogs" is not loaded
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded

  # The values cucumpear and lavie2k set, read from the defs the game kept. The offline suite
  # checks that every element maps to a real 1.6 field; it does not check these values.
  Scenario: the race carries the source mod's values
    Then def "CCPDalmatian" field "race.trainability" is "Advanced"
    And def "CCPDalmatian" field "race.nameOnTameChance" is "1"
    And def "CCPDalmatian" field "race.nuzzleMtbHours" is "20"
    And def "CCPDalmatian" field "race.manhunterOnDamageChance" is "0"
    And def "CCPDalmatian" field "race.manhunterOnTameFailChance" is "0"
    And def "CCPDalmatian" field "race.gestationPeriodDays" is "25"
    And def "CCPDalmatian" field "race.lifeExpectancy" is "12"
    And def "CCPDalmatian" field "race.animalType" is "Canine"
    And def "CCPDalmatian" field "race.leatherDef" is "Leather_Dalmatian"
    And Dalmatians Renew the litter size curve of "CCPDalmatian" peaks at 2

  # A. The animal exists, spawns, and takes a name the moment it is tamed.
  # B. The first repair: Wildness is listed on the information card, at 0 percent. The old form of
  #    the def did not print a wrong number, it printed no line at all. The husky is the control.
  @review @requires:nelim.pickletools.screenshotmode
  Scenario: a tamed dalmatian is named on the spot and its information card lists Wildness at zero
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the wild animal "Rex" as "CCPDalmatian"
    And Dalmatians Renew spawns the wild animal "Control" as "Husky"
    Then Dalmatians Renew "Rex" has no name
    When Dalmatians Renew tames "Rex"
    Then Dalmatians Renew "Rex" belongs to the player
    And Dalmatians Renew "Rex" has a name
    And Dalmatians Renew the information card of "Control" lists the stat "Wildness" at "75%"
    When Dalmatians Renew opens the information card of "Rex"
    Then Dalmatians Renew the information card of "Rex" lists the stat "Wildness" at "0%"
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    Then I take a screenshot "dalmatian information card - Wildness listed at 0 percent"
    And no errors were logged
    And no warnings from mod "nelim.dalmatiansrenew"

  # E. A Dog Said 2 absent: the guarded patch says nothing and adds nothing. Whatever a vanilla
  #    animal is offered, and no more.
  Scenario: without A Dog Said 2 the dalmatian is offered what any vanilla animal is offered
    Then Dalmatians Renew "CCPDalmatian" offers the same operations as "Rat"

  # F. The leather.
  Scenario: butchering a dalmatian yields its own leather, colder than plain leather by two points
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the wild animal "Rex" as "CCPDalmatian"
    When Dalmatians Renew butchers "Rex"
    Then Dalmatians Renew the butchering produced "Leather_Dalmatian"
    And def "Leather_Dalmatian" stat "StuffPower_Insulation_Cold" is 14
    And def "Leather_Plain" stat "StuffPower_Insulation_Cold" is 16
    And no errors were logged

  # F. Almost white, distinctly paler than plain leather beside it. A person compares the two.
  @review
  Scenario: the leather is drawn paler than plain leather lying next to it
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew lays out "Leather_Dalmatian" beside "Leather_Plain"
    Then I take a screenshot "dalmatian leather beside plain leather"
    When Dalmatians Renew opens the information card of the first thing laid out
    Then I take a screenshot "dalmatian leather information card"
    And no errors were logged

  # H. Trade: the two trade tags, and sellable back to a trader.
  Scenario: traders stock the dalmatian and the player can sell it
    Then Dalmatians Renew some trader kind stocks "CCPDalmatian"
    And Dalmatians Renew the player can sell "CCPDalmatian"
    And def "CCPDalmatian" stat "MarketValue" is 250

  # I. The three rotations of the living animal, the puppy, and the dessicated corpse that ships
  #    its east texture only. West is not shipped: the game mirrors east. A person reads these.
  @review
  Scenario Outline: the adult is drawn facing <facing>
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian"
    When Dalmatians Renew centres the camera on "Rex"
    And Dalmatians Renew shows "Rex" facing <facing>
    Then I take a screenshot "dalmatian facing <facing>"
    And no errors were logged

    Examples:
      | facing |
      | north  |
      | east   |
      | south  |
      | west   |

  @review
  Scenario: the puppy is drawn from the same texture at a smaller size
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player puppy "Pup" as "CCPDalmatian"
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian"
    When Dalmatians Renew centres the camera on "Pup"
    And Dalmatians Renew shows "Pup" facing south
    And Dalmatians Renew shows "Rex" facing south
    Then I take a screenshot "dalmatian puppy beside an adult"
    And no errors were logged

  # The corpse has one direction only. The game builds the others by rotating it, so a long-dead
  # dalmatian is drawn from the side whichever way it lies. That is a documented gap and not a
  # defect: the assertion is that it draws without a crash and logs nothing.
  @review
  Scenario: a long-dead dalmatian draws from its single texture and logs nothing
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Dalmatians Renew spawns the player animal "Rex" as "CCPDalmatian"
    When Dalmatians Renew kills "Rex" and lets the corpse reach dessicated rot
    And Dalmatians Renew centres the camera on "Rex"
    Then I take a screenshot "dessicated dalmatian corpse"
    And no errors were logged
    And no warnings from mod "nelim.dalmatiansrenew"

  # M. Text, in the language of this pass. The language step is an assertion about the pass, not
  #    a switch: a pass that fell back to English silently would prove nothing about French.
  @english
  Scenario: the animal, the puppy, the attacks and the leather read in English
    Then the language is "English"
    And Dalmatians Renew the thing "CCPDalmatian" is labelled "dalmatian"
    And Dalmatians Renew the thing "CCPDalmatian" has a description beginning "A very muscular, medium-sized dog."
    And Dalmatians Renew the thing "CCPDalmatian" has the attack labels "left claw, right claw, head"
    And Dalmatians Renew the pawn kind "CCPDalmatian" is labelled "dalmatian" and pluralised "dalmatians"
    And Dalmatians Renew the first life stage of pawn kind "CCPDalmatian" is labelled "dalmatian puppy" and pluralised "dalmatian puppies"
    And Dalmatians Renew the thing "Leather_Dalmatian" is labelled "dalmatian leather"
    And Dalmatians Renew the material "Leather_Dalmatian" is called "dalmatian leather" when it names a garment

  @french
  Scenario: the animal, the puppy, the attacks and the leather read in French
    Then the language is "French"
    And Dalmatians Renew the thing "CCPDalmatian" is labelled "dalmatien"
    And Dalmatians Renew the thing "CCPDalmatian" has a description beginning "Chien musculeux de taille moyenne."
    And Dalmatians Renew the thing "CCPDalmatian" has the attack labels "griffe gauche, griffe droite, tête"
    And Dalmatians Renew the pawn kind "CCPDalmatian" is labelled "dalmatien" and pluralised "dalmatiens"
    And Dalmatians Renew the first life stage of pawn kind "CCPDalmatian" is labelled "chiot dalmatien" and pluralised "chiots dalmatiens"
    And Dalmatians Renew the thing "Leather_Dalmatian" is labelled "fourrure de dalmatien"
    And Dalmatians Renew the material "Leather_Dalmatian" is called "fourrure de dalmatien" when it names a garment
