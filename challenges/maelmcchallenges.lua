local glimmora_test = {
    object_type = "Challenge",
    key = "glimmora_test",
    jokers = {
        {id = "j_poke_jynx"},
        {id = "j_poke_jirachi_copy"},
        {id = "j_maelmc_glimmora"},
        {id = "j_poke_gigalith"},
        {id = "j_poke_golurk"},
    },
}

local copperajah_test = {
    object_type = "Challenge",
    key = "copperajah_test",
    jokers = {
        {id = "j_poke_jynx"},
        {id = "j_maelmc_copperajah"},
        {id = "j_poke_magnezone"},
        {id = "j_poke_aggron"},
        {id = "j_poke_hitmonchan"},
    },
    consumeables = {
        {id = "c_poke_megastone"},
        {id = "c_poke_metalcoat"},
    },
}

local spiritomb_test = {
    object_type = "Challenge",
    key = "spiritomb_test",
    jokers = {
        {id = "j_poke_dragonite"},
        {id = "j_poke_golem"},
        {id = "j_maelmc_spiritomb"},
        {id = "j_poke_muk"},
        {id = "j_poke_hitmonchan"},
    },
    --[[deck = {
      cards = {{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
                {s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},{s='D',r='A'},
        },
      type = 'Challenge Deck',
    },]]
}

return {name = "Challenges", 
        list = {glimmora_test, copperajah_test, spiritomb_test}
}