local ADDON_NAME, ns = ...
local L = ns.L

function ravTodo_OnLoad(self)
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("CHAT_MSG_ADDON")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("CHAT_MSG_CURRENCY")
    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("PLAYER_FLAGS_CHANGED")
    self:RegisterEvent("BOSS_KILL")
    self:RegisterEvent("ENCOUNTER_END")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("MOUNT_JOURNAL_SEARCH_UPDATED")
    self:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
    self:RegisterEvent("NEW_TOY_ADDED")
end

function ravTodo_OnEvent(self, event, arg, ...)
    if event == "PLAYER_LOGIN" then
        ns:SetDefaultOptions()
        ns:ImportData()
        ns:CreateSettingsPanel()
        ns:EnsureMacro()
        ns:CacheAndBuild(function()
            ns:BuildWindow()
            ns:BuildLibData()
            ns:RefreshCurrencies()
            ns:RefreshMobs()
            ns:RefreshItems()
            if ns.waitingForWindow or not RTD_version then
                ns:ToggleWindow(ns.Window, "Show")
            end
        end)
        if not ns.version:match("-") then
            if not RTD_version then
                ns:PrettyPrint(L.Install:format(ns.color, ns.version))
            elseif RTD_version ~= ns.version then
                ns:PrettyPrint(L.Update:format(ns.color, ns.version))
                -- Version-specific messages go here
            end
            RTD_version = ns.version
        end
        C_ChatInfo.RegisterAddonMessagePrefix(ADDON_NAME)
    elseif event == "GROUP_ROSTER_UPDATE" then
        local partyMembers = GetNumSubgroupMembers()
        local raidMembers = IsInRaid() and GetNumGroupMembers() or 0
        if not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and not ns.version:match("-") and RTD_options.share then
            if raidMembers == 0 and partyMembers > ns.data.partyMembers then
                ns:SendVersionUpdate("PARTY")
            elseif raidMembers > ns.data.raidMembers then
                ns:SendVersionUpdate("RAID")
            end
        end
        ns.data.partyMembers = partyMembers
        ns.data.raidMembers = raidMembers
    elseif event == "CHAT_MSG_ADDON" and arg == ADDON_NAME and RTD_options.share then
        local message, channel, sender, _ = ...
        if RTD_options.debug then
            ns:PrettyPrint("\n" .. sender .. " in " .. channel .. "\n" .. message)
        end
        if message:match("V:") and not ns.data.versionUpdateFound then
            local version = message:gsub("V:", "")
            if not version:match("-") then
                local v1, v2, v3 = strsplit(".", version)
                local c1, c2, c3 = strsplit(".", ns.version)
                if v1 > c1 or (v1 == c1 and v2 > c2) or (v1 == c1 and v2 == c2 and v3 > c3) then
                    ns:PrettyPrint(L.UpdateFound:format(version))
                    ns.data.versionUpdateFound = true
                end
            end
        end
    elseif event == "CHAT_MSG_CURRENCY" or event == "CURRENCY_DISPLAY_UPDATE" then
        if ns.Currencies then
            C_Timer.After(1, function()
                ns:RefreshCurrencies()
            end)
        end
    elseif event == "PLAYER_FLAGS_CHANGED" then
        if ns.Warmode then
            C_Timer.After(0, function()
                ns:RefreshWarmode()
            end)
        end
    elseif event == "BOSS_KILL" or event == "ENCOUNTER_END" then
        if ns.Mobs then
            C_Timer.After(1, function()
                ns:RefreshMobs()
            end)
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subtype = CombatLogGetCurrentEventInfo()
        if subtype == "UNIT_DIED" or subtype == "UNIT_DESTROYED" then
            if ns.Mobs then
                C_Timer.After(1, function()
                    ns:RefreshMobs()
                end)
            end
        end
    elseif event == "MOUNT_JOURNAL_SEARCH_UPDATED" or event == "PET_JOURNAL_LIST_UPDATE" or event == "NEW_TOY_ADDED" then
        if ns.Items then
            C_Timer.After(1, function()
                ns:RefreshItems()
                ns:RefreshCounts()
            end)
        end
    end
end

function ravTodo_OnAddonCompartmentClick(addonName, buttonName)
    if buttonName == "RightButton" then
        ns:OpenSettings()
        return
    end
    ns:ToggleWindow(ns.Window)
end

function ravTodo_OnAddonCompartmentEnter()
    GameTooltip:SetOwner(DropDownList1)
    GameTooltip:SetText(ns.name .. "        v" .. ns.version)
    GameTooltip:AddLine(" ", 1, 1, 1, true)
    GameTooltip:AddLine(L.AddonCompartmentTooltip1, 1, 1, 1, true)
    GameTooltip:AddLine(L.AddonCompartmentTooltip2, 1, 1, 1, true)
    GameTooltip:Show()
end

SlashCmdList["RAVTODO"] = function(message)
    if message == "v" or message:match("ver") then
        ns:PrettyPrint(L.Version:format(ns.version))
    elseif message == "c" or message:match("con") or message == "h" or message:match("help") or message == "o" or message:match("opt") or message == "s" or message:match("sett") or message:match("togg") then
        ns:OpenSettings()
    else
        ns:ToggleWindow(ns.Window)
    end
end
SLASH_RAVTODO1 = "/todo"
SLASH_RAVTODO2 = "/ravtodo"
SLASH_RAVTODO3 = "/rtd"
