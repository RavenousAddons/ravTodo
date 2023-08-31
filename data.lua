local _, ns = ...

ns.data = {
    defaults = {
        locked = false,
        macro = true,
        scale = 1,
        windowPosition = "CENTER",
        windowX = 0,
        windowY = 0,
        windowWidth = 420,
        windowHeight = 360,
        minimapButton = true,
        minimapPosition = 0,
        showCollected = false,
        showDefeated = false,
        showIneligible = false,
        showMounts = true,
        showPets = true,
        showToys = true,
        useSilverDragon = true,
        share = true,
        debug = false,
    },
    currencies = {
        ["Honor"] = 1792,
        ["Conquest"] = 1602,
        ["Bloody Tokens"] = 2123,
        ["Seal of Wartorn Fate"] = 1580,
        ["Paracausal Flakes"] = 2594,
        ["Bloody Coin"] = 789,
        ["Tol Barad Commendation"] = 391,
    },
    expansions = {
        {
            name = "Dragonflight",
            color = "d12a60",
        },
        {
            name = "Shadowlands",
            color = "e5cc80",
        },
        {
            name = "BattleForAzeroth",
            title = "Battle for Azeroth",
            color = "5ca0bf",
        },
        {
            name = "Legion",
            color = "aece49",
        },
        {
            name = "Warlords",
            title = "Warlord of Draenor",
            color = "dba53a",
        },
        {
            name = "Mists",
            title = "Mists of Pandaria",
            color = "72aa98",
        },
        {
            name = "Cataclysm",
            color = "e8660a",
        },
        {
            name = "Wrath",
            title = "Wrath of the Lich King",
            color = "afcae6",
        },
        {
            name = "BurningCrusade",
            title = "Burning Crusade",
            color = "accda8",
        },
        {
            name = "Vanilla",
            color = "fff275",
        },
    },
    reputationColors = {
        "cc2222",
        "ff0000",
        "ee6622",
        "ffff00",
        "00ff00",
        "00ff88",
        "00ffcc",
        "00ffff",
        "00ffff",
    },
    notes = {
        ("Check your General Macros for a macro called |cff%1$s%2$s|r, use the Addon compartment button, or type |cff%1$s/%3$s|r to open this main window."):format(ns.color, ns.name, ns.command),
        "Clicking a Mob's name will place a Map Pin on their location, and Alt/Ctrl/Shift-Clicking will share the coordinates with your group.",
        "Clicking an Item will place a link in your chat, and Alt/Ctrl/Shift-Clicking will preview the item in the Dressing Room.",
        "Ravenous Todo is very much a work-in-progress; although, things are progressing quickly. 0.0.5 changes how world boss data is sourced; it now comes from another Addon called SilverDragon, so if you have that AddOn enabled, you'll see the World Boss tab and relevant data there.",
        "I'm still working on fleshing out the Weekly/Daily data manually. My first priority is to track all mount farms and then will pick up pets and toys. Let me know if I'm missing any!",
        "Thanks for your patience as I continue development, and keep your eyes on Curseforge for updates.",
    },
    categories = {
        {
            name = "Weekly",
            icon = 1391676,
            notes = {},
            mobs = {
                -- Dragonflight
                    -- TODO
                -- Shadowlands
                [166945] = {name="Nalthor the Rimebinder",locations={[1533]={40075507}},loot={{181819,mount=1409}},dungeon="The Necrotic Wake",mythic=true,},
                [177269] = {name="So'leah",locations={[1550]={32017602}},loot={{186638,mount=1481}},dungeon="Tazavesh, the Veiled Market",notes="To get there, fly from Oribos.",mythic=true,},
                [175726] = {name="The Nine",locations={[1543]={69683187}},loot={{186656,mount=1500}},raid="Sanctum of Domination",lfr=true,normal=true,heroic=true,mythic=true,},
                [175732] = {name="Sylvanas Windrunner",locations={[1543]={69683187}},loot={{186642,mount=1471}},raid="Sanctum of Domination",mythic=true,},
                [180990] = {name="The Jailer",locations={[1970]={80455329}},loot={{190768,mount=1587}},raid="Sepulcher of the First Ones",mythic=true,},
                -- Battle for Azeroth
                [129440] = {name="Lord Harlan Sweete",locations={[895]={84557872}},loot={{159842,mount=995}},dungeon="Freehold",mythic=true,},
                [136160] = {name="King Dazar",locations={[862]={37513929}},loot={{159921,mount=1040}},dungeon="Kings' Rest",mythic=true,},
                [133007] = {name="Unbound Abomination",locations={[863]={51196456}},loot={{160829,mount=1053}},dungeon="The Underrot",mythic=true,},
                [150190] = {name="HK-8 Aerial Oppression unit",locations={[1462]={72883632}},loot={{168826,mount=1252},{169385,pet=2718}},dungeon="Operation: Mechagon",mythic=true,},
                [150397] = {name="King Mechagon",locations={[1462]={72883632}},loot={{168830,mount=1227}},dungeon="Operation: Mechagon",mythic=true,},
                [133384] = {name="Merektha",locations={[864]={51832528}},loot={{160832,pet=2186}},dungeon="Temple of Sethraliss",mythic=true,},
                [144838] = {name="High Tinker Mekkatorque",locations={[895]={74332832}},loot={{166518,mount=1217}},raid="Battle of Dazar'alor",normal=true,heroic=true,mythic=true,},
                [149684] = {name="Lady Jaina Proudmoore",locations={[895]={74332832}},loot={{166518,mount=1217}},raid="Battle of Dazar'alor",lfr=true,},
                [149685] = {name="Lady Jaina Proudmoore",locations={[895]={74332832}},loot={{166705,mount=1219}},raid="Battle of Dazar'alor",mythic=true,},
                [158041] = {name="N'Zoth the Corruptor",locations={[1530]={38404481}},loot={{174872,mount=1293}},raid="Ny'alotha, the Waking City",mythic=true,},
                -- Legion
                [114262] = {name="Attumen the Huntsman",locations={[42]={47007464}},loot={{142236,mount=875}},dungeon="Return to Karazhan",mythic=true,},
                [114895] = {name="Nightbane",locations={[42]={47007464}},loot={{142552,mount=883}},dungeon="Return to Karazhan",mythic=true,},
                [105503] = {name="Gul'dan",locations={[1191]={43725722}},loot={{137574,mount=791}},raid="The Nighthold",},
                [105504] = {name="Gul'dan",locations={[1191]={43725722}},loot={{137575,mount=633}},raid="The Nighthold",mythic=true,},
                [115767] = {name="Mistress Sassz'ine",locations={[1192]={63952120}},loot={{143643,mount=899}},raid="Tomb of Sargeras",},
                [126916] = {name="F'harg",locations={[885]={54766234}},loot={{152816,mount=971}},raid="Antorus, the Burning Throne",},
                [124828] = {name="Argus the Unmaker",locations={[885]={54766234}},loot={{152789,mount=954}},raid="Antorus, the Burning Throne",},
                -- Warlords of Draenor
                [77325] = {name="Blackhand",locations={[543]={51502706}},loot={{116660,mount=613}},raid="Blackrock Foundry",},
                [91331] = {name="Archimonde",locations={[577]={46955270}},loot={{123890,mount=751}},raid="Hellfire Citadel",},
                -- Mists of Pandaria
                [71865] = {name="Garrosh Hellscream",locations={[390]={73824262}},loot={{104253,mount=559,chance=1.24}},raid="Siege of Orgrimmar",mythic=true,},
                [69712] = {name="Ji-kun",locations={[504]={63793187}},loot={{95059,mount=543,chance=2.69},{94835,pet=1202}},raid="Throne of Thunder",},
                [68476] = {name="Horridon",locations={[504]={63793187}},loot={{93666,mount=531,chance=2.69}},raid="Throne of Thunder",},
                [60410] = {name="Elegon",locations={[379]={59553906}},loot={{87777,mount=478}},raid="Mogu'shan Vaults",heroic=true,},
                -- Cataclysm
                [46753] = {name="Al'Akir",locations={[249]={36008400}},loot={{63041,mount=396}},raid="Throne of the Four Winds",},
                [52530] = {name="Alysrazor",locations={[198]={47007700}},loot={{71665,mount=425}},raid="Firelands",},
                [52409] = {name="Ragnaros",locations={[198]={47007700}},loot={{69224,mount=415,chance=2.09}},raid="Firelands",},
                [55294] = {name="Ultraxion",locations={[75]={65005000}},loot={{78919,mount=445}},raid="Dragon Soul",},
                [56173] = {name="Madness of Deathwing",locations={[75]={65005000}},loot={{77067,mount=442},{77069,mount=444}},raid="Dragon Soul",heroic=true,},
                -- Wrath of the Lich King
                [36597] = {name="The Lich King",locations={[118]={54008500}},loot={{50818,mount=363,chance=1.0}},raid="Icecrown Citadel",heroic=true,},
                [33288] = {name="Yogg-Saron",locations={[120]={41001600}},loot={{45693,mount=304,chance=1.0}},raid="Ulduar",},
                    -- 6 raid mounts
                    -- 2 dungeon mounts
                -- Burning Crusade
                [16152] = {name="Attumen the Huntsman",locations={[42]={47007700}},loot={{30480,mount=168,chance=1.0},},raid="Karazhan",},
                [19622] = {name="Kael'thas Sunstrider",locations={[109]={74006500}},loot={{32458,mount=183,chance=1.7}},raid="The Eye",},
            },
        },
        {
            name = "Daily",
            icon = 609811,
            notes = {},
            mobs = {
                -- Cataclysm
                [43873] = {name="Altairus",locations={[249]={77008400}},loot={{63040,mount=395}},dungeon="The Vortex Pinnacle",},
                [43214] = {name="Slabhide",locations={[207]={47455218}},loot={{63043,mount=397}},dungeon="The Stonecore",},
                [52151] = {name="Bloodlord Mandokir",locations={[50]={72003280}},loot={{68823,mount=410}},dungeon="Zul'Gurub",},
                [52059] = {name="High Priestess Kilnara",locations={[50]={72003280}},loot={{68824,mount=411}},dungeon="Zul'Gurub",},
                -- Wrath of the Lich King
                [32273] = {name="Infinite Corruptor",locations={[71]={65884951}},loot={{43951,mount=248,chance=100}},dungeon="The Culling of Stratholme",notes="Boss appears just before the final boss, Mal'Ganis, after completing the instance in 25 minutes or less.",heroic=true,},
                [26693] = {name="Skadi the Ruthless",locations={[117]={57124633}},loot={{44151,mount=264}},dungeon="Utgarde Pinnacle",notes="Kill adds until you have three harpoons and fire them using the launchers when Skadi is flying in front of them. You can proceed to kill the boss when he is thrown off his drake by three successful hits.",heroic=true,},
                -- Burning Crusade
                [23035] = {name="Anzu",locations={[108]={44606560}},loot={{32768,mount=185}},dungeon="Sethekk Halls",heroic=true,},
                [24664] = {name="Kael'thas Sunstrider",locations={[122]={60903070}},loot={{35513,mount=213}},dungeon="Magisters' Terrace",heroic=true,},
                -- Vanilla
                [45412] = {name="Lord Aurius Rivendare",locations={[22]={43501930}},loot={{13335,mount=69}},dungeon="Stratholme",notes="Can be run multiple times, back-to-back, by resetting the dungeon."},
                [15264] = {name="Anubisath Sentinel",locations={[81]={24278716}},loot={{21218,mount=117},{21321,mount=118},{21324,mount=119},{21323,mount=120},},raid="Temple of Ahn'Qiraj",notes="Can be farmed by entering the raid, killing the first four Anubisath Sentinels (in the entrance area), and then resetting the raid."},
            },
        },
        {
            name = "World Bosses",
            icon = 4672498,
            notes = {},
            mobs = {},
        },
        {
            name = "Vendor",
            icon = 133785,
            notes = {},
            mobs = {
                [85484] = {name="Chester",locations={[407]={51507500}},loot={{116139,toy=true}},vendor=true},
                [14846] = {name="Lhara",locations={[407]={48206950}},loot={{73903,pet=338},{73905,pet=339},{74981,pet=343},{91003,pet=1061},{73764,pet=330},{73765,pet=335}},vendor=true},
                [55305] = {name="Carl Goodup",locations={[407]={49308040}},loot={{73762,pet=336},{164970,pet=2482},{164971,pet=2483},{164969,pet=2484}},vendor=true},
            },
        },
    },
    partyMembers = 0,
    raidMembers = 0,
    updateTimeout = 10,
    versionUpdateFound = false,
    versionUpdateTimeout = 30,
}
