local glimmora = {
    object_type = "Challenge",
    key = "glimmora",
    jokers = {
        {id = "j_poke_jynx"},
        {id = "j_poke_jirachi_copy"},
        {id = "j_maelmc_glimmora"},
        {id = "j_poke_gigalith"},
        {id = "j_poke_golurk"},
    },
}

local copperajah = {
    object_type = "Challenge",
    key = "copperajah",
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

--[[local spiritomb = {
    object_type = "Challenge",
    key = "spiritomb",
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
--}]]

local spiritomb = {
    object_type = "Challenge",
    key = "spiritomb",
    jokers = {
        {id = "j_maelmc_odd_keystone"},
        {id = "j_poke_persian"},
        {id = "j_poke_magmortar"},
        {id = "j_poke_tall_grass"},
    },
    consumeables = {
        {id = "c_soul"},
        {id = "c_hermit"},
    },
}

local gym_leader = {
    object_type = "Challenge",
    key = "gym_leader",
    jokers = {
        {id = "j_maelmc_gym_leader"},
    },
}

local kecleon = {
    object_type = "Challenge",
    key = "kecleon",
    jokers = {
        {id = "j_maelmc_kecleon"},
        {id = "j_poke_treasure_eatery"},
    },
    consumeables = {
        {id = "c_poke_dragonscale"},
        {id = "c_poke_pokeball"},
    },
}

return {name = "Challenges", 
        list = {glimmora, copperajah, spiritomb, gym_leader, kecleon}
}