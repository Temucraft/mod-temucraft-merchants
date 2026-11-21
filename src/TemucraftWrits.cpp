/*
 * mod-temucraft-merchants: Craftsman's Writs.
 *
 * Writs (items 601710+, data/sql) start daily quests: bring a crafted item to a quartermaster of the Azeroth Commerce
 * Authority (Three Corners, Redridge) or Durotar Supply and Logistics (outside the Crossroads). The quest gives
 * reputation with both supply factions (the other faction's stays hidden), Merchant's Favor and money; the factions'
 * vendors sell recipes and a Traveler's Tundra Mammoth for Merchant's Favor.
 *
 * Writs drop from creatures that have loot, Temucraft.Writs.DropChance percent of the time, matching the creature's
 * level: Journeyman from 15, Expert from 30, Artisan from 45, Master from 60, Grand Master from 70.
 * At startup the camp NPCs are put on the ground under their spots.
 */

#include "Config.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "LootMgr.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

#include <array>
#include <cmath>
#include <random>
#include <vector>

namespace
{
    uint32 WRIT_FIRST = 601710, WRIT_LAST = 601969;       // Temucraft.Writs.ItemFirst / ItemLast
    uint32 CAMP_FIRST = 601971, CAMP_LAST = 601974;       // Temucraft.Writs.CampCreatureFirst / CampCreatureLast
    // The writs' item level is their tier's minimum character level (data/sql)
    constexpr std::array<uint32, 5> TIER_ITEM_LEVEL = { 10, 20, 35, 60, 70 };
    std::array<uint8, 5> TIER_CREATURE_LEVEL = { 15, 30, 45, 60, 70 };    // Temucraft.Writs.TierCreatureLevels
    // "a b c ..." -> levels; keeps the defaults when the list doesn't have exactly N numbers
    template<size_t N>
    void ParseLevels(std::string const& text, std::array<uint8, N>& out)
    {
        std::array<uint8, N> levels{};
        size_t n = 0;
        for (std::string_view token : Acore::Tokenize(text, ' ', false))
        {
            Optional<uint32> v = Acore::StringTo<uint32>(token);
            if (!v || n >= N)
                return;
            levels[n++] = uint8(std::min<uint32>(*v, 255));
        }
        if (n == N)
            out = levels;
    }


    struct WritSettings
    {
        bool enable = true;
        float dropChance = 3.0f;
    } writs;

    std::array<std::vector<uint32>, 5> sWritsByTier;

    void LoadWrits()
    {
        for (auto& list : sWritsByTier)
            list.clear();
        for (uint32 entry = WRIT_FIRST; entry <= WRIT_LAST; ++entry)
            if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(entry))
                for (uint8 tier = 0; tier < TIER_ITEM_LEVEL.size(); ++tier)
                    if (proto->ItemLevel == TIER_ITEM_LEVEL[tier] && proto->StartQuest)
                        sWritsByTier[tier].push_back(entry);
    }

    void GroundCampNpcs()
    {
        QueryResult result = WorldDatabase.Query("SELECT `guid` FROM `creature` WHERE `id` BETWEEN {} AND {}", CAMP_FIRST, CAMP_LAST);
        if (!result)
            return;
        do
        {
            ObjectGuid::LowType guid = result->Fetch()[0].Get<uint32>();
            CreatureData const* data = sObjectMgr->GetCreatureData(guid);
            if (!data)
                continue;
            Map* map = sMapMgr->CreateBaseMap(data->mapid);
            if (!map)
                continue;
            float ground = map->GetHeight(data->phaseMask, data->posX, data->posY, data->posZ + 60.0f, true, 120.0f);
            if (ground <= INVALID_HEIGHT || std::fabs(ground - data->posZ) < 0.3f)
                continue;
            const_cast<CreatureData*>(data)->posZ = ground;
            WorldDatabase.Execute("UPDATE `creature` SET `position_z` = {:.3f} WHERE `guid` = {}", ground, guid);
        } while (result->NextRow());
    }
}

class TemucraftWrits_Player : public PlayerScript
{
public:
    TemucraftWrits_Player() : PlayerScript("TemucraftWrits_Player", { PLAYERHOOK_ON_CREATURE_KILL, PLAYERHOOK_ON_CREATURE_KILLED_BY_PET }) { }

    void OnPlayerCreatureKilledByPet(Player* owner, Creature* killed) override
    {
        OnPlayerCreatureKill(owner, killed);
    }

    void OnPlayerCreatureKill(Player* /*killer*/, Creature* killed) override
    {
        if (!writs.enable || !killed || killed->IsCritter() || killed->IsPet() || killed->IsSummon() ||
            (killed->loot.empty() && !killed->loot.gold))
            return;
        static thread_local std::mt19937 rng{ std::random_device{}() };
        if (std::uniform_real_distribution<float>(0.0f, 100.0f)(rng) >= writs.dropChance)
            return;
        int8 tier = -1;
        for (uint8 i = 0; i < TIER_CREATURE_LEVEL.size(); ++i)
            if (killed->GetLevel() >= TIER_CREATURE_LEVEL[i])
                tier = i;
        if (tier < 0 || sWritsByTier[tier].empty())
            return;
        std::vector<uint32> const& list = sWritsByTier[tier];
        uint32 writ = list[std::uniform_int_distribution<size_t>(0, list.size() - 1)(rng)];
        killed->loot.AddItem(LootStoreItem(writ, 0, 100.0f, false, LOOT_MODE_DEFAULT, 0, 1, 1));
    }
};

class TemucraftWrits_World : public WorldScript
{
public:
    TemucraftWrits_World() : WorldScript("TemucraftWrits_World", { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        writs.enable = sConfigMgr->GetOption<bool>("Temucraft.Writs.Enable", true);
        writs.dropChance = sConfigMgr->GetOption<float>("Temucraft.Writs.DropChance", 3.0f);
        WRIT_FIRST = sConfigMgr->GetOption<uint32>("Temucraft.Writs.ItemFirst", 601710);
        WRIT_LAST = sConfigMgr->GetOption<uint32>("Temucraft.Writs.ItemLast", 601969);
        CAMP_FIRST = sConfigMgr->GetOption<uint32>("Temucraft.Writs.CampCreatureFirst", 601971);
        CAMP_LAST = sConfigMgr->GetOption<uint32>("Temucraft.Writs.CampCreatureLast", 601974);
        ParseLevels(sConfigMgr->GetOption<std::string>("Temucraft.Writs.TierCreatureLevels", "15 30 45 60 70"), TIER_CREATURE_LEVEL);
    }

    void OnStartup() override
    {
        LoadWrits();
        GroundCampNpcs();
        uint32 total = 0;
        for (auto const& list : sWritsByTier)
            total += uint32(list.size());
        LOG_INFO("module", "mod-temucraft-merchants: {} Craftsman's Writs can drop", total);
    }
};

void AddTemucraftWritsScripts()
{
    new TemucraftWrits_Player();
    new TemucraftWrits_World();
}
