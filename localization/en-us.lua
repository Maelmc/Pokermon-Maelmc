return {
    descriptions = {
        Back = {
            b_maelmc_hazarddeck = {
                name = "Hazard Deck",
                text = {
                    "At the start of blind,",
                    "add {C:purple,T:m_poke_hazard}1 Hazard{} per #2# cards",
                    "in full deck"
                }
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
        },
        Joker = {
            j_maelmc_glimmet = {
                name = "Glimmet",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(#5# per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each {C:attention}Hazard Card held{} in hand",
                    "gives {C:chips}+#3#{} Chips",
                    "{C:inactive,s:0.8}(Evolves after triggering Hazard Cards {C:attention,s:0.8}#4#{C:inactive,s:0.8} times)"
                }
            },
            j_maelmc_glimmora = {
                name = "Glimmora",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(#4# per #2# cards)",
                    "Decreases cards required by 1",
                    "after triggering {C:purple}#5# Hazard Cards{}",
                    "{C:inactive,s:0.8}(Decreases in {C:attention,s:0.8}#6#{C:inactive,s:0.8} triggers)",
                    "{C:inactive,s:0.8}(Caps at #4# per #4# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each {C:attention}Hazard Card held{} in hand",
                    "gives {C:chips}+#3#{} Chips"
                }
            },
            j_maelmc_cufant = {
                name = "Cufant",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(1 per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Enhance {C:purple}#3# Hazard{} card in hand",
                    "into a {C:attention}Steel{} card",
                    "at the end of round",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#4#{C:inactive,s:0.8} rounds)"
                }
            },
            j_maelmc_copperajah = {
                name = "Copperajah",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(1 per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Enhance {C:purple}#3# Hazards{} cards in hand",
                    "into {C:attention}Steel{} cards",
                    "at the end of round",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:red}+#4#{} Mult for every {C:attention}Steel card",
                    "in your full deck",
                    "{C:inactive}(Currently {C:red}+#5#{C:inactive} Mult)",
                }
            },
            j_maelmc_mega_copperajah = {
                name = "Gigantamax Copperajah",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(1 per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Enhance {C:purple}#3# Hazards{} cards in hand",
                    "into {C:attention}Steel{} cards",
                    "at the end of round",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:red}+#6#{} and {X:red,C:white}X#4#{} Mult for every {C:attention}Steel card",
                    "in your full deck",
                    "{C:inactive}(Currently {C:red}+#7#{C:inactive} and {X:red,C:white}X#5#{C:inactive} Mult)",
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
                name = "Gym Leader",
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
                    "Cards have a {C:green}#1#%{} chance to",
                    "be drawn face down",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Played face down cards give",
                    "{C:red}+#2#{} Mult when scored",
                    "{C:inactive,s:0.8}(Evolves after triggering face down cards {C:attention,s:0.8}#3#{C:inactive,s:0.8} times)"
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
            }
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
                    "When consumed, changes form of leftmost",
                    "or selected {C:attention}eligible{} Joker",
                    "at end of next round",
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
            maelmc_steel = "Steel!",
            maelmc_gmax_steelsurge = "G-Max Steelsurge!",
            maelmc_consume = "Consume",
            maelmc_soul_collected = "Soul collected",
            maelmc_gym_beaten = "Gym beaten",
            maelmc_color_change = "Color Change",
            maelmc_clubs = "Clubs",
            maelmc_hearts = "Hearts",
            maelmc_ivy_cudgle = "Ivy Cudgle!",
            maelmc_pokewalker_taken = "Taken",
            maelmc_pokewalker_walking = "Walking",
            maelmc_cursed_body_dot = "Cursed Body...",
            maelmc_perish_body_dot = "Perish Body...",
        },
        v_text = {
           ch_c_maelmc_gym_challenge = {"Jokers not matching the Gym Leader's {C:attention}Type{} {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_perish_3 = {"All Jokers {C:attention}perish{} after 3 rounds"},
           ch_c_maelmc_ban_no_perish = {"Non-Perishable Jokers are banned"}
        },
    }
}