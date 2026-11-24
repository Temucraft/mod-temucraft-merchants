# mod-temucraft-merchants

Two supply factions, the Azeroth Commerce Authority (Three Corners, Redridge) and Durotar Supply and Logistics (outside the Crossroads).

- **Craftsman's Writs:** 257 rare drops (6 per profession per tier, Journeyman to Grand Master) that start a daily quest: bring the crafted item to a quartermaster for reputation, Merchant's Favor and money.
- **Waylaid Supply Crates:** drops; filled with herbs, ore, leather or cloth they become Sealed Crates, traded for Merchant's Favor and some reputation.
- **Merchant's Favor** (currency tab) buys recipes, the Traveler's Tundra Mammoth, a ram, a kodo and pets; each reward needs reputation (Friendly to Exalted by price).
- A neutral auctioneer at each camp.

## Install

1. Put this folder in `modules/` of your AzerothCore source, re-run CMake and build.
2. The SQL in `data/sql/` is applied by the worldserver on its next start (AzerothCore's module updater). Every file deletes its own rows before inserting them, so running one again is safe.
   Copy `conf/mod-temucraft-merchants.conf.dist` to your `configs/modules/` as `mod-temucraft-merchants.conf` to change its settings.
3. **Client.** `client/patch-M.MPQ/` is a patch folder, not a packed MPQ: pack it yourself (for example with Ladik's MPQ Editor: new MPQ, add the folder contents keeping the `DBFilesClient\` path) and put the `.MPQ` in the game's `Data/` folder. Each DBC in it is the stock 3.3.5a (12340) file plus only this module's rows.
   **Using more than one Temucraft module, or other DBC changes?** Two patches that both carry `Spell.dbc` overwrite each other (the later letter wins). Use the all-in-one patch from the Temucraft configuration repo (`client/patch-5.MPQ/`, every Temucraft change merged), or merge the rows yourself. The server side never conflicts: it reads this module's rows from the `*_dbc` tables in `data/sql/`.

## What it adds, and where

| Database | Table | IDs |
|---|---|---|
| world | `item_template` | 601700 (Merchant's Favor), 601710-601966 (writs), 601980-602015 (crates) |
| world | `quest_template` (+`_addon`) | 601710-601966 (writs), 602010-602015 (crates) |
| world | `creature_template` (+`_model`) | 601971-601976 |
| world | `creature` | spawns 9200160-9200165 |
| world | `creature_queststarter`, `creature_questender` | the camp quartermasters |
| world | `npc_vendor` | 601972, 601974 |
| world | `conditions` | source type 23 (vendor) for 601972, 601974 |
| world | `faction_dbc` | 2233, 2234 |
| world | `itemextendedcost_dbc` | 2998-3003 |
| world | `currencytypes_dbc` | 342 |
| client | `Faction.dbc`, `ItemExtendedCost.dbc`, `CurrencyTypes.dbc` | the same rows |

## Works with other modules

- Writs ask for existing crafted items; vendors sell existing recipes and mounts.
- Faction IDs 2233-2234, extended costs 2998-3003 and currency 342 must be free in your DBCs.

## Independence

This module doesn't need any other module, nor any other Temucraft module. 

## Customising IDs

The entries above are a block reserved for this module. The writ items (601710-601969) are also in `src/TemucraftWrits.cpp` (`WRIT_FIRST`, `WRIT_LAST`); the factions, costs and currency are in the client DBCs too.

## Texts and translations

The 3 player-facing texts (chat messages, gossip options) are in the `module_string` table under the module name
`mod-temucraft-merchants`, so they can be changed without rebuilding. Translations go in `module_string_locale` with the same
module and id plus the locale (`deDE`, `esES`, `frFR`, ...). If a row is missing the English text in the code is used.

Part of the Temucraft modules for AzerothCore 3.3.5a.
