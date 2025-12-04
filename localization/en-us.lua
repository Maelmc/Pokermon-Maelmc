return {
    descriptions = {
        Back = {
            b_maelmc_hazarddeck = {
                name = "Hazard Deck",
                text = {
                    "At the start of blind,",
                    "{C:purple,T:m_poke_hazard}+#1# Hazards{}",
                    "Hazards held in hand",
                    "give {C:attention}+1{} hand size"
                }
            },
            b_maelmc_mysterydeck = {
                name = "Mystery Deck",
                text = {
                    "Start with a {C:dark_edition}Negative",
                    "and {C:attention}Eternal {C:attention,T:j_maelmc_wonder_trade}Wonder Trade",
                }
            },
        },
        Enhanced = {
            m_maelmc_trapped = {
                name = "Trapped Card",
                text = {
                    "no rank or suit",
                    "does not score when played",
                    "cannot be destroyed",
                    "enhancement cannot be changed",
                },
            },
        },
        Spectral = {
            c_maelmc_beastball = {
                name = "Beast Ball",
                text = {
                    "Creates an",
                    "{C:dark_edition}Ultra Beast{C:attention} Pokemon {}Joker",
                    "{C:inactive}(Must have room)"
                }
            }
        },
        Tag = {
            tag_maelmc_shadow_tag = {
                name = "Shadow Tag",
                text = {
                    "Add a {C:attention}#1#",
                    "to your deck",
                }
            },
            tag_maelmc_cleanse_tag = {
                name = "Cleanse Tag",
                text = {
                    "Protects from the",
                    "detrimental effect of",
                    "{C:attention}1 {C:spectral}Spectral{} card",
                }
            },
        },
        Item = {
            c_maelmc_tealmask = {
                name = "Teal Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Lucky Cards",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Transforms leftmost",
                    "or selected {C:attention}Ogerpon"
                },
            },
            c_maelmc_wellspringmask = {
                name = "Wellspring Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Bonus Cards",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Transforms leftmost",
                    "or selected {C:attention}Ogerpon"
                },
            },
            c_maelmc_hearthflamemask = {
                name = "Hearthflame Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Mult Cards",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Transforms leftmost",
                    "or selected {C:attention}Ogerpon"
                },
            },
            c_maelmc_cornerstonemask = {
                name = "Cornerstone Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Stone Cards",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Transforms leftmost",
                    "or selected {C:attention}Ogerpon"
                },
            },
            c_maelmc_meteorite = {
                name = "Meteorite",
                text = {
                    "Cycle through leftmost or",
                    "selected {C:attention}Deoxys{}' forms",
                    "{C:inactive,s:0.8}(Normal, Attack, Defense, Speed)",
                },
            },
            c_maelmc_metronome = {
                name = "Metronome",
                text = {
                    "Play the same hand {C:attention}#1#",
                    "times in a row while holding this",
                    "to upgrade that hand by",
                    "{C:attention}#2#{} levels {C:inactive}(Hand: {C:attention}#3# #4#{C:inactive} times)"
                },
            },
        },
        Joker = {
            j_maelmc_glimmet = {
                name = "Glimmet",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each {C:attention}Hazard Card held{} in hand",
                    "gives {C:chips}+#2#{} Chips for every {C:attention}Hazard",
                    "{C:attention}Card{} in your full deck",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)",
                    "{C:inactive,s:0.8}(Evolves after triggering held {C:purple,s:0.8}Hazard Cards{} {C:attention,s:0.8}#4#{C:inactive,s:0.8} times)"
                }
            },
            j_maelmc_glimmora = {
                name = "Glimmora",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}",
                    "Increases hazards set by #2#",
                    "after triggering {C:attention}#3#{} held {C:purple}Hazard Cards{}",
                    "{C:inactive,s:0.8}(Requirement increases by #4# after each increase)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each {C:attention}Hazard Card held{} in hand",
                    "gives {C:chips}+#5#{} Chips for every {C:attention}Hazard",
                    "{C:attention}Card{} in your full deck",
                    "{C:inactive}(Currently {C:chips}+#6#{C:inactive} Chips)",
                }
            },
            j_maelmc_cufant = {
                name = "Cufant",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Enhance {C:purple}#2# Hazard{} card in hand",
                    "into a {C:attention}Steel{} card",
                    "at the end of round",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)"
                }
            },
            j_maelmc_copperajah = {
                name = "Copperajah",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Enhance {C:purple}#2# Hazards{} cards in hand",
                    "into {C:attention}Steel{} cards",
                    "at the end of round",
                }
            },
            j_maelmc_mega_copperajah = {
                name = "Gigantamax Copperajah",
                text = {
                    "{X:red,C:white}X#1#{} Mult for every {C:attention}Steel",
                    "{C:attention}Card{} in your full deck",
                    "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_maelmc_odd_keystone = {
                name = "Odd Keystone",
                text = {
                    "Collects souls after selling a Joker",
                    "or consumable or destroying cards",
                    "{br:3}ERROR - CONTACT STEAK",
                    "The rarer the Joker sold, the greater",
                    "the quantity of souls collected",
                    "{C:inactive,s:0.8}(Evolves after collecting {C:attention,s:0.8}#1#{C:inactive,s:0.8}/#2# souls)",
                    --"{C:inactive,s:0.8}(Evolves after using and consuming {C:dark_edition,s:0.8}#3#{C:inactive,s:0.8})"
                } 
            },
            j_maelmc_spiritomb = {
                name = "Spiritomb",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:red}+#2#{} Mult",
                    "{C:attention}-#3#{} hand size",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Gains {C:dark_edition}Negative{}",
                    "if you have at least {C:attention}#4#{} cards",
                    "in your full deck",
                } 
            },
            --[[j_maelmc_spiritombl = {
                name = "Spiritomb",
                text = {
                    "{X:red,C:white}X#1#{} Mult for every card",
                    "in your full deck",
                    "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Gains {C:dark_edition}Negative{}",
                    "if you have at least {C:attention}#3#{} cards",
                    "in your full deck",
                } 
            },]]
            j_maelmc_gym_leader = {
                name = "#2#",
                text = {
                    "{C:attention}Nature: #1#",
                    "Creates a {C:attention}tag{} and an {C:pink}Energy{} card",
                    "matching the {C:attention}Nature{}'s type",
                    "after clearing a Boss Blind",
                } 
            },
            j_maelmc_kecleon = {
                name = "Kecleon",
                text = {
                    "Gain {C:red}+#1#{} Mult whenever",
                    "this Joker changes {C:attention}Type{}",
                    "{C:inactive,s:0.8}(Currently {C:red}+#2#{} {C:inactive,s:0.8}Mult)"
                } 
            },
            j_maelmc_lunatone = {
                name = "Lunatone",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "card in poker hand to become {C:clubs}#3#",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:green}#4# in #5#{} chance to upgrade",
                    "level of played poker hand"
                } 
            },
            j_maelmc_solrock = {
                name = "Solrock",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "card in poker hand to become {C:hearts}#3#",
                    "{br:3}ERROR - CONTACT STEAK",
                    "If a non-{C:hearts}Hearts{} card didn't",
                    "become {C:hearts}Hearts{}, {C:green}#4# in #5#{} chance",
                    "to enhance it to {C:attention}Wild"
                } 
            },
            j_maelmc_inkay = {
                name = "Inkay",
                text = {
                    "Cards have a {C:green}#1# in #2#{} chance to",
                    "be drawn {C:attention}face down{}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Played face down cards give",
                    "{C:red}+#3#{} Mult when scored",
                    "{C:inactive,s:0.8}(Evolves after triggering face down cards {C:attention,s:0.8}#4#{C:inactive,s:0.8} times)"
                } 
            },
            j_maelmc_malamar = {
                name = "Malamar",
                text = {
                    "All cards are drawn {C:attention}face down{}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Played face down cards give",
                    "{X:red,C:white}X#1#{} Mult when scored",
                } 
            },
            j_maelmc_binacle = {
                name = "Binacle",
                text = {
                    "Retriggers {C:attention}first #2# #1#s{} scored",
                    "{C:attention}#4#{} additional time",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Retriggers {C:attention}first #3# #1#s{} held in hand",
                    "{C:attention}#4#{} additional time",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#5#{C:inactive,s:0.8} rounds)"
                } 
            },
            j_maelmc_barbaracle = {
                name = "Barbaracle",
                text = {
                    "Retriggers {C:attention}first #2# #1#s{} scored",
                    "{C:attention}#4#{} additional time",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Retriggers {C:attention}first #3# #1#s{} held in hand",
                    "{C:attention}#4#{} additional time",
                } 
            },
            j_maelmc_ralts = {
                name = "Ralts",
                text = {
                    "{C:red}+#1#{} Mult per {C:attention}hand level",
                    "above 1 {C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                    --[["{br:3}ERROR - CONTACT STEAK",
                    "When {C:attention}Blind{} is selected, create #3#",
                    "{C:planet}Planet{} card of one of",
                    "your lowest level poker hand",
                    "{C:green}#4# in #5#{} chance to create a",
                    "{C:attention}High Priestess{} card instead",]]
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_maelmc_kirlia = {
                name = "Kirlia",
                text = {
                    "{C:red}+#1#{} Mult per {C:attention}hand level",
                    "above 1 {C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                    --[["{br:3}ERROR - CONTACT STEAK",
                    "When {C:attention}Blind{} is selected, create #3#",
                    "{C:dark_edition}Negative{} {C:planet}Planet{} card of one of",
                    "your lowest level poker hand",
                    "{C:green}#4# in #5#{} chance to create a",
                    "{C:dark_edition}Negative {C:attention}High Priestess{} card instead",]]
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_maelmc_gardevoir = {
                name = "Gardevoir",
                text = {
                    "{X:red,C:white}X#1#{} Mult per {C:attention}hand level",
                    "above 1 {C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)",
                    --[["{br:3}ERROR - CONTACT STEAK",
                    "When {C:attention}Blind{} is selected, create #3#",
                    "{C:dark_edition}Negative{} {C:planet}Planet{} card of one of",
                    "your lowest level poker hand",
                    "{C:green}#4# in #5#{} chance to create a",
                    "{C:dark_edition}Negative Black Hole{} card instead",]]
                } 
            },
            j_maelmc_mega_gardevoir = {
                name = "Mega Gardevoir",
                text = {
                    "{C:attention}Holding 2{} {C:spectral}Negative Black Hole{}",
                    "{C:inactive,s:0.8}Devolve and evolve again to get more",
                    --"{br:3}ERROR - CONTACT STEAK",
                    --"{C:attention}Devolves{} when {C:attention}Blind{} is selected",
                } 
            },
            j_maelmc_gible = {
                name = "Gible",
                text = {
                    "If played hand is a {C:attention}Pair{},",
                    "retriggers rightmost #1# cards",
                    "held in hand {C:attention}#2#{} additional time",
                    "and they give {C:red}+#3#{} Mult each",
                    "{C:inactive,s:0.8}(Evolves after retriggering {C:attention,s:0.8}#4#{C:inactive,s:0.8} cards)",
                }
            },
            j_maelmc_gabite = {
                name = "Gabite",
                text = {
                    "If played hand is a {C:attention}Pair{},",
                    "retriggers rightmost #1# cards",
                    "held in hand {C:attention}#2#{} additional time",
                    "and they give {C:red}+#3#{} Mult each",
                    "{C:inactive,s:0.8}(Evolves after retriggering {C:attention,s:0.8}#4#{C:inactive,s:0.8} cards)",
                }
            },
            j_maelmc_garchomp = {
                name = "Garchomp",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{br:3}ERROR - CONTACT STEAK",
                    "If played hand is a {C:attention}Pair{},",
                    "retriggers all cards held in hand",
                    "{C:attention}#2#{} additional time",
                    "and they give {C:red}+#3#{} Mult each",
                }
            },
            j_maelmc_mega_garchomp = {
                name = "Mega Garchomp",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{br:3}ERROR - CONTACT STEAK",
                    "If played hand is a {C:attention}Pair{},",
                    "retriggers all cards held in hand",
                    "of the same rank as the {C:attention}Pair",
                    "{C:attention}#2#{} additional time",
                    "and they give {X:red,C:white}X#3#{} Mult each",
                }
            },
            j_maelmc_ogerpon = {
                name = "Ogerpon",
                text = {
                    --"This Joker cannot change {C:attention}Type",
                    "Holding {C:dark_edition}Negative {C:item}Leaf Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Increases earned money at",
                    "end of round by {C:money}$#1#{} for each",
                    "{C:attention}Lucky{} card that triggered",
                    "Resets when {C:attention}Boss Blind{} is",
                    "defeated {C:inactive}(Currently {C:money}$#2#{C:inactive})",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Retriggers all {C:attention}Lucky{} cards",
                    "{C:attention}#3#{} additional time",
                    "{C:inactive,s:0.8}(Changes form using a {C:attention,s:0.8}Mask{C:inactive,s:0.8})",
                }
            },
            j_maelmc_ogerpon_wellspring = {
                name = "Ogerpon",
                text = {
                    --"This Joker cannot change {C:attention}Type",
                    "Holding {C:dark_edition}Negative {C:item}Water Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Scored {C:attention}Bonus{} cards give",
                    "{X:chips,C:white}X#1#{} their total chips",
                    "{br:3}ERROR - CONTACT STEAK",
                    "If scoring hand contains",
                    "no {C:attention}Bonus{} card,",
                    "create a {C:item}Water Stone",
                    "{C:inactive,s:0.8}(Changes form using a {C:attention,s:0.8}Mask{C:inactive,s:0.8})",
                }
            },
            j_maelmc_ogerpon_hearthflame = {
                name = "Ogerpon",
                text = {
                    --"This Joker cannot change {C:attention}Type",
                    "Holding {C:dark_edition}Negative {C:item}Fire Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each played {C:attention}Mult #1#{} of {V:1}#2#",
                    "gives {X:red,C:white}X#3#{} Mult when scored",
                    "{s:0.8}Card changes every round",
                    "{br:3}ERROR - CONTACT STEAK",
                    "If {C:attention}first played hand{} has exactly {C:attention}1{} card,",
                    "{C:attention}destroy #4#{} random non-{C:attention}Mult{} cards held in hand",
                    "{C:inactive,s:0.8}(Changes form using a {C:attention,s:0.8}Mask{C:inactive,s:0.8})",
                }
            },
            j_maelmc_ogerpon_cornerstone = {
                name = "Ogerpon",
                text = {
                    --"This Joker cannot change {C:attention}Type",
                    "Holding {C:dark_edition}Negative {C:item}Hard Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:attention}Stone{} cards count as their own rank",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Scored {C:attention}Stone{} cards give {C:red}+{} Mult",
                    "equal to {C:attention}#1#/#2#{} of their total chips",
                    "{C:inactive,s:0.8}(Changes form using a {C:attention,s:0.8}Mask{C:inactive,s:0.8})",
                }
            },
            j_maelmc_pokewalker = {
                name = "Pokéwalker",
                text = {
                    "Sell a {C:attention}Joker{} to take it",
                    "for a walk",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Sell this card to retrieve",
                    "the Joker sold and {C:pink}Energize{} it",
                    "by {C:attention}1{} for each round walked with",
                    "{C:inactive}(Currently walking {C:attention}#1#{C:inactive} for {C:attention}#2#{C:inactive} rounds)"
                }
            },
            j_maelmc_galarian_corsola = {
                name = "Galarian Corsola",
                text = {
                    "Each {C:attention}Perishable{} Joker",
                    "gives {X:mult,C:white}X#1#{} Mult",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:attention}Volatile Left{}",
                    "When {C:attention}Blind{} is selected",
                    "add {C:attention}#2# rounds of Perishable{}",
                    "to rightmost Joker",
                    "{C:inactive,s:0.8}(Evolves when you have {C:attention,s:0.8}#3#{C:inactive,s:0.8}/#4# perished Jokers)",
                }
            },
            j_maelmc_cursola = {
                name = "Cursola",
                text = {
                    "Each {C:attention}Perishable{} Joker",
                    "gives {X:mult,C:white}X#1#{} Mult",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:attention}Volatile Left{}",
                    "When {C:attention}Blind{} is selected",
                    "add {C:attention}#2# rounds of Perishable{}",
                    "to all other Jokers",
                }
            },
            --[[j_maelmc_guzzlord = {
                name = "Guzzlord",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult",
                    "when a Joker",
                    "{C:attention}self destructs{}",
                    "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)",
                }
            },]]
            j_maelmc_tropius = {
                name = "Tropius",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{C:green}#1# in #2#{} chance to",
                    "create a {C:attention}banana",
                    "if you have none",
                }
            },
            j_maelmc_pc = {
                name = "PC",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "stores {C:attention}Joker{} to the right",
                    "{C:inactive,s:0.8}Cannot store {C:attention,s:0.8}PC",
                    "{C:inactive,s:0.8}Devolves {C:attention,s:0.8}Mega{C:inactive,s:0.8} Pokémon before storing them",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Stored Jokers cannot",
                    "score {C:chips}Chips{} and {C:mult}Mult",
                    "{C:inactive}(Stored: {C:attention}#1#{C:inactive}, {C:attention}#2#{C:inactive}, {C:attention}#3#{C:inactive})",
                }
            },
            j_maelmc_deoxys = {
                name = "Deoxys",
                text = {
                    --"Holding {C:dark_edition}Negative {C:attention}Meteorite",
                    --"{br:3}ERROR - CONTACT STEAK",
                    --"When {C:attention}Blind{} is selected,",
                    --"gain {C:chips}+#1#{} hand,",
                    --"{C:red}+#2#{} discard and",
                    --"{C:attention}+#3#{} hand size",
                    "If in this form",
                    "when {C:attention}Blind{} is selected,",
                    "if {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card, add #1#",
                    "permanent copies to deck",
                    "and draw them to {C:attention}hand",

                }
            },
            j_maelmc_deoxys_attack = {
                name = "Deoxys",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:chips}+#1#{} hands",
                }
            },
            j_maelmc_deoxys_defense = {
                name = "Deoxys",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:red}+#1#{} discards",
                }
            },
            j_maelmc_deoxys_speed = {
                name = "Deoxys",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:attention}+#1#{} hand size",
                }
            },
            j_maelmc_woobat = {
                name = "Woobat",
                text = {
                    "If scored hand only contains",
                    "{C:hearts}Hearts{} cards, {C:green}#1# in #2#{} chance",
                    "to add a {C:attention}red seal{} to a",
                    "{C:hearts}Hearts{} card held in hand",
                    "{C:inactive,s:0.8}(Evolves when you have {C:attention,s:0.8}#3#{C:inactive,s:0.8} Hearts",
                    "{C:inactive,s:0.8}with a red seal in your deck)",

                }
            },
            j_maelmc_swoobat = {
                name = "Swoobat",
                text = {
                    "If scored hand only contains",
                    "{C:hearts}Hearts{} cards, {C:green}#1# in #2#{} chance",
                    "to add a {C:attention}red seal{} to each",
                    "{C:hearts}Hearts{} card held in hand",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:hearts}Hearts{C:attention} with a red seal",
                    "{C:attention}can't{} be debuffed"

                }
            },
            j_maelmc_photographer = {
                name = "Photographer",
                text = {
                    --[["Gains {C:red}+#1#{} Mult for each",
                    "Pokémon from the",
                    "{C:attention}Timeless Woods{} encountered",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",]]
                    "{C:attention}+#1# Joker{} available in shop",
                    "{br:2}ERROR - CONTACT STEAK",
                    '"Snap photos of {C:red}#2# species{} from',
                    'the {C:attention}Timeless Woods{}!"',
                    "{C:inactive}(Currently #3#)",
                    "{C:inactive,s:0.8}(Right-click to see remaining eligible species)",

                }
            },
            j_maelmc_bloodmoon_ursaluna = {
                name = "Bloodmoon Ursaluna",
                text = {
                    "Played {C:hearts}#1#{} cards multiply",
                    "this Joker's {X:red,C:white}X{} Mult by {X:red,C:white}X#2#{}",
                    "{C:inactive}(Currently {X:red,C:white}X#4#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}(Resets every hand)",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Increases the multiplier by {X:red,C:white}X#3#{}",
                    "when any {C:attention}Booster Pack{} is skipped",

                }
            },
            j_maelmc_nihilego = {
                name = "Nihilego",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:chips}+#3#{} Chips for each",
                    "remaining card in {C:attention}deck",
                    "{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)",
                }
            },
            j_maelmc_buzzwole = {
                name = "Buzzwole",
                text = {
                    "{C:chips}+#1#{} hands",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{X:red,C:white}X#3#{} Mult per remaining hands",
                    "on the {C:attention}first hand{} of round",
                }
            },
            j_maelmc_pheromosa = {
                name = "Pheromosa",
                text = {
                    "{C:red}+#1#{} discards",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Earn {C:money}$#3#{} per discard",
                    "if {C:attention}poker hand{} is a",
                    "{C:attention}Four of a Kind{} or above",
                }
            },
            j_maelmc_xurkitree = {
                name = "Xurkitree",
                text = {
                    "{C:pink}+#1#{} Energy Limit",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Earn {C:money}$#3#{} at end of round per",
                    "{C:pink}Energy{} usable on other Jokers",
                    "{C:inactive}(Currently {C:money}$#4#{C:inactive})",
                }
            },
            j_maelmc_celesteela = {
                name = "Celesteela",
                text = {
                    "{C:attention}+#1#{} consumable slots",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "When {C:attention}Blind{} is selected,",
                    "gains {X:red,C:white}X#3#{} Mult per",
                    "empty consumable slot",
                    "{C:inactive}(Currently {X:red,C:white}X#4#{C:inactive})",
                }
            },
            j_maelmc_kartana = {
                name = "Kartana",
                text = {
                    "{C:attention}+#1#{} card selection in Boosters",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "This Joker gains {C:mult}+#3#{} Mult per",
                    "{C:attention}remaining{} card selection when",
                    "any {C:attention}Booster Pack{} is skipped",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive})",
                }
            },
            j_maelmc_stakataka = {
                name = "Stakataka",
                text = {
                    "{C:attention}+#1#{} Voucher slot available in shop",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Earn {C:money}$#3#{} at end of round",
                    "per Voucher slot, {C:money}-$#3#",
                    "when a Voucher is bought",
                    "Resets when {C:attention}Boss Blind{} is",
                    "defeated {C:inactive}(Currently {C:money}$#4#{C:inactive})"
                }
            },
            j_maelmc_blacephalon = {
                name = "Blacephalon",
                text = {
                    "{C:attention}+#1#{} card slot available in shop",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#2#{} more times",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:red}+#3#{} Mult per card slot in shop",
                    "{C:red}-#4#{} Mult per card bought",
                    "except Vouchers and Boosters",
                    "Resets when {C:attention}Boss Blind{} is",
                    "defeated {C:inactive}(Currently {C:red}+#5#{C:inactive} Mult)"
                }
            },
            j_maelmc_guzzlord = {
                name = "Guzzlord",
                text = {
                    "At the end of shop, eats",
                    "{C:attention}#1#{} thing(s) and gains",
                    "{X:red,C:white}X#2#{} Mult {C:inactive}(Currently {X:red,C:white}X#3#{C:inactive})",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:dark_edition}Beast Boost{} when {C:pink}energized",
                    "{C:attention}#4#{} more times",
                }
            },
            j_maelmc_bouffalant = {
                name = "Bouffalant",
                text = {
                    "{X:attention,C:white}X#1#{} {C:attention}Boss Blind{} requirement",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Earn {C:money}$#2#{} at end of {C:attention}Boss Blind{}",
                    "round, {C:money}+$#2#{} per times the",
                    "{C:attention}Boss Blind{} triggered",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive})",
                    --"{C:inactive,s:0.8}(Works with all Bosses except Cerulean Bell)"
                }
            },
            j_maelmc_gulpin = {
                name = "Gulpin",
                text = {
                    "{C:attention}Stockpile{} when blind is selected {C:inactive}(#1#)",
                    "{C:attention}Volatile Left{}: Gain {C:money}$#2#{}, {C:money}$#3#{} or {C:money}$#4#{} at end of round",
                    "{C:attention}Volatile Right{}: {X:red,C:white}X#5#{}, {X:red,C:white}X#6#{} or {X:red,C:white}X#7#{} Mult",
                    "{C:inactive,s:0.8}(Evolves after stockpiling {C:attention,s:0.8}#8# {C:inactive,s:0.8}times)"
                }
            },
            j_maelmc_swalot = {
                name = "Swalot",
                text = {
                    "{C:attention}Stockpile{} when blind is selected {C:inactive}(#1#)",
                    "{C:attention}Volatile Left{}: Gain {C:money}$#2#{}, {C:money}$#3#{} or {C:money}$#4#{} at end of round",
                    "{C:attention}Volatile Right{}: {X:red,C:white}X#5#{}, {X:red,C:white}X#6#{} or {X:red,C:white}X#7#{} Mult",
                }
            },
            j_maelmc_mega_malamar = {
                name = "Mega Malamar",
                text = {
                    "Most cards besides this Joker,",
                    "its {C:attention}Mega Stone{} and",
                    "{C:attention}playing cards{} held in hand",
                    "are {C:attention}face down{}",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Played cards give",
                    "{X:red,C:white}X#1#{} Mult when scored",
                }
            },
            j_maelmc_mega_barbaracle = {
                name = "Mega Barbaracle",
                text = {
                    "{C:attention}+#1#{} card selection limit",
                    "{C:attention}+#2#{} hand size",
                    "Debuffs all cards but {C:attention}#3#s",
                    --[[ OLD EFFECT
                    "Retriggers {C:attention}#1#{} played {C:attention}#2#s{}",
                    "{C:inactive,s:0.8}(Divided evenly between scoring {C:attention,s:0.8}#2#s{C:inactive,s:0.8}){}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Retriggers {C:attention}#1#{} held in hand {C:attention}#2#s{}",
                    "{C:inactive,s:0.8}(Divided evenly between held {C:attention,s:0.8}#2#s{C:inactive,s:0.8}){}",
                    ]]
                } 
            },
            j_maelmc_wingull = {
                name = "Wingull",
                text = {
                    "Earn {C:money}$#1#{} for each",
                    "discarded {C:attention}#2#{}, rank",
                    "changes every round",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
                },
            },
            j_maelmc_pelipper = {
                name = "Pelipper",
                text = {
                    "Earn {C:money}$#1#{} for each",
                    "discarded {C:attention}#2#{} or",
                    "{C:money}$#3#{} for discarded cards",
                    "of {C:attention}adjacent ranks{}, rank",
                    "changes every round",
                },
            },
            j_maelmc_wonder_trade = {
                name = "Wonder Trade",
                text = {
                    "At end of shop, trade",
                    "a random Joker with",
                    "your {X:purple,C:white}Nemesis{}",
                    "{C:inactive,s:0.8}(Excluding {C:attention,s:0.8}Wonder Trade{C:inactive,s:0.8})",
                },
            },
            j_maelmc_pokemoncenter = {
                name = "Pokémon Center",
                text = {
                    "Sell this card to remove",
                    "all {C:attention}detrimental stickers",
                    "from your Jokers",
                    "{C:inactive,s:0.8}(Only works with compatible stickers)",
                    "and {C:attention}un-debuff{} them",
                    "{C:inactive,s:0.8}(Might get debuffed right back)",
                },
            },
            j_maelmc_mean_look = {
                name = "Mean Look",
                text={
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#",
                    "for your {X:purple,C:white}Nemesis{}"
                },
            },
            j_maelmc_sinistea = {
                name = "Sinistea",
                text={
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#2#{C:inactive,s:0.8} rounds)",
                },
            },
            j_maelmc_polteageist = {
                name = "Polteageist",
                text={
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#",
                    "and a free",
                    "{C:attention}#2#",
                },
            },
        },
        Voucher = {
            v_maelmc_pokemart = {
                name = "Poké Mart",
                text = {
                    "{C:item}Item{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop"
                },
            },
            v_maelmc_departmentstore = {
                name = "Department Store",
                text = {
                    "{C:item}Item{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop"
                },
            },
        },
        Other = {
            gym_leader_tag_pool = {
                name = "Tag Pool",
                text = {
                    "{C:money}#1#",
                    "{C:money}#2#",
                    "{C:money}#3#",
                    "{C:money}#4#",
                    "{C:money}#5#",
                    "{C:money}#6#",
                }
            },
            fitem = {
                name = "Form-change Item",
                text = {
                    "When consumed, changes",
                    "form of leftmost or",
                    "selected {C:attention}eligible{} Joker",
                }
            },
            p_maelmc_meteorite_pack = {
                name = "Meteorite Pack",
                text = {
                    "Change {C:attention}Deoxys{}' form",
                },
            },
            ultra_beast = {
                name = "Ultra Beast",
                text = {
                    "{C:pink}Energizing{} doesn't affect this Joker's",
                    "{C:mult}Mult{}, {C:chips}Chips{}, {C:money}${} and {X:mult,C:white}X{} Mult values",
                }
            },
            beast_boost = {
                name = "Beast Boost",
                text = {
                    "Increases this Joker's effect",
                    "when {C:attention}Blind{} is defeated",
                    "based on how energized it is",
                    "{C:inactive,s:0.8}(Requirement increases after",
                    "{C:inactive,s:0.8}each Beast Boost)"
                }
            },
            pc_bug = {
                name = "Known bug",
                text = {
                    "Going back to main menu and",
                    "resuming the run will",
                    "disable all stored Jokers"
                }
            },
            stockpile = {
                name = "Stockpile",
                text = {
                    "A counter that goes up to 3",
                    "that powers up this Joker's ability",
                    "the higher the counter is",
                    "Resets when said ability is used"
                }
            },
            volatile_both = {
              name = "Volatile",
              text = {
                "The following ability only triggers",
                "when this is the leftmost",
                "or rightmost Joker",
                "{C:inactive}(Ignoring {C:attention}Volatile{C:inactive} Pokemon)"
              }
            },
            bouffalant_mp = {
              name = "Multiplayer",
              text = {
                "During PvP blind, triggers when",
                "the remaining hands left for",
                "your opponent updates"
              }
            },
            maelmc_pokerus = {
                name = "Pokérus",
                text = {
                    "This Joker is always",
                    "fully {C:pink}energized{}",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:green}25%{} to spread",
                    "at end of round"
                }
            },
            multiplayer_ex_jok = {
                name = "Multiplayer exclusive",
                text = {
                    "This Joker can only",
                    "appear when using the",
                    "{C:attention}Multiplayer{} mod"
                }
            },
            multiplayer_ex_tag = {
                name = "Multiplayer exclusive",
                text = {
                    "This Tag can only",
                    "appear when using the",
                    "{C:attention}Multiplayer{} mod"
                }
            },
            multiplayer_ex_enh = {
                name = "Multiplayer exclusive",
                text = {
                    "This Enhancement can only",
                    "appear when using the",
                    "{C:attention}Multiplayer{} mod"
                }
            }
        },
    },
    misc = {
        challenge_names = {
            --[[c_maelmc_glimmora = "Glimmora",
            c_maelmc_copperajah = "Copperajah",
            --c_maelmc_spiritomb = "Spiritomb's Short Yet Strong Hand",
            c_maelmc_spiritomb = "Odd Keystone",
            c_maelmc_gym_leader = "Gym Leader",
            c_maelmc_kecleon = "Kecleon",
            c_maelmc_lunatone_solrock = "Lunatone & Solrock",
            c_maelmc_inkay = "Inkay",
            c_maelmc_binacle = "Binacle",
            c_maelmc_ralts = "Ralts",
            c_maelmc_gible = "Gible",
            c_maelmc_teal = "Teal Mask",
            c_maelmc_wellspring = "Wellspring Mask",
            c_maelmc_hearthflame = "Hearthflame Mask",
            c_maelmc_cornerstone = "Cornerstone Mask",]]
            c_maelmc_gym_challenge = "Gym Challenge",
            c_maelmc_tildeathdouspart = "'Til Death Do Us Part",
        },
        dictionary = {
            maelmc_steel_ex = "Steel!",
            maelmc_gmax_steelsurge_ex = "G-Max Steelsurge!",
            maelmc_consume = "Consume",
            maelmc_soul_collected = "Soul collected",
            maelmc_gym_beaten = "Gym beaten",
            maelmc_color_change = "Color Change",
            maelmc_clubs = "Clubs",
            maelmc_hearts = "Hearts",
            maelmc_wild = "Wild",
            maelmc_ivy_cudgle_ex = "Ivy Cudgle!",
            maelmc_pokewalker_taken = "Taken",
            maelmc_pokewalker_walking = "Walking",
            maelmc_cursed_body_dot = "Cursed Body...",
            maelmc_perish_body_dot = "Perish Body...",
            maelmc_banana_ex = "Banana!",
            maelmc_gym_leader_name = "Gym Leader",
            maelmc_trial_captain_name = "Trial Captain",
            maelmc_none = "None",
            maelmc_stored = "Stored",
            maelmc_pc = "PC",
            maelmc_discard = "+#1# Discard",
            maelmc_hearthstamp_ex = "Heartstamp!",
            maelmc_photo_ex = "Photo!",
            maelmc_beast_boost = "Beast Boost",
            maelmc_tic = "Tic",
            maelmc_tac = "Tac",
            maelmc_outoftune_dot = "Out of tune...",
            maelmc_reckless_ex = "Reckless!",
            maelmc_shop_reroll = "Shop reroll",
            maelmc_shop_sign = "Shop sign",
            maelmc_hungry_dot = "Hungry...",
            maelmc_stockpile = "Stockpile",
            maelmc_wondertrade = "Wonder Trade",
            maelmc_healed_ex = "Healed!",
            maelmc_trapped_ex = "Trapped!",
            maelmc_safe = "Safe",

            k_maelmc_meteorite_pack = "Meteorite Pack",
            k_maelmc_ultra_beast = "Ultra Beast",

            background_color = "Custom Background on Main Menu",
            disable_spiritomb = "Disable Spiritomb",
        },
        labels = {
            k_maelmc_ultra_beast = "Ultra Beast",
            maelmc_pokerus = "Pokérus",
        },
        poker_hands = {
            ["Six of a Kind"] = "Six of a Kind",
            ["Seven of a Kind"] = "Seven of a Kind",
            ["Eight of a Kind"] = "Eight of a Kind",
            ["Nine of a Kind"] = "Nine of a Kind",
            ["Ten of a Kind"] = "Ten of a Kind",
            ["Eleven of a Kind"] = "Eleven of a Kind",
            ["Twelve of a Kind"] = "Twelve of a Kind",
            ["Thirteen of a Kind"] = "Thirteen of a Kind",
            ["Flush Six"] = "Flush Six",
            ["Flush Seven"] = "Flush Seven",
            ["Flush Eight"] = "Flush Eight",
            ["Flush Nine"] = "Flush Nine",
            ["Flush Ten"] = "Flush Ten",
            ["Flush Eleven"] = "Flush Eleven",
            ["Flush Twelve"] = "Flush Twelve",
            ["Flush Thirteen"] = "Flush Thirteen",
            ["Barbarakind"] = "Barbarakind",
            ["Barbaraflush"] = "Barbaraflush",
            ["Mega Barbarakind"] = "Mega Barbarakind",
            ["Mega Barbaraflush"] = "Mega Barbaraflush",
            ["Laxing Mega Barbarakind"] = "Laxing Mega Barbarakind",
            ["Laxing Mega Barbaraflush"] = "Laxing Mega Barbaraflush",
        },
        v_dictionary = {
            maelmc_discard = "+#1# Discard",
            maelmc_dollars_minus = "-$#1#",
            maelmc_hand_minus = "-#1# Hand",
            maelmc_discard_minus = "-#1# Discard",
            maelmc_hand_size_minus = "-#1# Hand size",
            maelmc_consumable_slot_minus = "-#1# Consumable slot",
            maelmc_card_slot_minus = "-#1# Card slot",
            maelmc_joker_slot_minus = "-#1# Joker slot",
            maelmc_pack_slot_minus = "-#1# Booster pack slot",
            maelmc_playing_card_minus = "-#1# Playing card",
            maelmc_voucher_slot_minus = "-#1# Voucher slot",
            maelmc_energy_limit_minus = "-#1# Energy limit",
        },
        v_text = {
           ch_c_maelmc_gym_challenge = {"Jokers not matching the Gym Leader's {C:attention}Type{} {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_perish_3 = {"All Jokers {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_ban_no_perish = {"Non-Perishable Jokers are banned"}
        },
    }
}