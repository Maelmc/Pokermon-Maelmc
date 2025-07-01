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
                    "{C:red}+#4#{} Multi. pour chaque {C:attention}carte Acier",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {C:red}+#5#{C:inactive} Multi.)",
                }
            },
            j_maelmc_mega_copperajah = {
                name = "Pachyradjah Gigamax",
                text = {
                    "{C:purple}+#1# Pièges {C:inactive}(1 pour chaque #2# cartes)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Améliore {C:purple}#3# cartes Piège{} en main",
                    "en cartes {C:attention}Acier",
                    "à la fin de la manche",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:red}+#6#{} et {X:red,C:white}X#4#{} Multi. pour chaque {C:attention}carte Acier",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {C:red}+#7#{C:inactive} et {X:red,C:white}X#5#{C:inactive} Multi.)",
                }
            },
            j_maelmc_odd_keystone = {
                name = "Clé de Voûte",
                text = {
                    "Ne fait rien...?",
                    "{C:inactive,s:0.8}(Évolue après avoir vendu un joker ou un consommable",
                    "{C:inactive,s:0.8}ou avoir détruit une carte {C:attention,s:0.8}#1#{C:inactive,s:0.8}/#2# fois)",
                    --"{C:inactive,s:0.8}(Évolue après avoir utilisé et consommé {C:dark_edition,s:0.8}#3#{C:inactive,s:0.8})"
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
            --[[j_maelmc_spiritombl = {
                name = "Spiritomb",
                text = {
                    "{X:red,C:white}X#1#{} Multi. pour chaque carte",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {X:red,C:white}X#2#{C:inactive} Multi.)",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Devient {C:dark_edition}Négatif{}",
                    "si vous avez au moins {C:attention}108{} cartes",
                    "dans votre jeu complet",
                } 
            },]]
            j_maelmc_gym_leader = {
                name = "Champion d'Arène",
                text = {
                    "Crée un {C:attention}badge{} et une carte {C:pink}Énergie{}",
                    "du type de la {C:attention}Nature",
                    "quand la Blinde de Boss est vaincue",
                } 
            },
            j_maelmc_kecleon = {
                name = "Kecleon",
                text = {
                    "Gagne {C:red}+#1#{} Multi. quand",
                    "ce Joker change de {C:attention}Type{}",
                    "{C:inactive,s:0.8}(Actuellement {C:red}+#2#{} {C:inactive,s:0.8}Multi.)"
                } 
            },
            j_maelmc_lunatone = {
                name = "Séléroc",
                text = {
                    "{C:green}#1# chance sur #2#{} que chaque",
                    "carte dans la main de poker devienne {C:clubs}#3#",
                    "{br:3}ERROR - CONTACT STEAK",
                    "{C:green}#1# chance sur #4#{} d'augmenter",
                    "la main de poker jouée"
                } 
            },
            j_maelmc_solrock = {
                name = "Solaroc",
                text = {
                    "{C:green}#1# chance sur #2#{} que chaque",
                    "carte dans la main de poker devienne {C:hearts}#3#",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Si une carte non-{C:hearts}Cœurs{} n'est",
                    "pas devenue {C:hearts}Cœurs{}, {C:green}#1# chance sur #4#{}",
                    "de l'améliorer en {C:attention}Carte Libre"
                } 
            },
            j_maelmc_inkay = {
                name = "Sépiatop",
                text = {
                    "Les cartes ont {C:green}#1#%{} de chance",
                    "d'être piochées face cachée",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Les cartes jouées face cachée",
                    "donnent {C:red}+#2#{} Multi. quand elles scorent",
                    "{C:inactive,s:0.8}(Évolue après avoir déclenché {C:attention,s:0.8}#3#{C:inactive,s:0.8} cartes face cachée)"
                } 
            },
            j_maelmc_malamar = {
                name = "Sépiatroce",
                text = {
                    "Tous les cartes sont",
                    "piochées face cachée",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Les cartes jouées face cachée",
                    "donnent {X:red,C:white}X#1#{} Multi.",
                    "quand elles marquent des points"
                } 
            },
            j_maelmc_binacle = {
                name = "Opermine",
                text = {
                    "Redéclenche les {C:attention}#2# premiers #1#{}",
                    "joués {C:attention}#4#{} fois",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Redéclenche les {C:attention}#3# premiers #1#{}",
                    "en main {C:attention}#4#{} fois",
                    "{C:inactive,s:0.8}(Évolue après {C:attention,s:0.8}#5#{C:inactive,s:0.8} manches)"
                } 
            },
            j_maelmc_barbaracle = {
                name = "Golgopathe",
                text = {
                    "Redéclenche les {C:attention}#2# premiers #1#{}",
                    "joués {C:attention}#4#{} fois",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Redéclenche les {C:attention}#3# premiers #1#{}",
                    "en main {C:attention}#4#{} fois",
                } 
            },
        },
        Other = {
            gym_leader_tag_pool = {
                name = "Pool de badges",
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
            c_maelmc_glimmora = "Floréclat",
            c_maelmc_copperajah = "Pachyradjah",
            --c_maelmc_spiritomb = "Main petite mais costaud de Spiritomb"
            c_maelmc_spiritomb = "Clé de Voûte",
            c_maelmc_gym_leader = "Champion d'Arène",
            c_maelmc_kecleon = "Kecleon",
            _maelmc_lunatone_solrock = "Séléroc & Solaroc",
            c_maelmc_inkay = "Sépiatop",
            c_maelmc_binacle = "Opermine",
        },
        dictionary = {
            maelmc_steel_ex = "Acier!",
            maelmc_gmax_steelsurge_ex = "Percée G-Max!",
            maelmc_consume = "Consomme",
            maelmc_soul_collected = "Âme collectée",
            maelmc_gym_beaten = "Arène battue",
            maelmc_color_change = "Homochromie",
            maelmc_clubs = "Trèfles",
            maelmc_hearts = "Cœurs",
        }
    }
}