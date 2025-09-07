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
        },
        Spectral = {
            c_maelmc_fake_deoxys = {
                name = "Normal Form",
                text = {
                    "Return to {C:attention}Normal",
                    "{C:inactive,s:0.8}(Applies to leftmost Deoxys)"
                },
            },
            c_maelmc_fake_deoxys_attack = {
                name = "Attack Form",
                text = {
                    "Focus toward {C:attention}Attack",
                    "{C:inactive,s:0.8}(Applies to leftmost Deoxys)"
                },
            },
            c_maelmc_fake_deoxys_defense = {
                name = "Defense Form",
                text = {
                    "Focus toward {C:attention}Defense",
                    "{C:inactive,s:0.8}(Applies to leftmost Deoxys)"
                },
            },
            c_maelmc_fake_deoxys_speed = {
                name = "Speed Form",
                text = {
                    "Focus toward {C:attention}Speed",
                    "{C:inactive,s:0.8}(Applies to leftmost Deoxys)"
                },
            },
        },
        Item = {
            c_maelmc_tealmask = {
                name = "Teal Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Lucky Cards"
                },
            },
            c_maelmc_wellspringmask = {
                name = "Wellspring Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Bonus Cards"
                },
            },
            c_maelmc_hearthflamemask = {
                name = "Hearthflame Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Mult Cards"
                },
            },
            c_maelmc_cornerstonemask = {
                name = "Cornerstone Mask",
                text = {
                    "Enhance {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}Stone Cards"
                },
            },
            c_maelmc_meteorite = {
                name = "Meteorite",
                text = {
                    "Cycle through leftmost or",
                    "selected {C:attention}Deoxys{}' forms",
                    "{C:inactive,s:0.8}(Normal, Attack, Defense, Speed)"
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
                    "{C:green}#1# in #4#{} chance to upgrade",
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
                    "become {C:hearts}Hearts{}, {C:green}#1# in #4#{} chance",
                    "to enhance it to {C:attention}Wild"
                } 
            },
            j_maelmc_inkay = {
                name = "Inkay",
                text = {
                    "Cards have a {C:green}#1# in #2#{} chance to",
                    "be drawn face down",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Played face down cards give",
                    "{C:red}+#3#{} Mult when scored",
                    "{C:inactive,s:0.8}(Evolves after triggering face down cards {C:attention,s:0.8}#4#{C:inactive,s:0.8} times)"
                } 
            },
            j_maelmc_malamar = {
                name = "Malamar",
                text = {
                    "All cards are drawn face down",
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
                    "Holding {C:dark_edition}Negative {C:attention}Leaf Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Increases earned money at",
                    "end of round by {C:money}$#1#{} for each",
                    "{C:attention}Lucky{} card that triggered",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})",
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
                    "Holding {C:dark_edition}Negative {C:attention}Water Stone",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Scored {C:attention}Bonus{} cards give",
                    "{X:chips,C:white}X#1#{} their total chips then",
                    "permanently gain {C:chips}+#2#{} Chips",
                    "{C:inactive,s:0.8}(Changes form using a {C:attention,s:0.8}Mask{C:inactive,s:0.8})",
                    --[["{br:3}ERROR - CONTACT STEAK",
                    "Gives {X:red,C:white}X{} Mult equal to the",
                    "{C:attention}cube root{} of total {C:chips}Chips",]]
                }
            },
            j_maelmc_ogerpon_hearthflame = {
                name = "Ogerpon",
                text = {
                    --"This Joker cannot change {C:attention}Type",
                    "Holding {C:dark_edition}Negative {C:attention}Fire Stone",
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
                    "Holding {C:dark_edition}Negative {C:attention}Hard Stone",
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
            j_maelmc_g_corsola = {
                name = "Galarian Corsola",
                text = {
                    "Each {C:attention}Perishable{} Joker",
                    "gives {X:mult,C:white}X#1#{} Mult",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:attention}Volatile Left{}",
                    "When blind is selected",
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
                    "When blind is selected",
                    "add {C:attention}#2# rounds of Perishable{}",
                    "to all other Jokers",
                }
            },
            j_maelmc_guzzlord = {
                name = "Guzzlord",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult",
                    "when a Joker",
                    "{C:attention}self destructs{}",
                    "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)",
                }
            },
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
                    "Stored Jokers trigger their",
                    "effects that happen during scoring",
                    "{C:inactive}(Stored: {C:attention}#1#{C:inactive}, {C:attention}#2#{C:inactive}, {C:attention}#3#{C:inactive})",
                    "{C:inactive,s:0.8}(Effects that need to reset at some point",
                    "{C:inactive,s:0.8}to work properly, like Barbaracle, might",
                    "{C:inactive,s:0.8}eventually stop working as they",
                    "{C:inactive,s:0.8}reset outside of scoring)",
                }
            },
            j_maelmc_deoxys = {
                name = "Deoxys",
                text = {
                    "Holding {C:dark_edition}Negative {C:attention}Meteorite",
                    "{br:3}ERROR - CONTACT STEAK",
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:chips}+#1#{} hand,",
                    "{C:red}+#2#{} discard and",
                    "{C:attention}+#3#{} hand size",
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
                    "Gains {C:red}+#1#{} Mult for each",
                    "Pokémon from the",
                    "Timeless Woods encountered",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                    " ",
                    '"Snap photos of {C:red}10 species{}!"',
                    "{C:inactive,s:0.8}(Right-click to see your photos)",

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

            k_maelmc_meteorite_pack = "Meteorite Pack",
        },
        v_dictionary = {
            maelmc_discard = "+#1# Discard",
        },
        v_text = {
           ch_c_maelmc_gym_challenge = {"Jokers not matching the Gym Leader's {C:attention}Type{} {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_perish_3 = {"All Jokers {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_ban_no_perish = {"Non-Perishable Jokers are banned"}
        },
    }
}