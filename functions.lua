local ADDON_NAME, ns = ...
local L = ns.L

-- Simplified API classes
local CQL = C_QuestLog

-- Simplified data lookups
local defaults = ns.data.defaults
local categories = ns.data.categories
local currencies = ns.data.currencies
local notes = ns.data.notes

-- Player information
local _, className = UnitClass("player")
local factionName, _ = UnitFactionGroup("player")
local factionCity = (factionName == "Alliance" and "Stormwind" or "Orgrimmar")

-- Iterators
local iterMob = 0
local iterItem = 0

-- Sizes
local small = 6
local medium = 12
local large = 16
local gigantic = 24

---
-- Local Functions
---

local function commaValue(amount)
    local formatted, i = amount
    while true do
        formatted, i = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if i == 0 then
            break
        end
    end
    return formatted
end

local function contains(table, input)
    for index, value in ipairs(table) do
        if value == input then
            return index
        end
    end
    return false
end

local function TextColor(text, color)
    color = color and color or "eeeeee"
    return "|cff" .. color .. text .. "|r"
end

local function TextIcon(icon, size)
    if not icon then return "" end
    size = size and size or 16
    return "|T" .. icon .. ":" .. size .. "|t"
end

local function Register(Key, Value)
    if not Key or not Value then return end
    ns[Key] = ns[Key] or {}
    table.insert(ns[Key], Value)
end

local function HideTooltip()
    GameTooltip:Hide()
end

local function GetMobQuests(mob)
    if mob.quest then
        if type(mob.quest) == "table" then
            if factionName == "Alliance" and mob.quest.alliance then
                return {mob.quest.alliance}
            elseif factionName == "Horde" and mob.quest.horde then
                return {mob.quest.horde}
            end
            return mob.quest
        end
        return {mob.quest}
    end
    return {}
end

local function GetMobDifficulties(mob)
    local d = {}
    if mob.lfr then
        table.insert(d, "Looking for Raid")
    end
    if mob.normal then
        if type(mob.normal) == "number" then
            table.insert(d, mob.normal .. " Player")
        else
            table.insert(d, "Normal")
        end
    end
    if mob.heroic then
        if type(mob.heroic) == "number" then
            table.insert(d, mob.heroic .. " Player (Heroic)")
        else
            table.insert(d, "Heroic")
        end
    end
    if mob.mythic then
        table.insert(d, "Mythic")
    end
    if mob.timewalking then
        table.insert(d, "Timewalking")
    end
    return d
end

local function IsMobDead(mob, anyQuest, specificDifficulty)
    anyQuest = anyQuest == nil and true or anyQuest
    local quests = GetMobQuests(mob)
    if #quests > 0 then
        -- if ANY quest completion counts as a success
        if anyQuest then
            for _, quest in ipairs(quests) do
                if type(quest) == "number" and CQL.IsQuestFlaggedCompleted(quest) then
                    return true
                end
            end
            return false
        -- if ALL quest completion counts as a success
        else
            for _, quest in ipairs(quests) do
                if type(quest) == "number" and not CQL.IsQuestFlaggedCompleted(quest) then
                    return false
                end
            end
            return true
        end
    end

    if mob.dungeon or mob.raid then
        local size = mob.size and mob.size or mob.raid and 10 or mob.dungeon and 5
        -- If we only want to check one difficulty
        if specificDifficulty then
            for i = 1, GetNumSavedInstances(), 1 do
                local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled = GetSavedInstanceInfo(i)
                if string.match(difficultyName:upper(), specificDifficulty:upper()) then
                    for encounter = 1, numEncounters do
                        local bossName, fileDataID, isKilled, _ = GetSavedInstanceEncounterInfo(i, encounter)
                        if bossName == mob.name then
                            return (locked and isKilled)
                        end
                    end
                end
            end
        else
            local difficulties = GetMobDifficulties(mob)
            -- If specific difficulties are passed, only return true when all are complete
            if #difficulties > 0 then
                local kills = 0
                for _, d in ipairs(difficulties) do
                    for i = 1, GetNumSavedInstances(), 1 do
                        local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled = GetSavedInstanceInfo(i)
                        if string.match(difficultyName:upper(), d:upper()) then
                            for encounter = 1, numEncounters do
                                local bossName, fileDataID, isKilled, _ = GetSavedInstanceEncounterInfo(i, encounter)
                                if bossName == mob.name and locked and isKilled then
                                    kills = kills + 1
                                    break
                                end
                            end
                        end
                    end
                end
                return kills >= #difficulties
            -- Otherwise, any matching mob will be checked
            else
                for i = 1, GetNumSavedInstances(), 1 do
                    local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled = GetSavedInstanceInfo(i)
                    if not mob.difficulties or (mob.difficulties and contains(mob.difficulties, difficulty)) then
                        for encounter = 1, numEncounters do
                            local bossName, fileDataID, isKilled, _ = GetSavedInstanceEncounterInfo(i, encounter)
                            if bossName == mob.name then
                                return (locked and isKilled)
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

local function GetItemID(item)
    return type(item) == "number" and item or item[1]
end

