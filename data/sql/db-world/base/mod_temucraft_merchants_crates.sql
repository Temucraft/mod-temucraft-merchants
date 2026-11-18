-- mod-temucraft-merchants: Waylaid Supply Crates. They drop like writs; filled with gathered goods they become Sealed
-- Crates, which the supply quartermasters take (repeatable quests) for Merchant's Favor. Re-runnable.
DELETE FROM `item_template` WHERE `entry` BETWEEN 601980 AND 602015;
DELETE FROM `quest_template` WHERE `ID` BETWEEN 602010 AND 602015;
DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 602010 AND 602015;
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 602010 AND 602015;
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 602010 AND 602015;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `ItemLevel`, `maxcount`, `stackable`, `bonding`, `description`, `Material`, `ScriptName`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`, `VerifiedBuild`) VALUES
(601980, 15, 4, -1, 'Waylaid Crate: Apprentice Herbs', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601981, 15, 4, -1, 'Waylaid Crate: Journeyman Herbs', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601982, 15, 4, -1, 'Waylaid Crate: Expert Herbs', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601983, 15, 4, -1, 'Waylaid Crate: Artisan Herbs', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601984, 15, 4, -1, 'Waylaid Crate: Master Herbs', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601985, 15, 4, -1, 'Waylaid Crate: Grand Master Herbs', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the herbs it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601986, 15, 4, -1, 'Waylaid Crate: Apprentice Ore', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601987, 15, 4, -1, 'Waylaid Crate: Journeyman Ore', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601988, 15, 4, -1, 'Waylaid Crate: Expert Ore', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601989, 15, 4, -1, 'Waylaid Crate: Artisan Ore', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601990, 15, 4, -1, 'Waylaid Crate: Master Ore', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601991, 15, 4, -1, 'Waylaid Crate: Grand Master Ore', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the ore it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601992, 15, 4, -1, 'Waylaid Crate: Apprentice Leather', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601993, 15, 4, -1, 'Waylaid Crate: Journeyman Leather', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601994, 15, 4, -1, 'Waylaid Crate: Expert Leather', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601995, 15, 4, -1, 'Waylaid Crate: Artisan Leather', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601996, 15, 4, -1, 'Waylaid Crate: Master Leather', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601997, 15, 4, -1, 'Waylaid Crate: Grand Master Leather', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 10 of one of the leather it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601998, 15, 4, -1, 'Waylaid Crate: Apprentice Cloth', 12331, 1, 1, 0, 100, 0, 5, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(601999, 15, 4, -1, 'Waylaid Crate: Journeyman Cloth', 12331, 1, 1, 0, 100, 0, 15, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(602000, 15, 4, -1, 'Waylaid Crate: Expert Cloth', 12331, 1, 1, 0, 100, 0, 30, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(602001, 15, 4, -1, 'Waylaid Crate: Artisan Cloth', 12331, 1, 1, 0, 100, 0, 45, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(602002, 15, 4, -1, 'Waylaid Crate: Master Cloth', 12331, 1, 1, 0, 100, 0, 60, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(602003, 15, 4, -1, 'Waylaid Crate: Grand Master Cloth', 12331, 1, 1, 0, 100, 0, 70, 0, 1, 0, 'Fill it with 20 of one of the cloth it asks for, then take it to a supply quartermaster.', -1, 'item_temucraft_waylaid_crate', 18282, 0, -1, 0),
(602010, 15, 4, -1, 'Sealed Apprentice Crate', 12331, 2, 1, 0, 0, 0, 5, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(602011, 15, 4, -1, 'Sealed Journeyman Crate', 12331, 2, 1, 0, 0, 0, 15, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(602012, 15, 4, -1, 'Sealed Expert Crate', 12331, 2, 1, 0, 0, 0, 30, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(602013, 15, 4, -1, 'Sealed Artisan Crate', 12331, 2, 1, 0, 0, 0, 45, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(602014, 15, 4, -1, 'Sealed Master Crate', 12331, 2, 1, 0, 0, 0, 60, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0),
(602015, 15, 4, -1, 'Sealed Grand Master Crate', 12331, 2, 1, 0, 0, 0, 70, 0, 20, 0, 'A filled supply crate. Supply quartermasters pay Merchant\'s Favor for it.', -1, '', 0, 0, 0, 0);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `Flags`, `RewardItem1`, `RewardAmount1`, `LogTitle`, `LogDescription`, `QuestDescription`, `QuestCompletionLog`, `RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(602010, 2, -1, 5, 0, 601700, 5, 'Sealed Apprentice Crate', 'Hand over a Sealed Apprentice Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Apprentice Crate.', 602010, 1, 0),
(602011, 2, -1, 15, 0, 601700, 10, 'Sealed Journeyman Crate', 'Hand over a Sealed Journeyman Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Journeyman Crate.', 602011, 1, 0),
(602012, 2, -1, 30, 0, 601700, 15, 'Sealed Expert Crate', 'Hand over a Sealed Expert Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Expert Crate.', 602012, 1, 0),
(602013, 2, -1, 45, 0, 601700, 20, 'Sealed Artisan Crate', 'Hand over a Sealed Artisan Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Artisan Crate.', 602013, 1, 0),
(602014, 2, -1, 60, 0, 601700, 30, 'Sealed Master Crate', 'Hand over a Sealed Master Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Master Crate.', 602014, 1, 0),
(602015, 2, -1, 70, 0, 601700, 40, 'Sealed Grand Master Crate', 'Hand over a Sealed Grand Master Crate.', 'Filled supply crates keep the camps going. Bring me a sealed one and the Favor is yours.', 'Return with a Sealed Grand Master Crate.', 602015, 1, 0);
INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`) VALUES (602010, 1), (602011, 1), (602012, 1), (602013, 1), (602014, 1), (602015, 1);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(601971, 602010),(601973, 602010),
(601971, 602011),(601973, 602011),
(601971, 602012),(601973, 602012),
(601971, 602013),(601973, 602013),
(601971, 602014),(601973, 602014),
(601971, 602015),(601973, 602015);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(601971, 602010),(601973, 602010),
(601971, 602011),(601973, 602011),
(601971, 602012),(601973, 602012),
(601971, 602013),(601973, 602013),
(601971, 602014),(601973, 602014),
(601971, 602015),(601973, 602015);
