-- mod-temucraft-merchants: a neutral auctioneer at each supply camp, more Merchant's Favor rewards (mounts and
-- pets), and the rewards need reputation with the camp's faction: Friendly for the cheaper ones, up to Exalted
-- for the mammoth. Re-runnable.
-- Neutral auctioneers at the camps (Booty Bay's faction: the neutral auction house)
SET @RewardNpc := 601975;
SET @RewardSpawn := 9200164;
SET @Camp := 601971;
DELETE FROM `creature` WHERE `guid` IN (@RewardSpawn, @RewardSpawn+1);
DELETE FROM `creature_template` WHERE `entry` IN (@RewardNpc, @RewardNpc+1);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (@RewardNpc, @RewardNpc+1);
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`,
    `speed_run`, `unit_class`, `unit_flags`, `type`, `AIName`, `MovementType`, `HealthModifier`, `RegenHealth`, `flags_extra`,
    `ScriptName`, `VerifiedBuild`) VALUES
(@RewardNpc, 'Auctioneer Fizzlecoin', 'Supply Camp Auctioneer', 55, 55, 120, 2097152, 1, 1.14286, 1, 0, 7, '', 0, 1, 1, 2, '', 0),
(@RewardNpc+1, 'Auctioneer Sprocketbid', 'Supply Camp Auctioneer', 55, 55, 120, 2097152, 1, 1.14286, 1, 0, 7, '', 0, 1, 1, 2, '', 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(@RewardNpc, 0, 7160, 1, 1, 0), (@RewardNpc+1, 0, 7160, 1, 1, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`,
    `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@RewardSpawn, @RewardNpc, 0, 0, 0, 1, 1, 0, -9598.60, -1784.50, 52.70, 2.6, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 'Three Corners: supply camp auctioneer'),
(@RewardSpawn+1, @RewardNpc+1, 1, 0, 0, 1, 1, 0, -517.00, -2654.00, 95.00, 1.2, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 'Outside the Crossroads: supply camp auctioneer');

-- More Merchant's Favor rewards: a ram and a kodo, and two mechanical pets
INSERT IGNORE INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(@Camp+1, 0, 5864, 0, 0, 3001, 0),  -- Gray Ram
(@Camp+1, 0, 4401, 0, 0, 2999, 0),  -- Mechanical Squirrel Box
(@Camp+3, 0, 15290, 0, 0, 3001, 0), -- Brown Kodo
(@Camp+3, 0, 10398, 0, 0, 2999, 0); -- Mechanical Chicken

-- Reputation needed for each reward, by its price tier (ExtendedCost 2998-3003)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` IN (@Camp+1, @Camp+3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
    `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 23, v.`entry`, v.`item`, 0, 0, 5, 0, IF(v.`entry` = @Camp+1, 2233, 2234),
    CASE v.`ExtendedCost` WHEN 2999 THEN 240 WHEN 3000 THEN 224 WHEN 3001 THEN 192 ELSE 128 END, 0, 0, 0, 0, '',
    'mod-temucraft-merchants: supply camp reward needs reputation'
FROM `npc_vendor` v WHERE v.`entry` IN (@Camp+1, @Camp+3) AND v.`ExtendedCost` BETWEEN 2999 AND 3003;
