-- GAME LOOP -------------------------------

function _init()
    palt(10,true)
    init_elements()
    init_characters()
    scene.initing()
end

function _update60()
    scene.updates()
end

function _draw()
    cls()
    scene.drawing()
end

-- SCENE TABLE INIT -------------------------------

scene = {}
scene.active = 1
scene.update = {}
scene.draw = {}
scene.init = {}

scene.updates = function()
    if scene.update[scene.active] != nil then
        scene.update[scene.active]()
    end
end

scene.drawing = function()
    if scene.draw[scene.active] != nil then
        scene.draw[scene.active]()
    end
end

scene.initing = function()
    if scene.init[scene.active] != nil then
        scene.init[scene.active]()
    end
end

-- INIT FUNCTIONS -------------------------------

-- {chart col, chart row, element name, symbol, group num, period, group characterization, state of matter, fact 1, fact 2}
function init_elements()
    elements = {}
    elements_matrix = {}
    add(elements, {1,1,"hydrogen", "h", 1, 1, 1, 3, "is the lightest and most abundant element in the universe", "is the only element that, when burned, produces water as a byproduct"})
    add(elements, {18,1,"helium", "he", 18, 1, 2, 3, " has the lowest boiling and melting points of all the elements", "was first discovered on the sun through spectroscopy before it was found on earth"})
    add(elements, {1,2,"lithium", "li", 1, 2, 3, 1, "is found mainly in the deposits of salar de uyuni, bolivia", "has the lowest density of all solid elements and can float on water"})
    add(elements, {2,2,"beryllium", "be", 2, 2, 4, 1, "was originally found in the oxide form of beryl, emeralds", "was the primary ingredient used to make mirrors in nasa\'s james webb space telescope"})
    add(elements, {13,2,"boron", "b", 13, 2, 7, 1, "was poured along with sand into chernobyl as a neutron absorber", "gets its name from the arabic word for borax, \"buraq\""})
    add(elements, {14,2,"carbon", "c", 14, 2, 1, 1, "is found in various forms, including diamonds and graphite", "forms more compounds than all the other elements combined"})
    add(elements, {15,2,"nitrogen", "n", 15, 2, 1, 3, "makes up about 78% of earth's atmosphere", "is called \'azote\' by the french, meaning \'without life\'"})
    add(elements, {16,2,"oxygen", "o", 16, 2, 1, 3, "is the most abundant element in the earth's crust", "is the most abundant element in the human body"})
    add(elements, {17,2,"fluorine", "f", 17, 2, 1, 3, "is the most reactive element", "is the most electronegative element, meaning it has a strong tendency to attract electrons"})
    add(elements, {18,2,"neon", "ne", 18, 2, 2, 3, "is derived from the greek word \"neos,\" meaning \"new\"", "has the smallest temperature range for which it is a liquid (2.6 degrees celsius)"})
    add(elements, {1,3,"sodium", "na", 1, 3, 3, 1, "was first isolated from lye using electrolosis", "is commonly consumed as table salt, where it combines with chloride"})
    add(elements, {2,3,"magnesium", "mg", 2, 3, 4, 1, "is named after the Greek region magnesia", "is used in fireworks, flares, and sparklers to produce a bright white light"})
    add(elements, {13,3,"aluminum", "al", 13, 3, 6, 1, "is the most abundant metal in the earth's crust", "forms the cap of the washington monument"})
    add(elements, {14,3,"silicon", "si", 14, 3, 7, 1, "is the primary element used in semiconductor devices", "occurs naturally in its oxidized form as silica, commonly found in sand and quartz"})
    add(elements, {15,3,"phosphorus", "p", 15, 3, 1, 1, "exists in several allotropic forms, including white, red, and black", "was discovered in 1669 by hennig brand when he isolated it from urine"})
    add(elements, {16,3,"sulfur", "s", 16, 3, 1, 1, "is known for its distinct yellow color and pungent smell when burned", "has been used to preserve wine for millennia, and remains an ingredient in wine today"})
    add(elements, {17,3,"chlorine", "cl", 17, 3, 1, 3, "was first used as a chemical weapon during ww1 in the second battle of ypres", "was first named \"khloros,\" from the greek word for greenish-yellow"})
    add(elements, {18,3,"argon", "ar", 18, 3, 2, 3, "was extracted from liquid air alongside xenon, neon, and krypton", "is the third most abundant gas in the earth's atmosphere"})
    add(elements, {1,4,"potassium", "k", 1, 4, 3, 1, "can lead to a medical condition known as hypokalemia when levels are too low", "is a vital nutrient for plants and is found in high quantities in banana and potato"})
    add(elements, {2,4,"calcium", "ca", 2, 4, 4, 1, "was first isolated through the electrolysis of lime and mercuric oxide", "is named after the latin word \"calcis\" or \"calx\" meaning lime"})
    add(elements, {3,4,"scandium", "sc", 3, 4, 5, 1, "impurities give the blue color to aquamarine", "is named after scandinavia, where it was first discovered"})
    add(elements, {4,4,"titanium", "ti", 4, 4, 5, 1, "was named after the titans of greek mythology", "is often used in medical implants due to its biocompatibility"})
    add(elements, {5,4,"vanadium", "v", 5, 4, 5, 1, "was first discovered by andres manuel del rio in 1801 in mexico", "is named after vanadis, the norse goddess of beauty"})
    add(elements, {6,4,"chromium", "cr", 6, 4, 5, 1, "was first isolated from the mineral crocoite", "gives rubies and emeralds their red and green colors"})
    add(elements, {7,4,"manganese", "mn", 7, 4, 5, 1, "is named after the latin word for magnets, \"magnes\"", "is responsible for the purple color of amethysts"})
    add(elements, {8,4,"iron", "fe", 8, 4, 5, 1, "is the most commonly used metal in the world", "was first used in tools and weapons around 1200 bc, marking the beginning of its namesake age"})
    add(elements, {9,4,"cobalt", "co", 9, 4, 5, 1, "is an essential trace nutrient for health and makes up the backbone of vitamin b12", "is named after the german word \"kobold\", meaning goblin or evil spirit"})
    add(elements, {10,4,"nickel", "ni", 10, 4, 5, 1, "commonly causes skin irritation when it is found in jewelry", "is named after the saxon term \'kupfernickel\' or devils\' copper"})
    add(elements, {11,4,"copper", "cu", 11, 4, 5, 1, "was the only element used to make pennies between 1783 and 1837", "what has anti-microbial properties and kills bacteria, viruses and yeasts on contact"})
    add(elements, {12,4,"zinc", "zn", 12, 4, 5, 1, "is used to galvanize other metals to prevent rusting", "when combined with copper forms brass"})
    add(elements, {13,4,"gallium", "ga", 13, 4, 6, 1, "is a metal that melts at just above room temperature", "has the largest liquid range of any metal"})
    add(elements, {14,4,"germanium", "ge", 14, 4, 7, 1, "was predicted by mendeleev and called the element ekasilicon", "was named after germany, where it was first discovered"})
    add(elements, {15,4,"arsenic", "as", 15, 4, 7, 1, "has been historically used as a poison due to its toxicity", "was responsible for the first anti poisoning law passed in 82 b.c."})
    add(elements, {16,4,"selenium", "se", 16, 4, 1, 1, "gets its name from the greek word \"selene,\" which means moon", "is found in large amounts in brazil nuts"})
    add(elements, {17,4,"bromine", "br", 17, 4, 1, 2, "is the only nonmetallic element that is a liquid under normal conditions", "is a dark red, fuming liquid at room temperature"})
    add(elements, {18,4,"krypton", "kr", 18, 4, 2, 3, "was discovered by ramsay and travers who also discovered helium", "is derived from the greek \'kryptos\', meaning hidden"})
    add(elements, {1,5,"rubidium", "rb", 1, 5, 3, 1, "was discovered when observing the spectrum of the mineral lepidolite as it burned", "is derived from the latin rubidus, meaning deepest red"})
    add(elements, {2,5,"strontium", "sr", 2, 5, 4, 1, "was first identified it in the mineral strontianite", "is mostly formed through the radioactive decay of rubidium"})
    add(elements, {3,5,"yttrium", "y", 3, 5, 5, 1, "was discovered in 1794 by johan gadolin, who detected it in the mineral gadolinite", "is one of four named after the village ytterby including terbium, ytterbium, and erbium"})
    add(elements, {4,5,"zirconium", "zr", 4, 5, 5, 1, "combines with silicate to create the natural semiprecious gemstone zircon", "comes from the Persian \"zargun\" or gold color"}) 
    add(elements, {5,5,"niobium", "nb", 5, 5, 5, 1, "was initially named \'columbium\' after its discovery in connecticut", "is named after niobe, the daughter of tantalus in greek mythology"})
    add(elements, {6,5,"molybdenum", "mo", 6, 5, 5, 1, "is named after the greek word \"molybdos,\" meaning lead", "was discovered when combining molybdic acid with carbon in linseed oil"})
    add(elements, {7,5,"technetium", "tc", 7, 5, 5, 1, "is the lightest element on the periodic table that has no stable isotopes", "was the first element to be artificially produced"})
    add(elements, {8,5,"ruthenium", "ru", 8, 5, 5, 1, "is named after ruthenia, the latin word for russia", "was discovered after dissolving crude platinum from russia\'s ural mountains in aqua regia"})
    add(elements, {9,5,"rhodium", "rh", 9, 5, 5, 1, "is used in jewelry as a plating to give a reflective white surface", "is used with palladium and/or platinum to make catalytic converters"})
    add(elements, {10,5,"palladium", "pd", 10, 5, 5, 1, "was named after the asteroid pallas, which was itself named after athena", "has the unique ability to absorb up to 900 times its own volume of hydrogen"})
    add(elements, {11,5,"silver", "ag", 11, 5, 5, 1, "has the highest electrical conductivity of any element", "has been used for coinage more than any other metal throughout history"})
    add(elements, {12,5,"cadmium", "cd", 12, 5, 5, 1, "is highly toxic and was commonly used in paint pigments", "comes from the latin word cadmia, which is an ancient name for zinc carbonite"})
    add(elements, {13,5,"indium", "in", 13, 5, 6, 1, "metal gives off a high-pitched \"scream,\" when bent, similar to the \"tin cry,\"", "is named after the indigo color of its spectral lines"})
    add(elements, {14,5,"tin", "sn", 14, 5, 6, 1, "is alloyed together with copper to create bronze", "is denoted by the symbol sn, derived from its latin name stannum"})
    add(elements, {15,5,"antimony", "sb", 15, 5, 7, 1, "was named after the greek words anti and monos to mean \"a metal not found alone\"", "is denoted by the symbol sb, derived from its historic name stibium"})
    add(elements, {16,5,"tellurium", "te", 16, 5, 7, 1, "was first discovered in transylvania in 1782 by a mining inspector", "is named after the latin word for earth, \"tellus\""})
    add(elements, {17,5,"iodine", "i", 17, 5, 1, 1, "is a good test for starch as it turns a deep blue color when it comes in contact with it", "is used as a disinfectant and in the production of iodized salt"})
    add(elements, {18,5,"xenon", "xe", 18, 5, 2, 3, "was extracted from liquid air alongside neon, argon, and krypton", "creates a blue or lavender glow when subjected to an electrical discharge"})
    add(elements, {1,6,"cesium", "cs", 1, 6, 3, 1, "is the most electropositive stable element", "provides the official definition of a second"})
    add(elements, {2,6,"barium", "ba", 2, 6, 4, 1, "was first isolated in 1808 by sir humphry davy, who electrolyzed molten baryta", "is named after the greek word \"barys\", meaning heavy"})
    add(elements, {3,9,"lanthanum", "la", 3, 9, 8, 1, "is the first element in the lanthanides", "is named after the greek word \"lanthanein\", meaning to lie hidden"})
    add(elements, {4,9,"cerium", "ce", 4, 9, 8, 1, "was discovered in 1803 by jons jakob berzelius and wilhelm hisinger", "is named after the dwarf planet ceres, which was discovered in 1801"})
    add(elements, {5,9,"praseodymium", "pr", 5, 9, 8, 1, "was separated from cerium in 1885 by austrian chemist carl auer von welsbach", "is named after the greek word \"prasios\", meaning greenish"})
    add(elements, {6,9,"neodymium", "nd", 6, 9, 8, 1, "is named after the greek \'neos didymos\' meaning \'new twin\'", "was discovered in 1885 by carl auer von welsbach, who separated it from praseodymium"})
    add(elements, {7,9,"promethium", "pm", 7, 9, 8, 1, "is the only radioactive element that is not found naturally on earth", "is named after prometheus, a figure in greek mythology"})
    add(elements, {8,9,"samarium", "sm", 8, 9, 8, 1, "forms a magnet with comalt with the highest resistance to demagnetization of any known material", "is named after samarskite, a mineral from which it was first isolated"})
    add(elements, {9,9,"europium", "eu", 9, 9, 8, 1, "has the lowest density and the lowest melting point of all the lanthanides", "is named after europe, where it was first discovered"})
    add(elements, {10,9,"gadolinium", "gd", 10, 9, 8, 1, "has the highest thermal neutron capture cross-section of all elements", "is named after johan gadolin, a finnish chemist"})
    add(elements, {11,9,"terbium", "tb", 11, 9, 8, 1, "is used to detect bacterial endospores that may hitch a ride to space", "is one of four named after the village ytterby including yttrium, ytterbium, and erbium"})
    add(elements, {12,9,"dysprosium", "dy", 12, 9, 8, 1, "was first isolated by canadian scientist frank spedding and his team using ion-exchange separation", "is named after the greek word \"dysprositos\", meaning hard to get"})
    add(elements, {13,9,"holmium", "ho", 13, 9, 8, 1, "has the highest magnetic strength of any naturally occurring element", "is named after stockholm, sweden, where it was first discovered"})
    add(elements, {14,9,"erbium", "er", 14, 9, 8, 1, "was reduced to its pure form in 1934 by wilhelm klemm and heinrich bommer", "is one of four named after the village ytterby including yttrium, ytterbium, and terbium"})
    add(elements, {15,9,"thulium", "tm", 15, 9, 8, 1, "is the least abundant of all the lanthanides", "is named after thule, the ancient name for scandinavia"})
    add(elements, {16,9,"ytterbium", "yb", 16, 9, 8, 1, "is one of four named after the village ytterby including yttrium, terbium, and erbium", "was separated ytterbia into two components including lutetium"})
    add(elements, {17,9,"lutetium", "lu", 17, 9, 8, 1, "has the highest melting and boiling points and is the heaviest and hardest of the lanthanides", "is named after lutetia, the latin name for paris, france"})
    add(elements, {4,6,"hafnium", "hf", 4, 6, 5, 1, "what is the main neutron absorber in the reactor control rods of nuclear submarines", "is named after hafnia, the latin name for copenhagen, denmark"})
    add(elements, {5,6,"tantalum", "ta", 5, 6, 5, 1, "was thought to be identical to niobium until rowe in 1844", "is named after tantalus, a figure in greek mythology"})
    add(elements, {6,6,"tungsten", "w", 6, 6, 5, 1, "has the highest melting point of all metals", "was discovered after being extracted from wolframite ore"})
    add(elements, {7,6,"rhenium", "re", 7, 6, 5, 1, "rhenium comes from the latin term rhenus meaning rhine", "is obtained from molybdenum roaster-flue dusts found in copper-sulfide ores"})
    add(elements, {8,6,"osmium", "os", 8, 6, 5, 1, "is the densest naturally occurring element", "comes from the greek term osme, which means smell"})
    add(elements, {9,6,"iridium", "ir", 9, 6, 5, 1, "is the most corrosion-resistant element", "is named for the latin word iris, which means rainbow"})
    add(elements, {10,6,"platinum", "pt", 10, 6, 5, 1, "was originally called \"platina,\" meaning \"little silver\"", "is used as the international standard for measuring the kilogram"})
    add(elements, {11,6,"gold", "au", 11, 6, 5, 1, "is represented by the symbol au, which comes from the latin word for gold, aurum", "is vital for blocking uv rays on the visor of an astronaut\'s helmet"})
    add(elements, {12,6,"mercury", "hg", 12, 6, 5, 2, "is the only metal that is liquid at room temperature", "is known by the symbol hg, which comes from the word hydrargyrum, meaning liquid silver"})
    add(elements, {13,6,"thallium", "tl", 13, 6, 6, 1, "was named after the greek word thallos, meaning green shoot or twig", "was historically used as a rodent and ant killer due to its toxicity"})
    add(elements, {14,6,"lead", "pb", 14, 6, 6, 1, "was historically used as a cosmetic to give a \"white face\"", "is known by the symbol pb, which comes from the latin word plumbum"})
    add(elements, {15,6,"bismuth", "bi", 15, 6, 6, 1, "is often found in the natural state and has a distinctive pinkish tinge", "is used in pharmaceuticals, particularly in pepto-bismol for its medicinal properties"})
    add(elements, {16,6,"polonium", "po", 16, 6, 6, 1, "was named after poland, marie curie\'s native country", "was the first element discovered by marie curie"})
    add(elements, {17,6,"astatine", "at", 17, 6, 7, 1, "is the rarest naturally occurring element on earth", "was first synthesized by bombarding bismuth with alpha particles"})
    add(elements, {18,6,"radon", "rn", 18, 6, 2, 3, "is a radioactive, colorless, odorless, tasteless gas, occurring naturally", "is the second most frequent cause of lung cancer"})
    add(elements, {1,7,"francium", "fr", 1, 7, 3, 1, "is the second rarest naturally occurring element", "was discovered in 1939 by marguerite perey at the curie institute in paris"})
    add(elements, {2,7,"radium", "ra", 2, 7, 4, 1, "was once used in self-luminous paints for watches, clocks, and instrument dials", "is the heaviest alkaline earth metal"})
    add(elements, {3,10,"actinium", "ac", 3, 10, 9, 1, "is the namesake of the actinide series", "is named after the greek word \'aktinos\', meaning ray or beam"})
    add(elements, {4,10,"thorium", "th", 4, 10, 9, 1, "has the highest melting point of all the actinides", "is named after thor, the norse god of thunder"})
    add(elements, {5,10,"protactinium", "pa", 5, 10, 9, 1, "was first isolated in 1934, by aristid von grosse", "is named after the greek word protos and actinum, meaning \"parent of actinium\""})
    add(elements, {6,10,"uranium", "u", 6, 10, 9, 1, "was named after the planet uranus", "is the most significant fissionable material used in nuclear reactors"})
    add(elements, {7,10,"neptunium", "np", 7, 10, 9, 1, "was named after neptune, following the naming convention used for Uranium", "was the first transuranium element to be synthesized"})
    add(elements, {8,10,"plutonium", "pu", 8, 10, 9, 1, "powers the radioisotope thermoelectric generators aboard Voyager and New Horizons", "is primarily produced as a byproduct of nuclear power generation"})
    add(elements, {9,10,"americium", "am", 9, 10, 9, 1, "was named after america", "is notably used in the production of smoke detectors"})
    add(elements, {10,10,"curium", "cm", 10, 10, 9, 1, "was named after marie and pierre curie", "was identified by glenn seaborg at the wartime metallurgical laboratory"})
    add(elements, {11,10,"berkelium", "bk", 11, 10, 9, 1, "can be made by bombarding am-241 with alpha particles using a cyclotron", "is named after berkeley, california, where it was first synthesized"})
    add(elements, {12,10,"californium", "cf", 12, 10, 9, 1, "can be made by bombarding curium-242 with alpha particles", "is named after california, where it was first synthesized"})
    add(elements, {13,10,"einsteinium", "es", 13, 10, 9, 1, "was discovered as a component of the debris of the first hydrogen bomb explosion in 1952", "is named after albert einstein"})
    add(elements, {14,10,"fermium", "fm", 14, 10, 9, 1, "is named after enrico fermi", "is named after enrico fermi"})
    add(elements, {15,10,"mendelevium", "md", 15, 10, 9, 1, "is named after dmitri mendeleev", "is named after dmitri mendeleev"})
    add(elements, {16,10,"nobelium", "no", 16, 10, 9, 1, "is named after alfred nobel", "is named after alfred nobel"})
    add(elements, {17,10,"lawrencium", "lr", 17, 10, 9, 1, "is named after ernest o. lawrence", "is named after ernest o. lawrence"})
    add(elements, {4,7,"rutherfordium", "rf", 4, 7, 5, 4, "is named after ernest rutherford", "is named after ernest rutherford"})
    add(elements, {5,7,"dubnium", "db", 5, 7, 5, 4, "is named after dubna, russia, where it was first synthesized", "is named after dubna, russia, where it was first synthesized"})
    add(elements, {6,7,"seaborgium", "sg", 6, 7, 5, 4, "was the only element named after a living person until oganesson in 2023", "is named after glenn t. seaborg"})
    add(elements, {7,7,"bohrium", "bh", 7, 7, 5, 4, "is named after niels bohr", "is named after niels bohr"})
    add(elements, {8,7,"hassium", "hs", 8, 7, 5, 4, "is named after the latin name for the german state of hesse", "is named after the latin name for the german state of hesse"})
    add(elements, {9,7,"meitnerium", "mt", 9, 7, 10, 4, "is named after lise meitner", "is named after lise meitner"})
    add(elements, {10,7,"darmstadtium", "ds", 10, 7, 10, 4, "is named after darmstadt, germany, where it was first synthesized", "is named after darmstadt, germany, where it was first synthesized"})
    add(elements, {11,7,"roentgenium", "rg", 11, 7, 10, 4, "is named after wilhelm conrad rontgen", "is named after wilhelm conrad rontgen"})
    add(elements, {12,7,"copernicium", "cn", 12, 7, 10, 4, "is named after nicolaus copernicus", "is named after nicolaus copernicus"})
    add(elements, {13,7,"nihonium", "nh", 13, 7, 10, 4, "is named after the japanese word for japan", "is named after the japanese word for japan"})
    add(elements, {14,7,"flerovium", "fl", 14, 7, 10, 4, "is named after flerov laboratory of nuclear reactions", "is named after flerov laboratory of nuclear reactions"})
    add(elements, {15,7,"moscovium", "mc", 15, 7, 10, 4, "is named after moscow oblast, russia", "is named after moscow oblast, russia"})
    add(elements, {16,7,"livermorium", "lv", 16, 7, 10, 4, "is named after lawrence livermore national laboratory", "is named after lawrence livermore national laboratory"})
    add(elements, {17,7,"tennessine", "ts", 17, 7, 10, 4, "is named after the state of tennessee", "is named after the state of tennessee"})
    add(elements, {18,7,"oganesson", "og", 18, 7, 10, 4, "is the second element to be named after a living person", "is named after yuri oganessian"})

    
    for i = 1, 18 do
        elements_matrix[i] = {}
    end

    local seq = 1
    for e in all(elements) do
        col, row, name = e[1], e[2], e[3]
        elements_matrix[col][row] = {name, e[4], e[5], e[6], e[7], e[8], e[9], e[10], seq}
        seq += 1
    end


