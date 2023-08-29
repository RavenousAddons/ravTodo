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
        showDefeated = true,
        showMounts = true,
        showPets = true,
        showToys = true,
    },
    currencies = {
        {
            id = 1792, -- Honor
        },
        {
            id = 1602, -- Conquest
        },
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
        "Clicking on a Mob's name will place a Map Pin on their location.",
    },
    categories = {
        {
            name = "World Bosses",
            icon = 4672498,
            notes = {},
            mobs = {
                -- Dragonflight
                [195353] = {name="Breezebiter",locations={[2024]={29814613}},quest=nil,loot={{201440,mount=1553},},},
                [193209] = {name="Zenet Avis",criteria=56066,quest=nil,locations={[2023]={31646421}},loot={{198825,mount=1672},{200249,toy=true,},},},
                -- Shadowlands
                [157309] = {name="Violet Mistake",locations={[1536]={58607400},},loot={{182079,mount=1410,},184301},quest=61720,},
                [160821] = {name="Worldedge Gorger",locations={[1525]={38607200},},loot={180583,{182589,mount=1391,}},notes="Starts a quest in the Endmire for the mount",quest=58259,},
                [162586] = {name="Tahonta",locations={[1536]={44215132},},loot={{182075,mount=1366,covenant="Necrolord",},182190},quest=58783,tameable=616693,},
                [162690] = {name="Nerissa Heartless",locations={[1536]={66023532},},loot={{182084,mount=1373,},184179,{174076,covenant="Necrolord",quest=58376,}},quest=58851,},
                [162741] = {name="Gieger",locations={[1536]={31603540},},loot={{182080,mount=1411,covenant="Necrolord",},184298,{183754,covenant="Necrolord",quest=62470,}},quest=58872,vignette=4478,},
                [162819] = {name="Warbringer Mal'Korak",locations={[1536]={33718016},},loot={{182085,mount=1372,},184288},quest=58889,},
                [164107] = {name="Gormtamer Tizo",locations={[1565]={27885248},},loot={{180725,mount=1362,}},notes="Kill Bristlecone Terror until it spawns",quest=59145,},
                [164112] = {name="Humon'gozz",locations={[1565]={31803040},},loot={{182650,mount=1415,}},quest=59157,},
                [165290] = {name="Harika the Horrid",locations={[1525]={45847919},},loot={{180461,mount=1310,covenant="Venthyr",},183720},notes="Be Venthyr",quest=59612,},
                [166521] = {name="Famu the Infinite",locations={[1525]={62484716},},loot={{180582,mount=1379,},183739},quest=59869,},
                [166679] = {name="Hopecrusher",locations={[1525]={51985179},},loot={{180581,mount=1298,covenant="Venthyr",}},quest=59900,tameable=625905,},
                [168135] = {name="Night Mare",locations={[1565]={57874983},},loot={{180728,mount=1306,}},notes="Summoning quest chain",quest=60306,tameable=2143073,},
                [168147] = {name="Sabriel the Bonecleaver",locations={[1536]={50404820},},loot={{181815,mount=1370,covenant="Necrolord",},184291},quest=58784,},
                [168647] = {name="Valfir the Unrelenting",locations={[1565]={29605540},},loot={{180730,mount=1393,covenant="NightFae",},180154,{182176,covenant="NightFae",quest=62431,}},notes="Be Night Fae",quest=61632,},
                [170548] = {name="Sundancer",locations={[1533]={60109350},},loot={{180773,mount=1307,}},notes="Use the statue and a Skystrider Glider",quest=60862,tameable=2143073,},
                [170832] = {name="Champion of Loyalty",locations={[1533]={53478864},},loot={{183741,mount=1426,}},notes="Ring all five vespers to summon the council",quest=60977,},
                [170833] = {name="Champion of Wisdom",locations={[1533]={53478864},},loot={{183741,mount=1426,}},notes="Ring all five vespers to summon the council",quest=60977,},
                [170834] = {name="Champion of Purity",locations={[1533]={53478864},},loot={{183741,mount=1426,}},notes="Ring all five vespers to summon the council",quest=60977,},
                [170835] = {name="Champion of Courage",locations={[1533]={53478864},},loot={{183741,mount=1426,}},notes="Ring all five vespers to summon the council",quest=60977,},
                [170836] = {name="Champion of Humility",locations={[1533]={53478864},},loot={{183741,mount=1426,}},notes="Ring all five vespers to summon the council",quest=60977,},
                [173468] = {name="Dead Blanchy",locations={[1525]={63134311},},loot={{182614,mount=1414,}},notes="7 days of quests",quest=62050,},
                [173499] = {name="Loyal Gorger",locations={[1525]={59305700},},loot={{182589,mount=1391,}},notes="Kill Worldedge Gorger first",quest=62046,},
                [174827] = {name="Gorged Shadehound",locations={[1543]={53507950},},loot={{184167,mount=1304,}},notes="Only during the Hunt: Shadehounds event",},
                [179460] = {name="Fallen Charger",locations={[1543]={16274949,27906290,31803850},},loot={{186659,mount=1502,},186660,186661},notes="Yells, runs from its spawn point to Korthia, then despawns",quest=64164,},
                [179472] = {name="Konthrogz the Obliterator",locations={[1961]={10008000},},loot={{187183,mount=1514,},187375,187378,187384,187397},quest=64246,vignette=4885,},
                [179684] = {name="Malbog",locations={[1961]={44202920},},loot={{186645,mount=1506,},187377},notes="Talk to Caretaker Kah-Kay in town, then follow footprints",quest=64233,},
                [179912] = {name="Maelie the Wanderer",locations={[1961]={30005560,33103865,35804650,35856225,38403140,39703490,41103980,41302750,42806040,43203130,49304170,50302290,59801510,61304040,62404970,67962980},},loot={{186643,mount=1511,}},notes="Tinybell asks you to find Maelie the Wanderer, who spawns in a different place each day. Find her each day, use Reassure on her, and get a mount from Tinybell",quest={64292,64298,any=true,},},
                [179985] = {name="Stygian Stonecrusher",locations={[1961]={46507950},},loot={184790,{186479,mount=803,covenant="Venthyr",},{187283,quest=64530,covenant="Venthyr",},187386,{187428,quest=64553,}},quest=64313,vignette=4831,},
                [180014] = {name="Escaped Wilderling",locations={[1961]={33103930},},loot={{186492,mount=1487,covenant="NightFae",}},quest=64320,vignette=4835,},
                [180032] = {name="Wild Worldcracker",locations={[1961]={47003560},},loot={{187176,toy=true,},{186483,mount=1493,covenant="Kyrian",},187380,{187426,quest=64552,},{187282,quest=64529,covenant="Kyrian",}},quest=64338,vignette=4838,},
                [180042] = {name="Fleshwing",locations={[1961]={59954370},},loot={187372,{186489,mount=1449,covenant="Necrolord",},187181,{187424,quest=64551,}},quest=64349,vignette=4854,},
                [180160] = {name="Reliwik the Defiant",locations={[1961]={56256615},},loot={{186652,mount=1509,},187388},quest=64455,vignette=4864,},
                [180978] = {name="Hirukon",locations={[1970]={52307540},},loot={189905,189946,190005,187636,{187676,mount=1434},},quest=65548,},
                [182114] = {name="Iska, Outrider of Ruin",locations={[1970]={63202605},},loot={190126,{190765,mount=1584,},190102,190103,190458,190050,190104,190107,190124,190463},quest=65585,vignette=4918,},
                -- Battle for Azeroth
                [138794] = {name="Dunegorger Kraulok",locations={[894]={44005580},},loot={{174842,mount=1250,},161419,161399,161400,161402,161404,161405,161406,161408,164385},quest=52196,},
                [140474] = {name="Adherent of the Abyss",locations={[1182]={59365421},[942]={46463606},},loot={{161479,mount=1057,},163929},notes="Needs 20 Abyssal Fragments to summon",},
                [142423] = {name="Overseer Krix",locations={[14]={27005640,33003640},},loot={{163646,mount=1182,}},art=1137,quest={alliance=53014,horde=53518},},
                [142437] = {name="Skullripper",locations={[14]={56204660},},loot={{163645,mount=1183,}},art=1137,quest={alliance=53022,horde=53526},tameable=132193,},
                [142692] = {name="Nimar the Slayer",locations={[14]={67406040},},loot={{163706,mount=1185,}},art=1137,quest={alliance=53091,horde=53517},},
                [142709] = {name="Beastrider Kama",locations={[14]={64807160,66806540},},loot={{163644,mount=1180,}},art=1137,quest={alliance=53083,horde=53504},},
                [142739] = {name="Knight-Captain Aldrin",faction="Alliance",locations={[14]={47404120},},loot={{163578,mount=1173,}},art=1137,quest=53088,},
                [142741] = {name="Doomrider Helgrim",faction="Horde",locations={[14]={53205600},},loot={{163579,mount=1174,}},art=1137,quest=53085,},
                [147701] = {name="Moxo the Beheader",faction="Horde",locations={[62]={63202060},},loot={{166434,mount=1203,}},art=1176,quest=54277,},
                [148037] = {name="Athil Dewfire",faction="Alliance",locations={[62]={40807300},},loot={{166803,mount=1203,},{166449,pet=2544,}},art=1176,quest=54431,},
                [148787] = {name="Alash'anir",locations={[62]={56403080},},loot={{166432,mount=1200,}},art=1176,quest={alliance=54695,horde=54696},tameable=236190,},
                [148790] = {name="Frightened Kodo",locations={[62]={41306550},},loot={{166433,mount=1201,}},art=1176,},
                [149652] = {name="Agathe Wyrmwood",faction="Horde",locations={[62]={49402480},},loot={{166438,mount=1199,}},art=1176,quest=54883,},
                [149655] = {name="Croz Bloodrage",faction="Horde",locations={[62]={50403240},},loot={{166437,mount=1205,}},art=1176,quest=54886,},
                [149658] = {name="Shadowclaw",faction="Alliance",locations={[62]={39403280},},loot={{166437,mount=1205,}},art=1176,quest=54892,},
                [149660] = {name="Blackpaw",faction="Alliance",locations={[62]={49402480},},loot={{166428,mount=1199,}},art=1176,quest=54890,},
                [151934] = {name="Arachnoid Harvester",locations={[1462]={51404120},},loot={{168823,mount=1229,}},quest=55512,},
                [152182] = {name="Rustfeather",locations={[1462]={65007740},},loot={{168370,mount=1248,}},quest=55811,},
                [152290] = {name="Soundless",locations={[1355]={53604140,59404880,62405940},},loot={{169163,mount=1257,}},quest=56298,tameable=132191,},
                [154342] = {name="Arachnoid Harvester",locations={[1462]={52204160},},loot={{168823,mount=1229,}},quest=55512,variant="Time displaced",},
                [157134] = {name="Ishak of the Four Winds",locations={[1527]={73808340},},loot={{174641,mount=1314,}},quest=57259,},
                [157146] = {name="Rotfeaster",locations={[1527]={68003140},},loot={{174753,mount=1317,}},requires=ULDUM_AMATHET,quest=57273,},
                [157153] = {name="Ha-Li",locations={[1530]={33973378},},loot={{173887,mount=1297,}},requires=VALE_MOGU,quest=57344,routes={[1530]={{37323630,33973378,29053930,31524387,37313632,37323630,loop=true,}},},},
                [157160] = {name="Houndlord Ren",locations={[1530]={11603160},},loot={{174841,mount=1327,}},requires=VALE_MOGU,quest=57345,routes={[1530]={{9003520,11603160,12802640}},},},
                [157162] = {name="Rei Lun",locations={[1530]={20401260},},loot={174230,{174649,mount=1313,}},note="Use the scale to buy the mount",requires=VALE_MOGU,quest=57346,},
                [157466] = {name="Anh-De the Loyal",locations={[1530]={33406740},},loot={{174840,mount=1328,}},requires=VALE_MOGU,quest=57363,},
                [162147] = {name="Corpse Eater",locations={[1527]={30404940},},loot={{174769,mount=1319,}},requires=ULDUM_AQIR,quest=58696,tameable=236196,},
                [162681] = {name="Elusive Quickhoof",locations={[864]={26405250,28006500,31106730,42006000,43006900,51108590,52508900,54008300,54605320,55007300},},loot={{174860,mount=1324,}},notes="Feed it Seaside Leafy Greens Mix",tameable=454771,},
                [162765] = {name="Friendly Alpaca",locations={[1527]={15006200,24000900,28004900,30002900,39001000,42007000,46004800,53001900,55006900,63005300,63001400,70003900,76006800},},loot={{174859,mount=1329,}},notes="Feed it Gersahl Greens for 7 days",quest=58879,tameable=454771,},
                [163042] = {name="Ivory Cloud Serpent",locations={[1530]={26805510},},loot={{174752,mount=1311,}},notes="You need a Zan-Tien Lasso to catch it. It spawns fairly high up",requires=VALE_MOGU,tameable=136040,},
                -- Legion
                [119629] = {name="Lord Hel'Nurath",locations={[646]={44405240},},loot={{142233,mount=931,class="WARLOCK",}},quest=46304,},
                [122958] = {name="Blistermaw",locations={[885]={61803710},},loot={{152905,mount=979,}},quest=49183,},
                [126040] = {name="Puscilla",locations={[885]={64002100},},loot={{152903,mount=981,}},quest=48809,},
                [126199] = {name="Vrax'thul",locations={[885]={53003540},},loot={{152903,mount=981,}},quest=48810,},
                [126852] = {name="Wrangler Kravos",locations={[882]={55705990},},loot={{152814,mount=970,},144432,153269},quest=48695,},
                [126867] = {name="Venomtail Skyfin",locations={[882]={33704750},},loot={{152844,mount=973,}},quest=48705,},
                [126912] = {name="Skreeg the Devourer",locations={[882]={49700990},},loot={{152904,mount=980,}},quest=48721,},
                [127288] = {name="Houndmaster Kerrax",locations={[885]={63402240},},loot={{152790,mount=955,}},quest=48821,},
                -- Warlords of Draenor
                [50883] = {name="Pathrunner",locations={[539]={38803640,42603080,44404340,45806860,52803100,56205240},},loot={{116773,mount=636,}},},
                [50981] = {name="Luk'hok",locations={[550]={65604180,71005660,76003000,77404060,79205680,83806480},},loot={{116661,mount=614,}},tameable=132254,},
                [50985] = {name="Poundfist",locations={[543]={40602580,43205550,45404750,48405680,51404310},},loot={{116792,mount=655,}},},
                [50990] = {name="Nakk the Thunderer",locations={[550]={48803420,54403540,60203280,62201500,64402040},},loot={{116659,mount=612,}},tameable=1044794,},
                [50992] = {name="Gorok",locations={[525]={22406620,51205020,57401820,63407960,64605200},},loot={{116674,mount=627,}},},
                [51015] = {name="Silthide",locations={[535]={51408120,61803120,62004540,67206040,78405500},},loot={{116767,mount=630,}},},
                [81001] = {name="Nok-Karosh",locations={[525]={13805140},},loot={{116794,mount=657,boe=true,}},tameable=132203,},
                [83746] = {name="Rukhmar",boss=true,locations={[542]={36003900},},loot={{116771,mount=634,},127775},notes="Weekly; flies",quest=37464,tameable=132192,},
                [90041] = {name="The Last Voidtalon",locations={[525]={47702750,51001990,52301830,53841721},[535]={39705540,46205260,47004800,51904120},[539]={41907570,43207100,46607000,48706990,49607160,50907250},[542]={36501820,47002010,50400610,60801120},[543]={43203420,51603880,54004500,56004000},[550]={40504750,45903140,57302670},},loot={{121815,mount=682,}},notes="Look for the Edge of Reality portals",quest=37864,},
                [95044] = {name="Terrorfist",locations={[534]={15006300},},loot={{116658,mount=611,},{116669,mount=622,},{116780,mount=643,},128315,128025},quest=39288,},
                [95053] = {name="Deathtalon",locations={[534]={23004020},},loot={{116658,mount=611,},{116669,mount=622,},{116780,mount=643,},128315,128025},quest=39287,tameable=132192,},
                [95054] = {name="Vengeance",locations={[534]={32407380},},loot={{116658,mount=611,},{116669,mount=622,},{116780,mount=643,},128315,128025},quest=39290,},
                [95056] = {name="Doomroller",locations={[534]={46805260},},loot={{116658,mount=611,},{116669,mount=622,},{116780,mount=643,},128315,128025},quest=39289,},
                -- Mists of Pandaria
                [60491] = {name="Sha of Anger",boss=true,locations={[379]={53606460},},loot={{87771,mount=473,}},quest=32099,},
                [62346] = {name="Galleon",boss=true,locations={[376]={71606440},},loot={{89783,mount=515,}},quest=32098,},
                [64403] = {name="Alani",locations={[390]={16603400,16603960,17202740,18804520,20001740,23805040,23805720,24406700,25604480,25607340,28203840,29202080,29405340,32007280,32203220,34602520,35004960,36804320,37603800,40006620,40603080,41406040,42604540,43207240,45003820,45005220,48607040,48802600,52603760,54002440,54003180,54204360,55204880,58206400,60403140,61604660,63005500,63406120},},loot={{90655,mount=517,boe=true,}},tameable=136040,},
                [69099] = {name="Nalak",boss=true,locations={[504]={60503730},},loot={{95057,mount=542,},95602},quest=32518,tameable=136040,},
                [69161] = {name="Oondasta",boss=true,locations={[507]={50005700},},loot={{94228,mount=533,},95601},quest=32519,tameable=236192,},
                [69769] = {name="Zandalari Warbringer",locations={[371]={52401880},[379]={75006740},[388]={36408540},[418]={39866578},[422]={47206140},},loot={{94229,mount=535,}},variant="Slate",},
                [69841] = {name="Zandalari Warbringer",locations={[371]={52401880},[379]={75006740},[388]={36608540},[418]={39866578},[422]={47206140},},loot={{94230,mount=534,}},variant="Amber",},
                [69842] = {name="Zandalari Warbringer",locations={[371]={52401880},[379]={75006740},[388]={36408580},[418]={39866578},[422]={47206140},},loot={{94231,mount=536,}},variant="Jade",},
                [73167] = {name="Huolon",locations={[554]={65505730},},loot={{104269,mount=561,},104286},quest=33311,tameable=136040,},
                -- Cataclysm
                [50005] = {name="Poseidus",locations={[204]={41207660},[205]={38006780,44804880,56408220,66004440},},loot={{67151,mount=420,boe=true,}},},
                [50062] = {name="Aeonaxx",locations={[207]={43005079,49125560,50506350,53723971,55055411},},loot={{63042,mount=393,}},},
                [50409] = {name="Mysterious Camel Figurine",locations={[249]={22066415,25745120,31736947,31944542,33193822,33222266,34602974,38265507,38416056,40134397,40253895,45354200,45431415,50497206,50553214,50928533,51268015,51955036,58396155,58458337,63301679,63982829,65772266,66526884,70015869,72244444,73457364},},loot={{63046,mount=400,}},},
                -- Wrath of the Lich King
                [32491] = {name="Time-Lost Proto-Drake",locations={[120]={31006940,35607660,51007000,52003400},},loot={{44168,mount=265}},},
            },
        },
        {
            name = "Weekly",
            icon = 1391676,
            notes = {},
            mobs = {
                -- Shadowlands
                [166945] = {name="Nalthor the Rimebinder",locations={[1533]={40075507}},loot={{181819,mount=1409}},dungeon="The Necrotic Wake",mythic=true,},
                [177269] = {name="So'leah",locations={[1550]={32017602}},loot={{186638,mount=1481}},dungeon="Tazavesh, the Veiled Market",mythic=true,},
                    -- 3 raid mounts
                -- Battle for Azeroth
                [129440] = {name="Lord Harlan Sweete",locations={[895]={84557872}},loot={{159842,mount=995}},dungeon="Freehold",mythic=true,},
                [136160] = {name="King Dazar",locations={[862]={37513929}},loot={{159921,mount=1040}},dungeon="Kings' Rest",mythic=true,},
                [133007] = {name="Unbound Abomination",locations={[863]={51196456}},loot={{160829,mount=1053}},dungeon="The Underrot",mythic=true,},
                [133384] = {name="Merektha",locations={[864]={51832528}},loot={{160832,pet=2186}},dungeon="Temple of Sethraliss",mythic=true,},
                    -- 1 dungeon mount
                    -- 3 raid mounts
                -- Legion
                [114262] = {name="Attumen the Huntsman",locations={[42]={47007464}},loot={{142236,mount=875}},dungeon="Return to Karazhan",mythic=true,},
                [114895] = {name="Nightbane",locations={[42]={47007464}},loot={{142552,mount=883}},dungeon="Return to Karazhan",mythic=true,},
                    -- 5 raid mounts
                -- Warlords of Draenor
                    -- 3 raid mounts
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
                    -- 1 dungeon mount
                -- Burning Crusade
                [23035] = {name="Anzu",locations={[108]={44606560}},loot={{32768,mount=185}},dungeon="Sethekk Halls",heroic=true,},
                [24664] = {name="Kael'thas Sunstrider",locations={[122]={60903070}},loot={{35513,mount=213}},dungeon="Magisters' Terrace",heroic=true,},
                -- Vanilla
                [52151] = {name="Bloodlord Mandokir",locations={[50]={72003280}},loot={{68823,mount=410}},dungeon="Zul'Gurub",},
                [52059] = {name="High Priestess Kilnara",locations={[50]={72003280}},loot={{68824,mount=411}},dungeon="Zul'Gurub",},
                [45412] = {name="Lord Aurius Rivendare",locations={[22]={43501930}},loot={{13335,mount=69}},dungeon="Stratholme",},
            },
        },
        -- {
        --     name = "raids",
        --     icon = 609811,
        --     notes = {},
        --     mobs = {},
        -- },
        -- {
        --     name = "Dungeons",
        --     icon = 609811,
        --     notes = {},
        --     mobs = {},
        -- },
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
        {
            name = "Extra",
            icon = 1733736,
            notes = {},
            mobs = {},
        },
    },
}