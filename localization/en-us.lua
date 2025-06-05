return {
    descriptions = {
        Back = {
            b_maelmc_hazarddeck = {
                name = "Hazard Deck",
                text = {
                    "Starts with",
                    "{C:item,T:j_maelmc_glimmet}Glimmet{} and {C:item,T:j_maelmc_cufant}Cufant{}.",
                    "At the star of blind,",
                    "add {C:purple,T:m_poke_hazard}1 Hazard{} per #2# cards"
                }
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
            j_maelmc_gmax_copperajah = {
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
                    "Does nothing...?",
                    "{C:inactive,s:0.8}(Evolves after selling a joker or a consumable",
                    "{C:inactive,s:0.8}or destroying a card {C:attention,s:0.8}#1#{C:inactive,s:0.8}/#2# times)",
                    "{C:inactive,s:0.8}(Evolves after using and consuming {C:dark_edition,s:0.8}#3#{C:inactive,s:0.8})"
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
            j_maelmc_spiritombl = {
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
            },
            j_maelmc_gym_leader = {
                name = "Gym Leader",
                text = {
                    "Creates a {C:attention}tag{} and an {C:pink}Energy{} card",
                    "when Boss Blind is defeated",
                } 
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
    },
},
    misc = {
        challenge_names = {
            c_maelmc_glimmora_test = "Glimmora",
            c_maelmc_copperajah_test = "Copperajah",
            --c_maelmc_spiritomb_test = "Spiritomb's Short Yet Strong Hand",
            c_maelmc_spiritomb_test = "Odd Keystone"
        },
        dictionary = {
            maelmc_steel = "Steel!",
            maelmc_gmax_steelsurge = "G-Max Steelsurge!",
            maelmc_consume = "Consume",
            maelmc_soul_collected = "Soul collected",
            maelmc_gym_beaten = "Gym beaten",
        }
    }
}