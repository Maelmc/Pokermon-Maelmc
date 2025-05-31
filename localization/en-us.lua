return {
    descriptions = {
        Back = {
            b_maelmc_hazardtest = {
                name = "Hazard Test",
                text = {
                    "Starts with {C:item,T:j_poke_jynx}Jynx{},",
                    "{C:item,T:j_maelmc_glimmet}Glimmet{},",
                    "{C:item,T:j_maelmc_glimmora}Glimmora{},",
                    "{C:item,T:j_poke_gigalith}Gigalith{} and",
                    "{C:item,T:j_poke_golurk}Golurk{}"
                }
            },
            b_maelmc_hazardstack = {
                name = "Hazard Stack",
                text = {
                    "Starts with {C:item,T:j_maelmc_glimmet}Glimmet{}.",
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
                    "Turns {C:purple}#3# Hazard{} in hand",
                    "into {C:attention}Steel",
                    "at the end of round",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#4#{C:inactive,s:0.8} rounds)"
                }
            },
            j_maelmc_copperajah = {
                name = "Copperajah",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(1 per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Turns {C:purple}#3# Hazard{} in hand",
                    "into {C:attention}Steel",
                    "at the end of round"
                }
            },
            j_maelmc_gmax_copperajah = {
                name = "Gigantamax Copperajah",
                text = {
                    "{C:purple}+#1# Hazards {C:inactive}(1 per #2# cards)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Turns {C:purple}#3# Hazard{} in hand",
                    "into {C:attention}Steel",
                    "at the end of round",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{X:red,C:white}X#4#{} Mult for every {C:attention}Steel{} card",
                    "in your full deck",
                    "{C:inactive}(Currently {X:red,C:white}X#5#{C:inactive} Mult)",
                }
            },
        },
        misc = {
            achievement_names = {

            },
            achievement_descriptions = {
            
            },
            challenge_names = {
                c_maelmc_cufant_test = "Cufant Test",
            },
        }
    }
}