end



        -- key
        -- 1 = reactive nonmetal
        -- 2 = noble gas
        -- 3 = alkali metal
        -- 4 = alkaline earth metal
        -- 5 = transition metal
        -- 6 = post-transition metal
        -- 7 = metalloid
        -- 8 = lanthanide
        -- 9 = actinide
        -- 10 = unknown

        -- state of matter
        -- 1 = solid
        -- 2 = liquid
        -- 3 = gas

    -- HELPER/DEBUG FUNCTIONS -------------------------------

function grid()
    for i = 0, 15 do
        for j = 0, 15 do
            spr(14, i*8, j*8)
        end
    end
end




    -- key
    -- 1 = reactive nonmetal
    -- 2 = noble gas
    -- 3 = alkali metal
    -- 4 = alkaline earth metal
    -- 5 = transition metal
    -- 6 = post-transition metal
    -- 7 = metalloid
    -- 8 = lanthanide
    -- 9 = actinide
    -- 10 = unknown

    -- state of matter
    -- 1 = solid
    -- 2 = liquid
    -- 3 = gas

-- HELPER/DEBUG FUNCTIONS -------------------------------

function grid()
    for i = 0, 15 do
        for j = 0, 15 do
            spr(14, i*8, j*8)
        end
    end
end

function box()
    rect(0,0,127,127,7)