local function IsItemOwned(item)
    item = type(item) == "number" and {item} or item
    if item.mount then
        return select(11, C_MountJournal.GetMountInfoByID(item.mount))
    elseif item.pet then
        return C_PetJournal.GetNumCollectedInfo(item.pet) > 0
    elseif item.toy then
        return PlayerHasToy(GetItemID(item))
    elseif item.quest and type(item.quest) == "number"  then
        return CQL.IsQuestFlaggedCompleted(item.quest)
    elseif item.achievement then
        return select(4, GetAchievementInfo(item.achievement))
    end
    return false
end

local function MobFilter(mob, numItems)
    if mob.hidden or not mob.name or not mob.loot or not mob.locations then
        return false
    end
    if RTD_options.showDefeated == false and IsMobDead(mob) then
        return false
    end
    if RTD_options.showIneligible == false and mob.class and mob.class:upper() ~= className:upper() then
        return false
    end
    if RTD_options.showIneligible == false and mob.faction and mob.faction:upper() ~= factionName:upper() then
        return false
    end
    if numItems == 0 then
        return false
    end
    return true
end

local function ItemFilter(item)
    item = type(item) == "number" and {item} or item
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(GetItemID(item))

    if type(itemLink) ~= "string" then
        return false
    end
    if RTD_options.showCollected == false and IsItemOwned(item) then
        return false
    end
    if RTD_options.showIneligible == false and item.class and item.class:upper() ~= className:upper() then
        return false
    end
    if RTD_options.showIneligible == false and item.faction and item.faction:upper() ~= factionName:upper() then
        return false
    end
    if item.mount == nil and item.pet == nil and item.toy == nil then
        return false
    end
    if RTD_options.showMounts == false and item.mount then
        return false
    end
    if RTD_options.showPets == false and item.pet then
        return false
    end
    if RTD_options.showToys == false and item.toy then
        return false
    end
    return true
end

local function RunsUntil95(chance, bound)
    bound = bound and bound or 300
    for i = 1, bound do
        local percentage = 1 - ((1 - chance / 100) ^ i)
        if percentage > 0.95 then
            return i
        end
    end
    return bound
end

local icons = {
    ["Infinite"] = TextIcon(237286),
    ["Quest"] = TextIcon(132049),
    ["QuestTurnin"] = TextIcon(132048),
    ["QuestIncomplete"] = TextIcon(365195),
    ["Daily"] = TextIcon(368364),
    ["DailyTurnin"] = TextIcon(368577),
    ["LegendaryQuest"] = TextIcon(646980),
    ["LegendaryQuestTurnin"] = TextIcon(646979),
    ["Achievement"] = TextIcon(235415, 20),
    ["Checkmark"] = TextIcon(628564),
    ["Skull"] = TextIcon(137025),
    ["Vendor"] = TextIcon(136452),
    ["Dungeon"] = TextIcon(1502543, 20),
    ["Raid"] = TextIcon(1502548, 20),
}

---
-- Global Functions
---

function ns:SetDefaultOptions()
    if RTD_data == nil then
        RTD_data = {}
    end
    if RTD_options == nil then
        RTD_options = {}
    end
    for option, default in pairs(ns.data.defaults) do
        if RTD_options[option] == nil then
            RTD_options[option] = default
        end
    end
end

function ns:ImportData()
    local SilverDragonMobs = {}
    if SilverDragon and RTD_options.useSilverDragon ~= false then
        for expansion, datasource in pairs(SilverDragon.datasources) do
            for mobID, mob in pairs(datasource) do
                SilverDragonMobs[mobID] = mob
            end
        end
    end
    ns.data.categories[3].mobs = SilverDragonMobs
end

