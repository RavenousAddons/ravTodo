local _, ns = ...
local L = {}
ns.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Default (English)
L.Version = "%s is the current version." -- ns.version
L.Install = "Thanks for installing version |cff%1$s%2$s|r!" -- ns.color, ns.version
L.Update = "Thanks for updating to version |cff%1$s%2$s|r!" -- ns.color, ns.version
L.UpdateFound = "Version %s is now available for download. Please update!" -- sentVersion

L.AddonCompartmentTooltip1 = "|cff" .. ns.color .. "Left-Click:|r Open Window"
L.AddonCompartmentTooltip2 = "|cff" .. ns.color .. "Right-Click:|r Settings"
L.NoMacroSpace = "Unfortunately, you don't have enough global macro space for the macro to be created!"

L.CreateMapPin = "Create Map Pin"
L.AddedMapPin = "Added a Map Pin %1$s" -- Map Pin Link

L.HundredDrop = " 100% drop!"

L.WarmodeDisableError = "You must be in any rest area to turn off War Mode."

L.OptionsListPreferences = {
    [1] = {
        key = "showDefeated",
        name = "Show Defeated",
        tooltip = "When enabled, mobs you have already defeated (and their items) will be shown."
    },
    [2] = {
        key = "showCollected",
        name = "Show Collected",
        tooltip = "When enabled, items you have already collected (and their bosses) will be shown."
    },
    [3] = {
        key = "showMounts",
        name = "Show Mounts",
        tooltip = "When enabled, mounts will be included in the items dropped by mobs."
    },
    [4] = {
        key = "showPets",
        name = "Show Pets",
        tooltip = "When enabled, pets will be included in the items dropped by mobs."
    },
    [5] = {
        key = "showToys",
        name = "Show Toys",
        tooltip = "When enabled, toys will be included in the items dropped by mobs."
    },
}

-- Check locale and assign appropriate
local CURRENT_LOCALE = GetLocale()

-- German
if CURRENT_LOCALE == "deDE" then return end

-- Spanish
if CURRENT_LOCALE == "esES" then return end

-- Latin-American Spanish
if CURRENT_LOCALE == "esMX" then return end

-- French
if CURRENT_LOCALE == "frFR" then return end

-- Italian
if CURRENT_LOCALE == "itIT" then return end

-- Brazilian Portuguese
if CURRENT_LOCALE == "ptBR" then return end

-- Russian
if CURRENT_LOCALE == "ruRU" then return end

-- Korean
if CURRENT_LOCALE == "koKR" then return end

-- Simplified Chinese
if CURRENT_LOCALE == "zhCN" then return end

-- Traditional Chinese
if CURRENT_LOCALE == "zhTW" then return end

-- Swedish
if CURRENT_LOCALE == "svSE" then return end
