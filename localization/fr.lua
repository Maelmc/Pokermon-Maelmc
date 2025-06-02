return {
    descriptions = {
        Back = {
            b_maelmc_hazarddeck = {
                name = "Jeu piège",
                text = {
                    "Commencez avec",
                    "{C:item,T:j_maelmc_glimmet}Germéclat{} et {C:item,T:j_maelmc_cufant}Charibari{}.",
                    "Au début de la blinde,",
                    "ajoute {C:purple,T:m_poke_hazard}1 Pièges{} pour chaque #2# cartes"
                }
            },
        },
        Joker = {
            j_maelmc_glimmet = {
                name = "Germéclat",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(#5# pour chaque #2# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Chaque {C:attention}Carte Piège{} en main",
                    "octroie {C:chips}+#3#{} Jetons",
                    "{C:inactive,s:0.8}(Évolue après avoir déclenché des Cartes Piège {C:attention,s:0.8}#4#{C:inactive,s:0.8} fois)"
                }
            },
            j_maelmc_glimmora = {
                name = "Floréclat",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(#4# pour chaque #2# cartes)",
                    "Diminue le nombre de cartes requises de 1",
                    "après avoir déclenché {C:purple}#5# Cartes Piège{}",
                    "{C:inactive,s:0.8}(Diminue dans {C:attention,s:0.8}#6#{C:inactive,s:0.8} déclenchements)",
                    "{C:inactive,s:0.8}(Limité à #4# pour chaque #4# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Chaque {C:attention}Carte Piège{} en main",
                    "octroie {C:chips}+#3#{} Jetons",
                }
            },
            j_maelmc_cufant = {
                name = "Charibari",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(1 pour chaque #2# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Améliore {C:purple}#3# carte Piège{} en main",
                    "en une carte {C:attention}Acier",
                    "à la fin de la manche",
                    "{C:inactive,s:0.8}(Évolue après {C:attention,s:0.8}#4#{C:inactive,s:0.8} manches)"
                }
            },
            j_maelmc_copperajah = {
                name = "Pachyradjah",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(1 pour chaque #2# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Améliore {C:purple}#3# cartes Piège{} en main",
                    "en cartes {C:attention}Acier",
                    "à la fin de la manche",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:red}+#4#{} Multi. pour chaque carte {C:attention}Acier",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {C:red}+#5#{C:inactive} Multi.)",
                }
            },
            j_maelmc_gmax_copperajah = {
                name = "Pachyradjah Gigamax",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(1 pour chaque #2# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Améliore {C:purple}#3# cartes Piège{} en main",
                    "en cartes {C:attention}Acier",
                    "à la fin de la manche",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:red}+#6#{} et {X:red,C:white}X#4#{} Multi. pour chaque carte {C:attention}Acier",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {C:red}+#7#{C:inactive} et {X:red,C:white}X#5#{C:inactive} Multi.)",
                }
            },
            j_maelmc_spiritomb = {
                name = "Spiritomb",
                text = {
                    "{C:chips}+#1#{} Jetons",
                    "{C:red}+#2#{} Multi.",
                    "{C:attention}-#3#{} à la taille de main",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Devient {C:dark_edition}Négatif{}",
                    "si vous avez au moins {C:attention}108{} cartes",
                    "dans votre jeu complet",
                } 
            },
        },
    },
    misc = {
        challenge_names = {
            c_maelmc_glimmora_test = "Tas de pièges de Floréclat",
            c_maelmc_copperajah_test = "Pièges métalliques de Pachyradjah",
            c_maelmc_spiritomb_test = "Main petite mais costaud de Spiritomb"
        },
        dictionary = {
            maelmc_steel = "Acier!",
            maelmc_gmax_steelsurge = "Percée G-Max!",
        }
    }
}