function ns:PrettyPrint(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff" .. ns.color .. ns.name .. "|r " .. message)
end

function ns:OpenSettings()
    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
    Settings.OpenToCategory(ns.Settings:GetID())
end

local hasSeenNoSpaceMessage = false
function ns:EnsureMacro()
    if not UnitAffectingCombat("player") and RTD_options.macro then
        local body = "/" .. ns.command
        local numberOfMacros, _ = GetNumMacros()
        if GetMacroIndexByName(ns.name) > 0 then
            EditMacro(GetMacroIndexByName(ns.name), ns.name, ns.icon, body)
        elseif numberOfMacros < 120 then
            CreateMacro(ns.name, ns.icon, body)
        elseif not hasSeenNoSpaceMessage then
            hasSeenNoSpaceMessage = true
            ns:PrettyPrint(L.NoMacroSpace)
        end
    end
end

function ns:ToggleWindow(frame, force)
    if frame == nil then
        ns:PrettyPrint(_G.LFG_LIST_LOADING)
        ns.waitingForWindow = true
        return
    end
    if (frame:IsVisible() and force ~= "Show") or force == "Hide" then
        frame:Hide()
    else
        frame:Show()
    end
end

---
-- Item Cache Preloader
---

local function CacheItem(i, itemIDs, callback)
    local Item = Item:CreateFromItemID(itemIDs[i])
    Item:ContinueOnItemLoad(function()
        if i < #itemIDs then
            -- Sadly this *must* be rate-limited
            -- 0 = per frame, as fast as we can go
            C_Timer.After(0, function()
                CacheItem(i + 1, itemIDs, callback)
            end)
        else
            callback()
        end
    end)
end

function ns:CacheAndBuild(callback)
    local itemIDs = {}
    local isBehindQuest, isAvailable
    for _, category in ipairs(categories) do
        for mobID, mob in pairs(category.mobs) do
            -- Build list of available loot from the Mob
            local items = {}
            for _, item in ipairs(mob.loot or {}) do
                item = type(item) == "number" and {item} or item
                if ItemFilter(item) then
                    table.insert(items, item)
                end
            end
            if MobFilter(mob, #items) then
                for _, item in ipairs(items) do
                    if ItemFilter(item) then
                        table.insert(itemIDs, GetItemID(item))
                    end
                end
            end
        end
    end
    CacheItem(1, itemIDs, callback)
end

---
-- Waypoints & Sharing
---

function ns:SetWaypoint(zoneID, coordinates, instanceName, share)
    -- Breakdown the waypoint into segments
    local zoneName = C_Map.GetMapInfo(zoneID).name
    local c = {}
    for d in tostring(coordinates):gmatch("[0-9][0-9]") do
        table.insert(c, d)
    end

    -- Add the waypoint to the map and track it
    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(zoneID, "0." .. c[1] .. c[2], "0." .. c[3] .. c[4]))
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)

    if share and (ns.data.raidMembers > 0 or ns.data.partyMembers > 0) and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        local now = GetServerTime()
        if (RTD_data.updateTimeout and RTD_data.updateTimeout > now) then
            ns:PrettyPrint(L.WaitToShare)
            return
        end
        RTD_data.updateTimeout = now + ns.data.updateTimeout

        local message = (instanceName and instanceName .. ", " or "") .. zoneName .. " @ " .. c[1] .. "." .. c[2] .. ", " .. c[3] .. "." .. c[4] .. " " .. C_Map.GetUserWaypointHyperlink()

        if ns.data.raidMembers > 0 then
            SendChatMessage(message, "RAID")
        elseif ns.data.partyMembers > 0 then
            SendChatMessage(message, "PARTY")
        end
    else
        ns:PrettyPrint(L.AddedMapPin:format("|cffffff00|Hworldmap:" .. zoneID .. ":" .. c[1] .. c[2] .. ":" .. c[3] .. c[4] .. "|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a |cffffff00" .. (instanceName and instanceName .. " - " or "") .. zoneName .. " " .. c[1] .. "." .. c[2] .. ", " .. c[3] .. "." .. c[4] .. "|r]|h|r"))
    end
end

function ns:SendVersionUpdate(type)
    local now = GetServerTime()
    if not ns.version:match("-") and (RTD_data.versionUpdateTimeout and RTD_data.versionUpdateTimeout > now) then
        return
    end
    RTD_data.versionUpdateTimeout = now + ns.data.versionUpdateTimeout
    C_ChatInfo.SendAddonMessage(ADDON_NAME, "V:" .. ns.version, type)
end

---
-- Refresher Functions
---

function ns:RefreshCounts()
    ns.MountCount:SetText(TextColor("Character Mounts: " .. ns:GetMountCount()))
    ns.TotalMountCount:SetText(TextColor("Total Mounts: " .. ns:GetMountCount(false)))
    ns.PetCount:SetText(TextColor("Unique Pets: " .. ns:GetPetCount()))
    ns.TotalPetCount:SetText(TextColor("Total Pets: " .. ns:GetPetCount(false)))
    ns.ToyCount:SetText(TextColor("Toys: " .. ns:GetToyCount()))
end

function ns:RefreshCurrencies()
    for _, Currency in ipairs(ns.Currencies) do
        local currency = C_CurrencyInfo.GetCurrencyInfo(Currency.currency)
        local quantity = currency.discovered and currency.quantity or 0
        local max = currency.useTotalEarnedForMaxQty and commaValue(currency.maxQuantity - currency.totalEarned + quantity) or commaValue(currency.maxQuantity)
        local add = Currency.add and Currency.add() or 0

        Currency:SetText(TextIcon(currency.iconFileID) .. " " .. TextColor(currency.name, currency.color or "ffffff") .. "  " .. TextColor(commaValue(quantity + add) .. (currency.maxQuantity >= currency.quantity and " / " .. max or ""), "ffffff"))
    end
end

function ns:RefreshWarmode()
    for _, WarmodeLabel in ipairs(ns.Warmode) do
        WarmodeLabel:SetText(TextColor("Warmode is " .. (C_PvP.IsWarModeDesired() and "|cff66ff66" .. _G.VIDEO_OPTIONS_ENABLED .. "|r" or "|cffff6666" .. _G.VIDEO_OPTIONS_DISABLED .. "|r") .. ".", "ffffff"))
    end
end

