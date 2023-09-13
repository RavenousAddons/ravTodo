local ADDON_NAME, ns = ...
local L = ns.L

local defaults = ns.data.defaults

local function CreateCheckBox(category, variable, name, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaults[variable]), RTD_options[variable])
    Settings.SetOnValueChangedCallback(variable, function(event)
        RTD_options[variable] = setting:GetValue()
        ns:ToggleWindow(ns.Window, "Hide")
    end)
    Settings.CreateCheckBox(category, setting, tooltip)
end

local function CreateDropDown(category, variable, name, options, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaults[variable]), RTD_options[variable])
    Settings.SetOnValueChangedCallback(variable, function(event)
        RTD_options[variable] = setting:GetValue()
        ns:ToggleWindow(ns.Window, "Hide")
    end)
    Settings.CreateDropDown(category, setting, options, tooltip)
end

function ns:CreateSettingsPanel()
    local category, layout = Settings.RegisterVerticalLayoutCategory(ns.name)

    -- Mob Preferences
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Mob Preferences:"))
    for index = 1, #L.OptionsMobPreferences do
        local option = L.OptionsMobPreferences[index]
        if option.key ~= "useSilverDragon" or (SilverDragon and option.key == "useSilverDragon") then
            CreateCheckBox(category, option.key, option.name, option.tooltip)
        end
    end

    -- Item Preferences
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Item Preferences:"))
    for index = 1, #L.OptionsItemPreferences do
        local option = L.OptionsItemPreferences[index]
        CreateCheckBox(category, option.key, option.name, option.tooltip)
    end

    -- Extra Preferences
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Extra Options:"))
    for index = 1, #L.OptionsExtra do
        local option = L.OptionsExtra[index]
        if option.key ~= "useTomTom" or (TomTom and option.key == "useTomTom") then
            CreateCheckBox(category, option.key, option.name, option.tooltip)
        end
    end

    -- Final setup
    Settings.RegisterAddOnCategory(category)
    ns.Settings = category
end
