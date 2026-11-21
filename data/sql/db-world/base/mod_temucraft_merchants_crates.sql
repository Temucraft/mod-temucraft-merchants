-- mod-temucraft-merchants: Waylaid Supply Crates. They drop like writs; filled with gathered goods they become Sealed
-- Crates, which the supply quartermasters take (repeatable quests) for Merchant's Favor. Re-runnable.
SET @Favor := 601700;
SET @Crate := 601980;
SET @CrateQuest := 602010;
SET @Camp := 601971;
DELETE FROM `item_template` WHERE `entry` BETWEEN @Crate AND @Crate+35;
DELETE FROM `quest_template` WHERE `ID` BETWEEN @CrateQuest AND @CrateQuest+5;
DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN @CrateQuest AND @CrateQuest+5;
DELETE FROM `creature_questender` WHERE `quest` BETWEEN @CrateQuest AND @CrateQuest+5;
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN @CrateQuest AND @CrateQuest+5;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `ItemLevel`, `maxcount`, `stackable`, `bonding`, `description`, `Material`, `ScriptName`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`, `VerifiedBuild`) VALUES
(@Crate, 15, 4, -1, 'Waylaid Crate: Apprentice Herbs', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+1, 15, 4, -1, 'Waylaid Crate: Journeyman Herbs', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+2, 15, 4, -1, 'Waylaid Crate: Expert Herbs', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+3, 15, 4, -1, 'Waylaid Crate: Artisan Herbs', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+4, 15, 4, -1, 'Waylaid Crate: Master Herbs', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+5, 15, 4, -1, 'Waylaid Crate: Grand Master Herbs', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+6, 15, 4, -1, 'Waylaid Crate: Apprentice Ore', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+7, 15, 4, -1, 'Waylaid Crate: Journeyman Ore', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+8, 15, 4, -1, 'Waylaid Crate: Expert Ore', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+9, 15, 4, -1, 'Waylaid Crate: Artisan Ore', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+10, 15, 4, -1, 'Waylaid Crate: Master Ore', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+11, 15, 4, -1, 'Waylaid Crate: Grand Master Ore', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+12, 15, 4, -1, 'Waylaid Crate: Apprentice Leather', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+13, 15, 4, -1, 'Waylaid Crate: Journeyman Leather', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+14, 15, 4, -1, 'Waylaid Crate: Expert Leather', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+15, 15, 4, -1, 'Waylaid Crate: Artisan Leather', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+16, 15, 4, -1, 'Waylaid Crate: Master Leather', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+17, 15, 4, -1, 'Waylaid Crate: Grand Master Leather', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+18, 15, 4, -1, 'Waylaid Crate: Apprentice Cloth', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+19, 15, 4, -1, 'Waylaid Crate: Journeyman Cloth', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+20, 15, 4, -1, 'Waylaid Crate: Expert Cloth', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+21, 15, 4, -1, 'Waylaid Crate: Artisan Cloth', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+22, 15, 4, -1, 'Waylaid Crate: Master Cloth', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+23, 15, 4, -1, 'Waylaid Crate: Grand Master Cloth', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(@Crate+30, 15, 4, -1, 'Sealed Apprentice Crate', 12331, 2, 1, 0, 0, 0, 5, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(@Crate+31, 15, 4, -1, 'Sealed Journeyman Crate', 12331, 2, 1, 0, 0, 0, 15, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(@Crate+32, 15, 4, -1, 'Sealed Expert Crate', 12331, 2, 1, 0, 0, 0, 30, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(@Crate+33, 15, 4, -1, 'Sealed Artisan Crate', 12331, 2, 1, 0, 0, 0, 45, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(@Crate+34, 15, 4, -1, 'Sealed Master Crate', 12331, 2, 1, 0, 0, 0, 60, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(@Crate+35, 15, 4, -1, 'Sealed Grand Master Crate', 12331, 2, 1, 0, 0, 0, 70, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `Flags`, `RewardItem1`, `RewardAmount1`, `LogTitle`, `LogDescription`, `QuestDescription`, `QuestCompletionLog`, `RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(@CrateQuest, 2, -1, 5, 0, @Favor, 5, 'Sealed Apprentice Crate', 'Hand over a Sealed Apprentice Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Apprentice Crate.', @CrateQuest, 1, 0),
(@CrateQuest+1, 2, -1, 15, 0, @Favor, 10, 'Sealed Journeyman Crate', 'Hand over a Sealed Journeyman Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Journeyman Crate.', @CrateQuest+1, 1, 0),
(@CrateQuest+2, 2, -1, 30, 0, @Favor, 15, 'Sealed Expert Crate', 'Hand over a Sealed Expert Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Expert Crate.', @CrateQuest+2, 1, 0),
(@CrateQuest+3, 2, -1, 45, 0, @Favor, 20, 'Sealed Artisan Crate', 'Hand over a Sealed Artisan Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Artisan Crate.', @CrateQuest+3, 1, 0),
(@CrateQuest+4, 2, -1, 60, 0, @Favor, 30, 'Sealed Master Crate', 'Hand over a Sealed Master Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Master Crate.', @CrateQuest+4, 1, 0),
(@CrateQuest+5, 2, -1, 70, 0, @Favor, 40, 'Sealed Grand Master Crate', 'Hand over a Sealed Grand Master Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Grand Master Crate.', @CrateQuest+5, 1, 0);
INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`) VALUES (@CrateQuest, 1), (@CrateQuest+1, 1), (@CrateQuest+2, 1), (@CrateQuest+3, 1), (@CrateQuest+4, 1), (@CrateQuest+5, 1);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(@Camp, @CrateQuest),(@Camp+2, @CrateQuest),
(@Camp, @CrateQuest+1),(@Camp+2, @CrateQuest+1),
(@Camp, @CrateQuest+2),(@Camp+2, @CrateQuest+2),
(@Camp, @CrateQuest+3),(@Camp+2, @CrateQuest+3),
(@Camp, @CrateQuest+4),(@Camp+2, @CrateQuest+4),
(@Camp, @CrateQuest+5),(@Camp+2, @CrateQuest+5);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(@Camp, @CrateQuest),(@Camp+2, @CrateQuest),
(@Camp, @CrateQuest+1),(@Camp+2, @CrateQuest+1),
(@Camp, @CrateQuest+2),(@Camp+2, @CrateQuest+2),
(@Camp, @CrateQuest+3),(@Camp+2, @CrateQuest+3),
(@Camp, @CrateQuest+4),(@Camp+2, @CrateQuest+4),
(@Camp, @CrateQuest+5),(@Camp+2, @CrateQuest+5);