function ns:RefreshMobs()
    for _, MobLabel in ipairs(ns.Mobs) do
        local mob = MobLabel.mob
        local size = mob.size and mob.size or ""
        local difficulties = GetMobDifficulties(mob)
        local difficulty = #difficulties > 0 and TextColor(" (" .. table.concat(difficulties, ", "):gsub(" Player", ""):gsub("%(Heroic%)", "Heroic"):gsub("Looking for Raid", "LFR") .. ")") or ""
        local dead = ""
        if #difficulties > 0 then
            for _, d in ipairs(difficulties) do
                dead = dead .. (IsMobDead(mob, true, d) and icons.Checkmark or (mob.biweekly or mob.weekly or mob.fortnightly) and icons.Daily or mob.vendor and icons.Vendor or mob.raid and icons.Raid or mob.dungeon and icons.Dungeon or icons.Skull)
            end
        else
            dead = (IsMobDead(mob) and icons.Checkmark or (mob.biweekly or mob.weekly or mob.fortnightly) and icons.Daily or mob.vendor and icons.Vendor or mob.raid and icons.Raid or mob.dungeon and icons.Dungeon or icons.Skull)
        end
        local variant = mob.variant and " (" .. mob.variant .. ")" or ""
        local instance = TextColor(mob.raid or mob.dungeon or MobLabel.zoneName)
        local drops = mob.vendor and "sells" or "drops"
        local mobClass = mob.class and "|c" .. select(4, GetClassColor(string.gsub(mob.class, "%s+", ""):upper())) .. mob.class .. "|r" or nil
        local classOnly = mob.class and TextColor(L.OnlyFor, "bbbbbb") .. mobClass or ""
        local mobFaction = mob.faction and "|cff" .. (mob.faction == "Alliance" and "0078ff" or "b30000") .. mob.faction .. "|r" or nil
        local factionOnly = mobFaction and TextColor(L.OnlyFor, "bbbbbb") .. mobFaction or ""
        local mobControl = mob.control and "|cff" .. (mob.control == "Alliance" and "0078ff" or "b30000") .. mob.control .. "|r" or nil
        local controlRequired = mobControl and TextColor(string.format(L.ZoneControl, mobControl)) or ""

        MobLabel:SetText(dead .. " " .. TextColor(MobLabel.i .. ". ") .. mob.name .. variant .. TextColor(" in ", "bbbbbb") .. instance .. difficulty .. controlRequired .. factionOnly .. classOnly .. " " .. TextColor(drops .. ":", "bbbbbb"))
    end
end

function ns:RefreshItems()
    for _, ItemLabel in ipairs(ns.Items) do
        local item = type(ItemLabel.item) == "number" and {ItemLabel.item} or ItemLabel.item

        local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(GetItemID(item))

        if type(itemLink) == "string" then
            local achievement = item.achievement and " from " .. GetAchievementLink(item.achievement) or ""
            local chance = item.chance and TextColor(" (" .. item.chance .. "%)", "bbbbbb") or ""
            local itemClass = item.class and "|c" .. select(4, GetClassColor(string.gsub(item.class, "%s+", ""):upper())) .. item.class .. "|r" or nil
            local classOnly = item.class and TextColor(L.OnlyFor, "bbbbbb") .. itemClass or ""
            local itemFaction = item.faction and "|cff" .. (item.faction == "Alliance" and "0078ff" or "b30000") .. item.faction .. "|r" or nil
            local factionOnly = itemFaction and TextColor(L.OnlyFor, "bbbbbb") .. itemFaction or ""
            local guaranteed = item.guaranteed and TextColor(L.HundredDrop) or ""
            local owned = IsItemOwned(item) and "  " .. icons.Checkmark or ""

            ItemLabel:SetText("    " .. TextIcon(itemTexture) .. "  " .. itemLink .. guaranteed .. achievement .. factionOnly .. classOnly .. owned .. chance)
        end

    end
end

function ns:GetMountCount(charOnly)
    charOnly = charOnly == nil and true or charOnly
    local count = 0
    for _, mountID in pairs(C_MountJournal.GetMountIDs()) do
        local mountName, _, _, _, isUsable, _, isFavorite, isFactionSpecific, mountFaction, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if isCollected and (not charOnly or (charOnly and not hideOnChar and (not isFactionSpecific or ((mountFaction == 0 and factionName == "Horde") or (mountFaction == 1 and factionName == "Alliance"))))) then
            count = count + 1
        end
    end
    return count
end

function ns:GetPetCount(unique)
    return "work-in-progress"
    -- unique = unique == nil and true or unique
    -- local count = 0
    -- for i = 1, 3000 do
    --     local numCollected, limit = C_PetJournal.GetNumCollectedInfo(i)
    --     if numCollected ~= nil and numCollected > 1 then
    --         count = count + (unique and 1 or numCollected)
    --     end
    -- end
    -- return count
end

function ns:GetToyCount()
    return "work-in-progress"
end

---
-- Window Functions
---

local function CreateSpacer(Parent, Relative, size)
    size = size and size or gigantic

    local Spacer = CreateFrame("Frame", nil, Parent)
    Spacer:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT")
    Spacer:SetWidth(Parent:GetWidth())
    Spacer:SetHeight(size)

    return Spacer
end

