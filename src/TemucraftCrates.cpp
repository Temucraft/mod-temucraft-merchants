/*
 * mod-temucraft-merchants: Waylaid Supply Crates.
 *
 * Crates (items 601980-602003: herbs, ore, leather or cloth, Apprentice to Grand Master) drop alongside writs, from
 * creatures of the matching level. Using one with enough of one of the goods it asks for in your bags fills it: the
 * goods go in and it becomes a Sealed Crate (602010-602015), which the supply quartermasters take for Merchant's
 * Favor (repeatable quests, data/sql). Temucraft.Crates.DropChance sets how often they drop.
 */

#include "Chat.h"
#include "TemucraftModuleText.h"
#include "Config.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Creature.h"
#include "Item.h"
#include "LootMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

#include <array>
#include <random>
#include <vector>

namespace
{
    struct Crate
    {
        uint32 item;
        uint32 sealed;
        uint32 count;
        std::vector<uint32> goods;
    };

    std::vector<Crate> const CRATES = {
        { 601980, 602010, 20, { 2447, 765, 2449 } },
        { 601981, 602011, 20, { 2450, 2453, 785 } },
        { 601982, 602012, 20, { 3818, 3821, 3358 } },
        { 601983, 602013, 20, { 8838, 13463, 13466 } },
        { 601984, 602014, 20, { 22785, 22786, 22789 } },
        { 601985, 602015, 20, { 36901, 36904, 36903 } },
        { 601986, 602010, 20, { 2770 } },
        { 601987, 602011, 20, { 2771, 2775 } },
        { 601988, 602012, 20, { 2772, 2776 } },
        { 601989, 602013, 20, { 3858, 10620 } },
        { 601990, 602014, 20, { 23424, 23425 } },
        { 601991, 602015, 20, { 36909, 36912 } },
        { 601992, 602010, 10, { 2318 } },
        { 601993, 602011, 10, { 2319 } },
        { 601994, 602012, 10, { 4234 } },
        { 601995, 602013, 10, { 4304, 8170 } },
        { 601996, 602014, 10, { 21887 } },
        { 601997, 602015, 10, { 33568 } },
        { 601998, 602010, 20, { 2589 } },
        { 601999, 602011, 20, { 2592 } },
        { 602000, 602012, 20, { 4306 } },
        { 602001, 602013, 20, { 4338, 14047 } },
        { 602002, 602014, 20, { 21877 } },
        { 602003, 602015, 20, { 33470 } },
    };

    // Tier of each crate: its index modulo 6 (Apprentice, Journeyman, Expert, Artisan, Master, Grand Master)
    std::array<uint8, 6> TIER_CREATURE_LEVEL = { 5, 15, 30, 45, 60, 70 };    // Temucraft.Crates.TierCreatureLevels
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


    struct CrateSettings
    {
        bool enable = true;
        float dropChance = 2.0f;
    } crates;

    std::string ItemName(uint32 entry)
    {
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(entry);
        return proto ? proto->Name1 : std::to_string(entry);
    }
}

class item_temucraft_waylaid_crate : public ItemScript
{
public:
    item_temucraft_waylaid_crate() : ItemScript("item_temucraft_waylaid_crate") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        Crate const* crate = nullptr;
        for (Crate const& c : CRATES)
            if (c.item == item->GetEntry())
                crate = &c;
        if (!crate)
            return true;
        for (uint32 goods : crate->goods)
        {
            if (!player->HasItemCount(goods, crate->count))
                continue;
            ItemPosCountVec dest;
            if (player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, crate->sealed, 1) != EQUIP_ERR_OK)
            {
                ChatHandler(player->GetSession()).SendSysMessage(TemucraftModuleText("mod-temucraft-merchants", player->GetSession(), 1, "|cffff4c4cYour bags are full.|r"));
                return true;
            }
            player->DestroyItemCount(goods, crate->count, true);
            player->DestroyItemCount(item->GetEntry(), 1, true);
            if (Item* sealed = player->StoreNewItem(dest, crate->sealed, true))
                player->SendNewItem(sealed, 1, true, false);
            ChatHandler(player->GetSession()).PSendSysMessage(TemucraftModuleText("mod-temucraft-merchants", player->GetSession(), 2, "|cffffcc00You pack {} x {} into the crate and seal it. A supply "
                "quartermaster will want it.|r"), crate->count, ItemName(goods));
            return true;
        }
        std::string list;
        for (uint32 goods : crate->goods)
            list += (list.empty() ? "" : " or ") + ItemName(goods);
        ChatHandler(player->GetSession()).PSendSysMessage(TemucraftModuleText("mod-temucraft-merchants", player->GetSession(), 3, "|cffffcc00This crate wants {} x {}.|r"), crate->count, list);
        return true;
    }
};

class TemucraftCrates_Player : public PlayerScript
{
public:
    TemucraftCrates_Player() : PlayerScript("TemucraftCrates_Player", { PLAYERHOOK_ON_CREATURE_KILL, PLAYERHOOK_ON_CREATURE_KILLED_BY_PET }) { }

    void OnPlayerCreatureKilledByPet(Player* owner, Creature* killed) override
    {
        OnPlayerCreatureKill(owner, killed);
    }

    void OnPlayerCreatureKill(Player* /*killer*/, Creature* killed) override
    {
        if (!crates.enable || !killed || killed->IsCritter() || killed->IsPet() || killed->IsSummon() ||
            (killed->loot.empty() && !killed->loot.gold))
            return;
        static thread_local std::mt19937 rng{ std::random_device{}() };
        if (std::uniform_real_distribution<float>(0.0f, 100.0f)(rng) >= crates.dropChance)
            return;
        int8 tier = -1;
        for (uint8 i = 0; i < TIER_CREATURE_LEVEL.size(); ++i)
            if (killed->GetLevel() >= TIER_CREATURE_LEVEL[i])
                tier = i;
        if (tier < 0)
            return;
        std::vector<uint32> choices;
        for (size_t i = 0; i < CRATES.size(); ++i)
            if (i % 6 == size_t(tier))
                choices.push_back(CRATES[i].item);
        if (choices.empty())
            return;
        uint32 crate = choices[std::uniform_int_distribution<size_t>(0, choices.size() - 1)(rng)];
        killed->loot.AddItem(LootStoreItem(crate, 0, 100.0f, false, LOOT_MODE_DEFAULT, 0, 1, 1));
    }
};

class TemucraftCrates_World : public WorldScript
{
public:
    TemucraftCrates_World() : WorldScript("TemucraftCrates_World", { WORLDHOOK_ON_AFTER_CONFIG_LOAD }) { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        crates.enable = sConfigMgr->GetOption<bool>("Temucraft.Crates.Enable", true);
        crates.dropChance = sConfigMgr->GetOption<float>("Temucraft.Crates.DropChance", 2.0f);
        ParseLevels(sConfigMgr->GetOption<std::string>("Temucraft.Crates.TierCreatureLevels", "5 15 30 45 60 70"), TIER_CREATURE_LEVEL);
    }
};

void AddTemucraftCratesScripts()
{
    new item_temucraft_waylaid_crate();
    new TemucraftCrates_Player();
    new TemucraftCrates_World();
}
