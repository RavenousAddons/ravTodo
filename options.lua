local ADDON_NAME, ns = ...
local L = ns.L

local defaults = ns.data.defaults

local function CreateCheckBox(category, variable, name, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaults[variable]), RTD_options[variable])
    Settings.SetOnValueChangedCallback(variable, function(event)
        RTD_options[variable] = setting:GetValue()
        ns:ToggleWindow(ns.Window, "Hide")
        -- ns:BuildWindow()
    end)
    Settings.CreateCheckBox(category, setting, tooltip)
end

local function CreateDropDown(category, variable, name, options, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaults[variable]), RTD_options[variable])
    Settings.SetOnValueChangedCallback(variable, function(event)
        RTD_options[variable] = setting:GetValue()
        ns:ToggleWindow(ns.Window, "Hide")
        -- ns:BuildWindow()
    end)
    Settings.CreateDropDown(category, setting, options, tooltip)
end

function ns:CreateSettingsPanel()
    local category, layout = Settings.RegisterVerticalLayoutCategory(ns.name)

    -- List Preferences
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("List Preferences"))
    for index = 1, #L.OptionsListPreferences do
        local option = L.OptionsListPreferences[index]
        CreateCheckBox(category, option.key, option.name, option.tooltip)
    end

    -- Final setup
    Settings.RegisterAddOnCategory(category)
    ns.Settings = category
end
