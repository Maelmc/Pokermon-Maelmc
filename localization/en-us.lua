return {
    descriptions = {
        Back = {
            b_maelmc_hazardtest = {
                name = "Hazard Stack (Glimmora Test)",
                text = {
                    "Starts with {C:item,T:j_poke_jynx}Jynx{},",
                    "{C:item,T:j_maelmc_glimmet}Glimmet{},",
                    "{C:item,T:j_maelmc_glimmora}Glimmora{},",
                    "and 2 {C:item,T:j_poke_gigalith}Gigalith{}"
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
                    "Increases by 5 after triggering {C:purple}#5# Hazard Cards{}",
                    "{C:inactive,s:0.8}(Increases in {C:attention,s:0.8}#6#{C:inactive,s:0.8} triggers)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Each {C:attention}Hazard Card held{} in hand",
                    "gives {C:chips}+#3#{} Chips"
                }
            },
        }
    }
}