local function CreateScroller(cfg)
    local Scroller = CreateFrame("ScrollFrame", ADDON_NAME .. "Scroller" .. string.gsub(cfg.label, "%s+", ""), cfg.parent, "UIPanelScrollFrameTemplate")
    Scroller:SetPoint("BOTTOMRIGHT", cfg.parent, "BOTTOMRIGHT", -28, 8)
    Scroller:SetWidth(cfg.width)
    Scroller:SetHeight(cfg.height)
    Scroller.title = cfg.label
    Scroller:Hide()

    local Content = CreateFrame("Frame", ADDON_NAME .. "Scroller" .. string.gsub(cfg.label, "%s+", "") .. "Content", Scroller)
    Content:SetWidth(cfg.width)
    Content:SetHeight(1)
    Content.offset = -large
    Scroller.Content = Content

    Scroller:SetScrollChild(Content)
    Scroller:SetScript("OnShow", function()
        Scroller:SetScrollChild(Content)
    end)

    return Scroller
end

local function CreateTab(cfg)
    local Tab = CreateFrame("Button", ADDON_NAME .. "Tab" .. string.gsub(cfg.label, "%s+", ""), cfg.parent)
    Tab:SetPoint("TOPLEFT", cfg.relativeTo, cfg.relativePoint, cfg.x, cfg.y)
    Tab:SetWidth(48)
    Tab:SetHeight(48)
    Tab:EnableMouse(true)
    Tab.title = cfg.label

    local TabBackground = Tab:CreateTexture(nil, "BACKGROUND")
    TabBackground:SetAllPoints()
    TabBackground:SetTexture(132074)
    TabBackground:SetDesaturated(1)

    local TabIcon = Tab:CreateTexture(nil, "ARTWORK")
    TabIcon:SetWidth(Tab:GetWidth() * 0.6)
    TabIcon:SetHeight(Tab:GetHeight() * 0.6)
    TabIcon:SetPoint("LEFT", Tab, "LEFT", 0, 5)
    TabIcon:SetTexture(cfg.icon)

    Tab:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT")
        GameTooltip:SetText(TextColor(cfg.label))
        GameTooltip:Show()
        TabBackground:SetDesaturated(nil)
    end)
    Tab:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        TabBackground:SetDesaturated(1)
    end)

    return Tab
end

function ns:CreateNotes(Parent, Relative, notes, indent)
    notes = type(notes) == "string" and {notes} or notes
    indent = indent and indent or ""
    for i, note in ipairs(notes) do
        local Note = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        Note:SetJustifyH("LEFT")
        Note:SetText(indent .. TextColor(note))
        Note:SetWidth(Parent:GetWidth())
        Note:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -medium-(Relative.offset or 0))
        Relative = Note
    end

    return Relative
end

function ns:CreatePVP(Parent, Relative)
    local PVP = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    PVP:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -gigantic-(Relative.offset or 0))
    PVP:SetJustifyH("LEFT")
    PVP:SetText(icons.Skull .. "  " .. TextColor("PVP", "f5c87a"))
    Relative = PVP
    Relative.offset = medium
    local LittleRelative = PVP

    local Warmode = CreateFrame("Button", ADDON_NAME .. "Warmode", Parent)
    local WarmodeLabel = Warmode:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    WarmodeLabel:SetPoint("LEFT", LittleRelative, "RIGHT", gigantic, 0)
    WarmodeLabel:SetJustifyH("LEFT")
    Relative.offset = Relative.offset + large
    LittleRelative = WarmodeLabel
    Warmode:SetAllPoints(WarmodeLabel)
    Warmode:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT")
        GameTooltip:SetText(TextColor((C_PvP.IsWarModeDesired() and "|cffff6666Disable|r" or "|cff66ff66Enable|r") .. " War Mode"))
        GameTooltip:Show()
    end)
    Warmode:SetScript("OnClick", function()
        if C_PvP.CanToggleWarMode(not C_PvP.IsWarModeDesired()) then
            C_PvP.ToggleWarMode()
            HideTooltip()
        elseif C_PvP.IsWarModeDesired() then
            RaidNotice_AddMessage(RaidBossEmoteFrame, L.WarmodeDisableError, ChatTypeInfo["RAID_WARNING"])
        else
            RaidNotice_AddMessage(RaidBossEmoteFrame, factionName == "Alliance" and PVP_WAR_MODE_NOT_NOW_ALLIANCE or PVP_WAR_MODE_NOT_NOW_HORDE, ChatTypeInfo["RAID_WARNING"])
        end
    end)
    Warmode:SetScript("OnLeave", HideTooltip)
    WarmodeLabel.anchor = Warmode
    Register("Warmode", WarmodeLabel)
    ns:RefreshWarmode()

    for _, currency in ipairs({"Honor", "Conquest", "Bloody Tokens", "Bloody Coin"}) do
        local Currency = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        Currency:SetPoint("TOPLEFT", LittleRelative, "BOTTOMLEFT", 0, -medium)
        Currency:SetJustifyH("LEFT")
        Currency.currency = currencies[currency]
        Register("Currencies", Currency)
        Relative.offset = Relative.offset + large
        LittleRelative = Currency
    end

    return Relative
end

---
-- Data Process & Print Functions
---

