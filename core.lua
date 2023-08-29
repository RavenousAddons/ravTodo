local ADDON_NAME, ns = ...
local L = ns.L

function ravTodo_OnLoad(self)
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("CHAT_MSG_ADDON")
    self:RegisterEvent("CHAT_MSG_CURRENCY")
    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("UPDATE_FACTION")
    self:RegisterEvent("PLAYER_FLAGS_CHANGED")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("MOUNT_JOURNAL_SEARCH_UPDATED")
    self:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
    self:RegisterEvent("NEW_TOY_ADDED")
end

function ravTodo_OnEvent(self, event, arg, ...)
    if event == "PLAYER_LOGIN" then
        ns:SetDefaultOptions()
        ns:CreateSettingsPanel()
        ns:EnsureMacro()
        ns:CacheAndBuild(function()
            ns:BuildWindow()
            -- if ns.waitingForWindow or not RTD_version then
            --     ns:ToggleWindow(ns.Window, "Show")
            -- end
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
    elseif event == "PLAYER_FLAGS_CHANGED" then
        if ns.Warmode then
            ns:RefreshWarmode()
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
