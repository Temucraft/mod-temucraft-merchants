-- mod-temucraft-merchants: the DBC rows this module needs, for the server (AzerothCore reads the *_dbc tables on top of
-- its DBC files). The client needs the same rows: see client/ in this module. Re-runnable.
-- faction_dbc: 2 row(s) mod-temucraft-merchants
SET @MerchantFaction := 2233;
SET @ExtendedCost := 2998;
SET @Currency := 342;
SET @Favor := 601700;
DELETE FROM `faction_dbc` WHERE `ID` IN (@MerchantFaction,@MerchantFaction+1);
INSERT INTO `faction_dbc` (`ID`, `ReputationIndex`, `ReputationRaceMask_1`, `ReputationRaceMask_2`, `ReputationRaceMask_3`, `ReputationRaceMask_4`, `ReputationClassMask_1`, `ReputationClassMask_2`, `ReputationClassMask_3`, `ReputationClassMask_4`, `ReputationBase_1`, `ReputationBase_2`, `ReputationBase_3`, `ReputationBase_4`, `ReputationFlags_1`, `ReputationFlags_2`, `ReputationFlags_3`, `ReputationFlags_4`, `ParentFactionID`, `ParentFactionMod_1`, `ParentFactionMod_2`, `ParentFactionCap_1`, `ParentFactionCap_2`, `Name_Lang_enUS`, `Name_Lang_enGB`, `Name_Lang_koKR`, `Name_Lang_frFR`, `Name_Lang_deDE`, `Name_Lang_enCN`, `Name_Lang_zhCN`, `Name_Lang_enTW`, `Name_Lang_zhTW`, `Name_Lang_esES`, `Name_Lang_esMX`, `Name_Lang_ruRU`, `Name_Lang_ptPT`, `Name_Lang_ptBR`, `Name_Lang_itIT`, `Name_Lang_Unk`, `Name_Lang_Mask`, `Description_Lang_enUS`, `Description_Lang_enGB`, `Description_Lang_koKR`, `Description_Lang_frFR`, `Description_Lang_deDE`, `Description_Lang_enCN`, `Description_Lang_zhCN`, `Description_Lang_enTW`, `Description_Lang_zhTW`, `Description_Lang_esES`, `Description_Lang_esMX`, `Description_Lang_ruRU`, `Description_Lang_ptPT`, `Description_Lang_ptBR`, `Description_Lang_itIT`, `Description_Lang_Unk`, `Description_Lang_Mask`) VALUES
(@MerchantFaction,117,363535437,710206386,0,0,0,0,0,0,0,0,0,0,136,6,0,0,469,0.0,0.0,5,5,'Azeroth Commerce Authority','','','','','','','','','','','','','','','',16712190,'Merchants of the Alliance who pay well for crafted goods. Craftsman\'s Writs earn their trust.','','','','','','','','','','','','','','','',16712190),
(@MerchantFaction+1,123,710206386,363535437,0,0,0,0,0,0,0,-42000,0,0,152,6,0,0,67,0.0,0.0,5,5,'Durotar Supply and Logistics','','','','','','','','','','','','','','','',16712190,'The Horde\'s quartermasters, always short of crafted goods. Craftsman\'s Writs earn their trust.','','','','','','','','','','','','','','','',16712190);

-- itemextendedcost_dbc: 6 row(s) mod-temucraft-merchants
DELETE FROM `itemextendedcost_dbc` WHERE `ID` IN (@ExtendedCost,@ExtendedCost+1,@ExtendedCost+2,@ExtendedCost+3,@ExtendedCost+4,@ExtendedCost+5);
INSERT INTO `itemextendedcost_dbc` (`ID`, `HonorPoints`, `ArenaPoints`, `ArenaBracket`, `ItemID_1`, `ItemID_2`, `ItemID_3`, `ItemID_4`, `ItemID_5`, `ItemCount_1`, `ItemCount_2`, `ItemCount_3`, `ItemCount_4`, `ItemCount_5`, `RequiredArenaRating`, `ItemPurchaseGroup`) VALUES
(@ExtendedCost,0,0,0,@Favor,0,0,0,0,45,0,0,0,0,0,0),
(@ExtendedCost+1,0,0,0,@Favor,0,0,0,0,120,0,0,0,0,0,0),
(@ExtendedCost+2,0,0,0,@Favor,0,0,0,0,180,0,0,0,0,0,0),
(@ExtendedCost+3,0,0,0,@Favor,0,0,0,0,240,0,0,0,0,0,0),
(@ExtendedCost+4,0,0,0,@Favor,0,0,0,0,300,0,0,0,0,0,0),
(@ExtendedCost+5,0,0,0,@Favor,0,0,0,0,6000,0,0,0,0,0,0);

-- currencytypes_dbc: 1 row(s) mod-temucraft-merchants
DELETE FROM `currencytypes_dbc` WHERE `ID` IN (@Currency);
-- BitIndex is the bit in the player's known currencies (1 to 64, one per currency). 0 is not a bit: the Favor was
-- stored but never shown in the currency tab. 26 is free in the shipped CurrencyTypes.dbc.
INSERT INTO `currencytypes_dbc` (`ID`, `ItemID`, `CategoryID`, `BitIndex`) VALUES
(@Currency,@Favor,1,26);