function ns:CreateMob(Parent, Relative, mobID, mob)
    -- Build list of available loot from the Mob
    local items = {}
    for _, item in ipairs(mob.loot or {}) do
        item = type(item) == "number" and {item} or item
        if ItemFilter(item) then
            table.insert(items, item)
        end
    end

    if MobFilter(mob, #items) then
        iterMob = iterMob + 1

        local zoneID, coordinates
        for z, c in pairs(mob.locations) do
            zoneID = z
            coordinates = c[1]
            break
        end
        local zoneName = C_Map.GetMapInfo(zoneID).name
        local c = {}
        for d in tostring(coordinates):gmatch("[0-9][0-9]") do
            table.insert(c, d)
        end

        local Mob = CreateFrame("Button", ADDON_NAME .. "Mob" .. mobID, Parent)
        local MobLabel = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        MobLabel:SetJustifyH("LEFT")
        MobLabel:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -gigantic-(Relative.offset or 0))
        MobLabel:SetWidth(Parent:GetWidth())
        Mob:SetAllPoints(MobLabel)
        Mob:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:SetText(TextColor(L.CreateMapPin .. ":"))
            GameTooltip:AddLine(mob.name .. (IsMobDead(mob) and TextColor(" (" .. _G.DUNGEON_ENCOUNTER_DEFEATED .. ")", "ff0000") or ""))
            if mob.raid or mob.dungeon then
                GameTooltip:AddLine(TextColor(mob.raid or mob.dungeon))
            end
            GameTooltip:AddLine(TextColor(zoneName) .. " " .. c[1] .. "." .. c[2] .. ", " .. c[3] .. "." .. c[4])
            if mob.biweekly then
                GameTooltip:AddLine("Bi-weekly")
            elseif mob.weekly then
                GameTooltip:AddLine("Weekly")
            elseif mob.fortnightly then
                GameTooltip:AddLine("Fortnightly")
            elseif mob.achievement then
                GameTooltip:AddLine("Achievement-based")
            end
            GameTooltip:Show()
        end)
        Mob:SetScript("OnLeave", HideTooltip)
        Mob:SetScript("OnClick", function()
            if RTD_options.share and (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown()) then
                ns:SetWaypoint(zoneID, coordinates, (mob.raid or mob.dungeon), true)
            else
                ns:SetWaypoint(zoneID, coordinates, (mob.raid or mob.dungeon))
            end
        end)
        MobLabel.anchor = Mob
        MobLabel.mob = mob
        MobLabel.zoneName = zoneName
        MobLabel.i = iterMob
        Register("Mobs", MobLabel)
        Relative = Mob

        if mob.notes then
            Relative = ns:CreateNotes(Parent, Relative, mob.notes, "    ")
        end

        -- Iterate over Mob's Loot
        iterItem = 0
        for _, item in ipairs(items) do
            Relative = ns:CreateItem(Parent, Relative, item)
        end
    end

    return Relative
end

function ns:CreateItem(Parent, Relative, item)
    iterItem = iterItem + 1
    item = type(item) == "number" and {item} or item

    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(GetItemID(item))

    local Item = CreateFrame("Button", ADDON_NAME .. "Item" .. GetItemID(item), Parent)
    local ItemLabel = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ItemLabel:SetJustifyH("LEFT")
    ItemLabel:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -medium-(Relative.offset or 0))
    ItemLabel:SetWidth(Parent:GetWidth())
    Item:SetAllPoints(ItemLabel)
    Item:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT", 0, 0)
        GameTooltip:SetHyperlink(itemLink)
        GameTooltip:Show()
    end)
    Item:SetScript("OnLeave", HideTooltip)
    Item:SetScript("OnClick", function()
        if IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown() then
            DressUpLink(itemLink)
        else
            -- TODO refactor to open Journal instead of just printing
            ns:PrettyPrint(itemLink)
        end
    end)
    ItemLabel.anchor = Item
    ItemLabel.item = item
    ItemLabel.i = iterItem
    Register("Items", ItemLabel)
    Relative = ItemLabel

    if item.notes then
        Relative = ns:CreateNotes(Parent, Relative, item.notes, "    ")
    end

    return Relative
end

---
-- Global Window
---