end

-- DRAW FUNCTIONS -------------------------------

function draw_elements()
    for i = 1, #elements do
        local x = 9+(elements[i][1]-1)*6
        local y = 15+(elements[i][2]-1)*6
        rect(x,y,x+6,y+6,7)
    end
end

    -- 1 = reactive nonmetal
    -- 2 = noble gas
    -- 3 = alkali metal
    -- 4 = alkaline earth metal
    -- 5 = transition metal
    -- 6 = post-transition metal
    -- 7 = metalloid
    -- 8 = lanthanide
    -- 9 = actinide
    -- 10 = unknown
function draw_group(g)
    local group_colors = {11, 8, 12, 13, 2, 4, 9, 3, 14, 5}
    for i = 1, #elements do
        if elements[i][7] == g then
            local x = 10+(elements[i][1]-1)*6
            local y = 16+(elements[i][2]-1)*6
            rectfill(x,y,x+4,y+4,group_colors[g])
        end
    end
end

    -- 1 = solid
    -- 2 = liquid
    -- 3 = gas
    -- 4 = unknown
function draw_state(s)
    local group_colors = {2, 12, 8, 5}
    for i = 1, #elements do
        if elements[i][8] == s then
            local x = 10+(elements[i][1]-1)*6
            local y = 16+(elements[i][2]-1)*6
            rectfill(x,y,x+4,y+4,group_colors[s])
        end
    end
end



-- unlock dog questline
-- add music
