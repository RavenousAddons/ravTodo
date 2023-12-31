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
        useTomTom = true,
        share = true,
        debug = false,
    },
    expansions = {
        ["Dragonflight"] = {
            color = "d12a60",
        },
        ["Shadowlands"] = {
            color = "e5cc80",
        },
        ["BattleForAzeroth"] = {
            color = "5ca0bf",
        },
        ["Legion"] = {
            color = "aece49",
        },
        ["Warlords"] = {
            color = "dba53a",
        },
        ["Mists"] = {
            color = "72aa98",
        },
        ["Cataclysm"] = {
            color = "e8660a",
        },
        ["Wrath"] = {
            color = "afcae6",
        },
        ["BurningCrusade"] = {
            color = "accda8",
        },
        ["Vanilla"] = {
            color = "fff275",
        },
    },
    currencies = {
        -- PVP
        ["Honor"] = {
            id = 1792,
            zoneID = 2112,
            coordinates = 44753684,
        },
        ["Conquest"] = {
            id = 1602,
            zoneID = 2112,
            coordinates = 44323653,
        },
        ["Bloody Tokens"] = {
            id = 2123,
            zoneID = 2112,
            source = "Dragonflight",
            coordinates = 43364253,
        },
        ["Bloody Coin"] = {
            id = 789,
            source = "Mists",
            zoneID = 554,
            coordinates = 75004480,
        },
        -- MoP Bonus Rolls
        ["Elder Charm of Good Fortune"] = {
            id = 697,
            source = "Mists",
            zoneID = 388,
            coordinates = 378066460,
            note = "Galleon, Sha of Anger",
        },
        ["Mogu Rune of Fate"] = {
            id = 752,
            source = "Mists",
            zoneID = 554,
            coordinates = 42805560,
            note = "Throne of Thunder|nNalak, Oondasta",
        },
        ["Warforged Seal"] = {
            id = 776,
            source = "Mists",
            zoneID = 390,
            coordinates = 85206260,
            note = "Siege of Orgrimmar|nChi-Ji, Xuen, Yu'lon, Niuzao, Ordos",
        },
        -- WoD Bonus Rolls
        ["Seal of Tempered Fate"] = {
            id = 994,
            source = "Warlords",
        },
        ["Seal of Inevitable Fate"] = {
            id = 1129,
            source = "Warlords",
            note = "Shadow-Lord Iskar",
        },
        -- Legion Bonus Roll
        ["Seal of Broken Fate"] = {
            id = 1273,
            source = "Legion",
            zoneID = 619,
            coordinates = 46176542,
        },
        -- BfA Bonus Roll
        ["Seal of Wartorn Fate"] = {
            id = 1580,
            source = "BattleForAzeroth",
            zoneID = {
                ["Alliance"] = 1161,
                ["Horde"] = 1165,
            },
            coordinates = {
                ["Alliance"] = 71571365,
                ["Horde"] = 54008840,
            },
        },
        -- Other
        ["Paracausal Flakes"] = {
            id = 2594,
        },
        ["Darkmoon Prize Ticket"] = {
            id = 515,
        },
        ["Tol Barad Commendation"] = {
            id = 391,
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
    difficultyIDs = {
        ["Looking for Raid"] = {},
        ["Normal"] = {1, 3, 4, 12, 14, 38, 147, 150},
        ["Heroic"] = {2, 5, 6, 11, 15, 39, 149},
        ["Mythic"] = {8, 16, 23, 40},
        ["Looking for Raid"] = {},
        ["Timewalking"] = {24, 33},
    },
    difficulties = {
        raid = {
            ["Normal"] = 14,
            ["Heroic"] = 15,
            ["Mythic"] = 16,
            ["Looking for Raid"] = 17,
            ["Timewalking"] = 33,
        },
        dungeon = {
            ["Normal"] = 1,
            ["Heroic"] = 2,
            ["Mythic"] = 23,
            ["Timewalking"] = 24,
        },
    },
    notes = {
        ("Check your General Macros for a macro called |cff%1$s%2$s|r, use the Addon compartment button, or type |cff%1$s/%3$s|r to open this main window."):format(ns.color, ns.name, ns.command),
        "Clicking a Mob's name will place a Map Pin on their location, and Alt/Ctrl/Shift-Clicking will share the coordinates with your group.",
        "Clicking an Item will place a link in your chat, and Alt/Ctrl/Shift-Clicking will preview the item in the Dressing Room.",
        "Notes on development:",
        "The last few versions have mainly been about fixing bugs and correcting/bettering certain pieces of data.",
        "If you have suggestions or corrections, I'd appreciate if you could get in touch through GitHub or Curse. You can even reach out to me in game at WaldenPond#11608.",
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
                [166945] = {name="Nalthor the Rimebinder",source="Shadowlands",locations={[1533]={40075507}},loot={{181819,mount=1409}},dungeon="The Necrotic Wake",mythic=true,},
                [177269] = {name="So'leah",source="Shadowlands",locations={[1550]={32017602}},loot={{186638,mount=1481}},dungeon="Tazavesh, the Veiled Market",notes="To get there, fly from Oribos.",mythic=true,},
                [175726] = {name="The Nine",source="Shadowlands",locations={[1543]={69683187}},loot={{186656,mount=1500}},raid="Sanctum of Domination",lfr=true,normal=true,heroic=true,mythic=true,},
                [175732] = {name="Sylvanas Windrunner",source="Shadowlands",locations={[1543]={69683187}},loot={{186642,mount=1471}},raid="Sanctum of Domination",mythic=true,},
                [180990] = {name="The Jailer",source="Shadowlands",locations={[1970]={80455329}},loot={{190768,mount=1587}},raid="Sepulcher of the First Ones",mythic=true,},
                -- Battle for Azeroth
                [129440] = {name="Lord Harlan Sweete",source="BattleForAzeroth",locations={[895]={84557872}},loot={{159842,mount=995}},dungeon="Freehold",mythic=true,},
                [136160] = {name="King Dazar",source="BattleForAzeroth",locations={[862]={37513929}},loot={{159921,mount=1040}},dungeon="Kings' Rest",mythic=true,},
                [133007] = {name="Unbound Abomination",source="BattleForAzeroth",locations={[863]={51196456}},loot={{160829,mount=1053}},dungeon="The Underrot",mythic=true,},
                [150190] = {name="HK-8 Aerial Oppression Unit",source="BattleForAzeroth",locations={[1462]={72883632}},loot={{168826,mount=1252},{169385,pet=2718}},dungeon="Operation: Mechagon",mythic=true,},
                [150397] = {name="King Mechagon",source="BattleForAzeroth",locations={[1462]={72883632}},loot={{168830,mount=1227}},dungeon="Operation: Mechagon",mythic=true,},
                [133384] = {name="Merektha",source="BattleForAzeroth",locations={[864]={51832528}},loot={{160832,pet=2186}},dungeon="Temple of Sethraliss",mythic=true,},
                [144838] = {name="High Tinker Mekkatorque",source="BattleForAzeroth",locations={[895]={74332832}},loot={{166518,mount=1217}},raid="Battle of Dazar'alor",normal=true,heroic=true,mythic=true,},
                [149684] = {name="Lady Jaina Proudmoore",source="BattleForAzeroth",locations={[895]={74332832}},loot={{166518,mount=1217}},raid="Battle of Dazar'alor",lfr=true,},
                [149685] = {name="Lady Jaina Proudmoore",source="BattleForAzeroth",locations={[895]={74332832}},loot={{166705,mount=1219}},raid="Battle of Dazar'alor",mythic=true,},
                [158041] = {name="N'Zoth the Corruptor",source="BattleForAzeroth",locations={[1530]={38404481}},loot={{174872,mount=1293}},raid="Ny'alotha, the Waking City",mythic=true,},
                -- Legion
                [114262] = {name="Attumen the Huntsman",source="Legion",locations={[42]={46737018}},loot={{142236,mount=875}},dungeon="Return to Karazhan",mythic=true,},
                [114895] = {name="Nightbane",source="Legion",locations={[42]={46737018}},loot={{142552,mount=883}},dungeon="Return to Karazhan",mythic=true,},
                [105503] = {name="Gul'dan",source="Legion",locations={[1191]={43725722}},loot={{137574,mount=791}},raid="The Nighthold",},
                [105504] = {name="Gul'dan",source="Legion",locations={[1191]={43725722}},loot={{137575,mount=633}},raid="The Nighthold",mythic=true,},
                [115767] = {name="Mistress Sassz'ine",source="Legion",locations={[1192]={63952120}},loot={{143643,mount=899}},raid="Tomb of Sargeras",},
                [126916] = {name="F'harg",source="Legion",locations={[885]={54766234}},loot={{152816,mount=971}},raid="Antorus, the Burning Throne",},
                [124828] = {name="Argus the Unmaker",source="Legion",locations={[885]={54766234}},loot={{152789,mount=954}},raid="Antorus, the Burning Throne",},
                -- Warlords of Draenor
                [77325] = {name="Blackhand",source="Warlords",locations={[543]={51502706}},loot={{116660,mount=613}},raid="Blackrock Foundry",mythic=true,},
                [91331] = {name="Archimonde",source="Warlords",locations={[577]={46955270}},loot={{123890,mount=751}},raid="Hellfire Citadel",mythic=true,},
                -- Mists of Pandaria
                [71865] = {name="Garrosh Hellscream",source="Mists",locations={[390]={73824262}},loot={{104253,mount=559,chance=1.24}},raid="Siege of Orgrimmar",mythic=true,},
                [69712] = {name="Ji-kun",source="Mists",locations={[504]={63793187}},loot={{95059,mount=543,chance=2.69},{94835,pet=1202}},raid="Throne of Thunder",},
                [68476] = {name="Horridon",source="Mists",locations={[504]={63793187}},loot={{93666,mount=531,chance=2.69}},raid="Throne of Thunder",},
                [60410] = {name="Elegon",source="Mists",locations={[379]={59553906}},loot={{87777,mount=478}},raid="Mogu'shan Vaults",heroic=true,},
                -- Cataclysm
                [46753] = {name="Al'Akir",source="Cataclysm",locations={[249]={36008400}},loot={{63041,mount=396}},raid="Throne of the Four Winds",legacy=true,},
                [52530] = {name="Alysrazor",source="Cataclysm",locations={[198]={47007700}},loot={{71665,mount=425}},raid="Firelands",legacy=true,},
                [52409] = {name="Ragnaros",source="Cataclysm",locations={[198]={47007700}},loot={{69224,mount=415,chance=2.09}},raid="Firelands",legacy=true,},
                [55294] = {name="Ultraxion",source="Cataclysm",locations={[75]={65005000}},loot={{78919,mount=445}},raid="Dragon Soul",legacy=true,},
                [56173] = {name="Madness of Deathwing",source="Cataclysm",locations={[75]={65005000}},loot={{77067,mount=442},{77069,mount=444}},raid="Dragon Soul",heroic=true,legacy=true,},
                -- Wrath of the Lich King
                [36597] = {name="The Lich King",source="Wrath",locations={[118]={54008500}},loot={{50818,mount=363,chance=1.0}},raid="Icecrown Citadel",heroic=25,legacy=true,},
                [33288] = {name="Yogg-Saron",source="Wrath",locations={[120]={41001600}},loot={{45693,mount=304,chance=1.0}},raid="Ulduar",legacy=true,},
                [28859] = {name="Malygos",source="Wrath",locations={[114]={27582683}},loot={{43952,mount=246},{43953,mount=247}},raid="The Eye of Eternity",legacy=true,},
                [28860] = {name="Sartharion",source="Wrath",locations={[115]={59985693}},loot={{43954,mount=250},{43986,mount=253},},raid="The Obsidian Sanctum",legacy=true,},
                [10184] = {name="Onyxia",source="Wrath",locations={[70]={52197582}},loot={{49636,mount=349}},raid="Onyxia's Lair",legacy=true,},
                [31125] = {name="Archavon the Stone Watcher",source="Wrath",locations={[123]={49951157}},loot={{43959,mount=286,faction="Alliance",},{44083,mount=287,faction="Horde"}},raid="Vault of Archavon",legacy=true,},
                [35013] = {name="Koralon the Flame Watcher",source="Wrath",locations={[123]={49951157}},loot={{43959,mount=286,faction="Alliance",},{44083,mount=287,faction="Horde"}},raid="Vault of Archavon",legacy=true,},
                [35014] = {name="Toravon the Ice Watcher",source="Wrath",locations={[123]={49951157}},loot={{43959,mount=286,faction="Alliance",},{44083,mount=287,faction="Horde"}},raid="Vault of Archavon",legacy=true,}, -- mobID is 38433, adjusted to place correctly in list
                [33993] = {name="Emalon the Storm Watcher",source="Wrath",locations={[123]={49951157}},loot={{43959,mount=286,faction="Alliance",},{44083,mount=287,faction="Horde"}},raid="Vault of Archavon",legacy=true,},
                -- Burning Crusade
                [16152] = {name="Attumen the Huntsman",source="BurningCrusade",locations={[42]={47007700}},loot={{30480,mount=168,chance=1.0},},raid="Karazhan",legacy=true,},
                [19622] = {name="Kael'thas Sunstrider",source="BurningCrusade",locations={[109]={74006500}},loot={{32458,mount=183,chance=1.7}},raid="The Eye",legacy=true,},
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
                [26693] = {name="Skadi the Ruthless",locations={[117]={57124633}},loot={{44151,mount=264}},dungeon="Utgarde Pinnacle",notes="Kill adds until you have three harpoons and fire them using the launchers when Skadi is flying in front of them. You can proceed to kill the boss when he is thrown off his drake by three successful hits.",heroic=true,timewalking=true,},
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
    },
    partyMembers = 0,
    raidMembers = 0,
    updateTimeout = 10,
    versionUpdateFound = false,
    versionUpdateTimeout = 30,
}
