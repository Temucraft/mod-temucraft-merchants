-- mod-temucraft-merchants: a neutral auctioneer at each supply camp, more Merchant's Favor rewards (mounts and
-- pets), and the rewards need reputation with the camp's faction: Friendly for the cheaper ones, up to Exalted
-- for the mammoth. Re-runnable.
-- Neutral auctioneers at the camps (Booty Bay's faction: the neutral auction house)
DELETE FROM `creature` WHERE `guid` IN (9200164, 9200165);
DELETE FROM `creature_template` WHERE `entry` IN (601975, 601976);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (601975, 601976);
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `unit_class`, `unit_flags`, `type`, `AIName`, `MovementType`, `HealthModifier`, `RegenHealth`, `flags_extra`,
    `ScriptName`, `VerifiedBuild`) VALUES
(601975, 'Auctioneer Fizzlecoin', 'Supply Camp Auctioneer', 55, 55, 120, 2097152, 1, 1.14286, 1, 0, 7, '', 0, 1, 1, 2, '', 0),
(601976, 'Auctioneer Sprocketbid', 'Supply Camp Auctioneer', 55, 55, 120, 2097152, 1, 1.14286, 1, 0, 7, '', 0, 1, 1, 2, '', 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(601975, 0, 7160, 1, 1, 0), (601976, 0, 7160, 1, 1, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`,
    `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(9200164, 601975, 0, 0, 0, 1, 1, 0, -9598.60, -1784.50, 52.70, 2.6, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 'Three Corners: supply camp auctioneer'),
(9200165, 601976, 1, 0, 0, 1, 1, 0, -517.00, -2654.00, 95.00, 1.2, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 'Outside the Crossroads: supply camp auctioneer');

-- More Merchant's Favor rewards: a ram and a kodo, and two mechanical pets
INSERT IGNORE INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(601972, 0, 5864, 0, 0, 3001, 0),  -- Gray Ram
(601972, 0, 4401, 0, 0, 2999, 0),  -- Mechanical Squirrel Box
(601974, 0, 15290, 0, 0, 3001, 0), -- Brown Kodo
(601974, 0, 10398, 0, 0, 2999, 0); -- Mechanical Chicken

-- Reputation needed for each reward, by its price tier (ExtendedCost 2998-3003)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` IN (601972, 601974);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
    `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 23, v.`entry`, v.`item`, 0, 0, 5, 0, IF(v.`entry` = 601972, 2233, 2234),
    CASE v.`ExtendedCost` WHEN 2999 THEN 240 WHEN 3000 THEN 224 WHEN 3001 THEN 192 ELSE 128 END, 0, 0, 0, 0, '',
    'mod-temucraft-merchants: supply camp reward needs reputation'
FROM `npc_vendor` v WHERE v.`entry` IN (601972, 601974) AND v.`ExtendedCost` BETWEEN 2999 AND 3003;