function ns:BuildWindow()
    local Scrollers = {}
    local Tabs = {}
    local Tab, Scoller, Parent, Relative, LittleRelative, Spacer, previousTab

    -- Setup the window
    local Window = CreateFrame("Frame", ADDON_NAME .. "Window", UIParent, "UIPanelDialogTemplate")
    Window:SetWidth(RTD_options.windowWidth)
    Window:SetHeight(RTD_options.windowHeight)
    Window:SetScale(RTD_options.scale)
    Window:SetPoint(RTD_options.windowPosition, RTD_options.windowX, RTD_options.windowY)
    Window:EnableMouse(true)
    Window:SetMovable(true)
    Window:SetClampedToScreen(true)
    Window:RegisterForDrag("LeftButton")
    Window:Hide()
    Window:SetScript("OnShow", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
    end)
    Window:SetScript("OnHide", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
    end)
    table.insert(UISpecialFrames, Window:GetName())
    ns.Window = Window

    -- Make it moveable
    local function WindowInteractionStart(self, button)
        if button == "LeftButton" and not RTD_options.locked then
            Window:StartMoving()
            Window.isMoving = true
            Window.hasMoved = false
        end
    end
    local function WindowInteractionEnd(self)
        if Window.isMoving then
            Window:StopMovingOrSizing()
            Window.isMoving = false
            Window.hasMoved = true
            local point, _, _, x, y = Window:GetPoint()
            RTD_options.windowPosition = point
            RTD_options.windowX = x
            RTD_options.windowY = y
        end
    end
    Window:SetScript("OnMouseDown", WindowInteractionStart)
    Window:SetScript("OnMouseUp", WindowInteractionEnd)

    -- Add the heading
    local Heading = Window:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    Heading:SetPoint("TOP", Window, "TOP")
    Heading:SetPoint("BOTTOM", Window, "TOP", 0, -30)
    Heading:SetText(TextColor(ns.name, ns.color) .. TextColor(" v" .. ns.version))

    -- Attach a lock button and handler
    local LockButton = CreateFrame("Button", ADDON_NAME .. "LockButton", Window, "UIPanelButtonTemplate")
    LockButton:SetPoint("TOPLEFT", Window, "TOPLEFT", 9, -small)
    LockButton:SetWidth(18)
    LockButton:SetHeight(18)
    LockButton:RegisterForClicks("LeftButtonUp")
    LockButton:SetScript("OnMouseDown", function(self, button)
        RTD_options.locked = not RTD_options.locked
        GameTooltip:SetText(TextColor(RTD_options.locked and "Unlock Window" or "Lock Window"))
    end)
    LockButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT")
        GameTooltip:SetText(TextColor(RTD_options.locked and "Unlock Window" or "Lock Window"))
        GameTooltip:Show()
    end)
    LockButton:SetScript("OnLeave", HideTooltip)
    local LockButtonIcon = LockButton:CreateTexture()
    LockButtonIcon:SetAllPoints(LockButton)
    LockButtonIcon:SetTexture(130944)

    -- Attach an options button and handler
    local OptionsButton = CreateFrame("Button", ADDON_NAME .. "OptionsButton", Window, "UIPanelButtonTemplate")
    OptionsButton:SetPoint("TOPLEFT", LockButton, "TOPRIGHT", 2, 0)
    OptionsButton:SetWidth(18)
    OptionsButton:SetHeight(18)
    OptionsButton:RegisterForClicks("LeftButtonUp")
    OptionsButton:SetScript("OnMouseDown", function(self, button)
        ns:OpenSettings()
    end)
    OptionsButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self or UIParent, "ANCHOR_RIGHT")
        GameTooltip:SetText(TextColor("Open Interface Options"))
        GameTooltip:Show()
    end)
    OptionsButton:SetScript("OnLeave", HideTooltip)
    local OptionsButtonIcon = OptionsButton:CreateTexture()
    OptionsButtonIcon:SetAllPoints(OptionsButton)
    OptionsButtonIcon:SetTexture(134063)

    -- TODO Get the resizer attached to Window + Events
    -- local Resizer = CreateFrame("Button", ADDON_NAME .. "Resizer", Window)
    -- Icon/Texture to use: 386862

    -- Create the General Tab/Scroller
    Scroller = CreateScroller({
        label = "General",
        parent = Window,
        width = Window:GetWidth() - 42,
        height = Window:GetHeight() - Heading:GetHeight() - 6,
        current = true,
    })
    Scroller:Show()
    Scrollers["General"] = Scroller
    Tab = CreateTab({
        label = "General",
        icon = ns.icon,
        parent = Window,
        relativeTo = Window,
        relativePoint = "TOPRIGHT",
        x = -3,
        y = -Heading:GetHeight(),
        current = true,
    })
    Tabs["General"] = Tab
    previousTab = Tab

    -- Create Tabs/Scrollers per category
    for _, category in ipairs(categories) do
        if next(category.mobs) ~= nil then
            Scroller = CreateScroller({
                label = category.name,
                parent = Window,
                width = Window:GetWidth() - 42,
                height = Window:GetHeight() - Heading:GetHeight() - 6,
            })
            Scrollers[category.name] = Scroller
            Tab = CreateTab({
                label = category.name,
                icon = category.icon,
                parent = Window,
                relativeTo = previousTab,
                relativePoint = "BOTTOMLEFT",
                x = 0,
                y = 0,
            })
            Tabs[category.name] = Tab
            previousTab = Tab
        end
    end

    -- Create the Help Tab/Scroller
    Scroller = CreateScroller({
        label = "Help",
        parent = Window,
        width = Window:GetWidth() - 42,
        height = Window:GetHeight() - Heading:GetHeight() - 6,
    })
    Scrollers["Help"] = Scroller
    Tab = CreateTab({
        label = "Usage & Info",
        icon = 134400,
        parent = Window,
        relativeTo = previousTab,
        relativePoint = "BOTTOMLEFT",
        x = 0,
        y = 0,
    })
    Tabs["Help"] = Tab
    previousTab = Tab

    -- Link Tabs and Scrollers
    for title, Tab in pairs(Tabs) do
        Tab:SetScript("OnClick", function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            for lookup, Scroller in pairs(Scrollers) do
                if title == lookup then
                    Scroller:Show()
                else
                    Scroller:Hide()
                end
            end
        end)
    end

    -- General Content Setup
    Parent = Scrollers["General"].Content
    Relative = Parent

    -- General Heading
    local GeneralHeading = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    GeneralHeading:SetJustifyH("LEFT")
    GeneralHeading:SetText(TextColor(TextIcon(ns.icon) .. "  " .. "Welcome!"))
    GeneralHeading:SetPoint("TOPLEFT", Relative, "TOPLEFT", 0, -gigantic-(Relative.offset or 0))
    Relative = GeneralHeading

    -- Collection Counts
    local MountCount = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    MountCount:SetJustifyH("LEFT")
    MountCount:SetPoint("TOPLEFT", Relative, "TOPLEFT", 0, -gigantic*2)
    Relative = MountCount
    ns.MountCount = MountCount

    local TotalMountCount = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    TotalMountCount:SetJustifyH("LEFT")
    TotalMountCount:SetPoint("TOPLEFT", Relative, "TOPLEFT", 0, -gigantic)
    Relative = TotalMountCount
    ns.TotalMountCount = TotalMountCount

    local PetCount = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    PetCount:SetJustifyH("LEFT")
    PetCount:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -medium)
    Relative = PetCount
    ns.PetCount = PetCount

    local TotalPetCount = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    TotalPetCount:SetJustifyH("LEFT")
    TotalPetCount:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -medium)
    Relative = TotalPetCount
    ns.TotalPetCount = TotalPetCount

    local ToyCount = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ToyCount:SetJustifyH("LEFT")
    ToyCount:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -medium)
    Relative = ToyCount
    ns.ToyCount = ToyCount

    ns:RefreshCounts()

    -- Spacer
    Spacer = CreateSpacer(Parent, Relative)

    -- PVP
    local PVP = ns:CreatePVP(Parent, Relative)
    Relative = PVP

    -- Currencies
    local Currencies = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    Currencies:SetPoint("TOPLEFT", Relative, "BOTTOMLEFT", 0, -gigantic-medium-(Relative.offset or 0))
    Currencies:SetJustifyH("LEFT")
    Currencies:SetText(icons.Vendor .. "  " .. TextColor("Currencies"))
    Relative = Currencies
    Relative.offset = medium
    LittleRelative = Currencies

    local Currency
    for i, currency in ipairs({"Seal of Wartorn Fate", "Paracausal Flakes", "Darkmoon Prize Ticket", "Tol Barad Commendation"}) do
        Currency = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        if i > 1 then
            Currency:SetPoint("TOPLEFT", LittleRelative, "BOTTOMLEFT", 0, -medium)
        else
            Currency:SetPoint("LEFT", LittleRelative, "RIGHT", gigantic, 0)
        end
        Currency:SetJustifyH("LEFT")
        Currency.currency = currencies[currency]
        Register("Currencies", Currency)
        Relative.offset = Relative.offset + large
        LittleRelative = Currency
    end

    -- Spacer
    Spacer = CreateSpacer(Parent, LittleRelative, large)

    -- Category Content
    local CategoryHeading, mobIDs
    for _, category in ipairs(categories) do
        if next(category.mobs) ~= nil then
            -- Category Content Setup
            Parent = Scrollers[category.name].Content
            Relative = Parent

            -- Category Heading
            CategoryHeading = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
            CategoryHeading:SetJustifyH("LEFT")
            CategoryHeading:SetText(TextIcon(category.icon) .. "  " .. TextColor(category.name))
            CategoryHeading:SetPoint("TOPLEFT", Relative, "TOPLEFT", 0, -gigantic-(Relative.offset or 0))
            Relative = CategoryHeading

            -- Category Notes
            if (category.notes) then
                Relative = ns:CreateNotes(Parent, Relative, category.notes)
            end

            -- Sort & Iterate Mobs in the Category
            mobIDs = {}
            for mobID in pairs(category.mobs) do table.insert(mobIDs, mobID) end
            table.sort(mobIDs)
            iterMob = 0
            for _, mobID in ipairs(mobIDs) do
                Relative = ns:CreateMob(Parent, Relative, mobID, category.mobs[mobID])
                Spacer = CreateSpacer(Parent, Relative)
            end
        end
    end

    -- Help Content Setup
    Parent = Scrollers["Help"].Content
    Relative = Parent

    -- Help Heading
    local HelpHeading = Parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    HelpHeading:SetJustifyH("LEFT")
    HelpHeading:SetText(TextColor(TextIcon(134400) .. "  " .. "Usage & Info"))
    HelpHeading:SetPoint("TOPLEFT", Relative, "TOPLEFT", 0, -gigantic-(Relative.offset or 0))
    Relative = HelpHeading

    -- Help Notes
    local HelpNotes = ns:CreateNotes(Parent, Relative, notes)
    Relative = HelpNotes

    -- Spacer
    Spacer = CreateSpacer(Parent, Relative)

    -- Set Text and Tooltips
    ns:RefreshCurrencies()
    ns:RefreshMobs()
    ns:RefreshItems()
end
