# Pass 8 (alone) and pass 9 (with Dogs mate): Better Crossbreeding beside this mod. English only.
#
# Mod/Patches/Compat_BetterCrossbreeding.xml makes the dalmatian cross with Husky, LabradorRetriever and
# YorkshireTerrier, each way, with a coin-flip pup. Two halves, both asserted on the live defs: the list
# on the MALE's race (what the game reads to pair them) and the DZY.CrossBreeding.Extension on the
# MOTHER's kind (what the mod reads to decide the pup). Neither half alone breeds anything.
# The extension class is spelled DZY.CrossBreeding in the assembly; a patch copied from the mod's
# Example/ names a type that does not exist, and the extension would then simply be missing.
#
# What is NOT played here: a pregnancy through to a birth. The mod keeps a per-save dictionary of fathers,
# so it would need a save and a reload; recorded in BACKLOG.md.

@requires:DizzyEevee.BetterCrossbreeding
Feature: The dalmatian beside Better Crossbreeding

  Scenario: the dalmatian and the three vanilla dogs seek each other, once
    Then mod "DizzyEevee.BetterCrossbreeding" is loaded
    And Dalmatians Renew the male "CCPDalmatian" lists "Husky" once
    And Dalmatians Renew the male "CCPDalmatian" lists "LabradorRetriever" once
    And Dalmatians Renew the male "CCPDalmatian" lists "YorkshireTerrier" once
    And Dalmatians Renew the male "Husky" lists "CCPDalmatian" once
    And Dalmatians Renew the male "LabradorRetriever" lists "CCPDalmatian" once
    And Dalmatians Renew the male "YorkshireTerrier" lists "CCPDalmatian" once

  Scenario: every mother has a coin-flip outcome for the other breed
    Then Dalmatians Renew the mother kind "CCPDalmatian" carries one Better Crossbreeding extension
    And Dalmatians Renew the mother kind "CCPDalmatian" has the outcome Random when the father kind is "Husky"
    And Dalmatians Renew the mother kind "CCPDalmatian" has the outcome Random when the father kind is "LabradorRetriever"
    And Dalmatians Renew the mother kind "CCPDalmatian" has the outcome Random when the father kind is "YorkshireTerrier"
    And Dalmatians Renew the mother kind "Husky" has the outcome Random when the father kind is "CCPDalmatian"
    And Dalmatians Renew the mother kind "LabradorRetriever" has the outcome Random when the father kind is "CCPDalmatian"
    And Dalmatians Renew the mother kind "YorkshireTerrier" has the outcome Random when the father kind is "CCPDalmatian"

  Scenario: this patch made no pairing between two vanilla animals
    Then Dalmatians Renew the mother kind "Husky" has no outcome when the father kind is "LabradorRetriever"
    And Dalmatians Renew the male "CCPDalmatian" does not seek "Wolf_Timber" to mate with

  # Tagged: with Dogs mate loaded (pass 9) the three vanilla dogs DO seek each other, by that mod's Dog group,
  # which is not this patch's doing. Pass 9 excludes this tag; pass 8 plays it. (Pass 9 failed on it on 2026-10-02.)
  @without-dogsmate
  Scenario: without Dogs mate the vanilla dogs do not seek each other
    Then Dalmatians Renew the male "Husky" does not seek "LabradorRetriever" to mate with

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.dalmatians"
