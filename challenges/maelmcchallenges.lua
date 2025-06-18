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
    deck = {
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
    },
}]]

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

local lunatone_solrock = {
    object_type = "Challenge",
    key = "lunatone_solrock",
    jokers = {
        {id = "j_maelmc_lunatone"},
        {id = "j_maelmc_solrock"},
        {id = "j_poke_venonat"},
    },
    consumeables = {
        {id = "c_world"},
        {id = "c_star"},
    },
}

local inkay = {
    object_type = "Challenge",
    key = "inkay",
    jokers = {
        {id = "j_maelmc_inkay"},
        {id = "j_poke_raticate"},
    },
}

local binacle = {
    object_type = "Challenge",
    key = "binacle",
    jokers = {
        {id = "j_poke_mankey"},
        {id = "j_poke_oddish"},
        {id = "j_maelmc_binacle"},
    },
    deck = {
      cards = {{s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
        },
      type = 'Challenge Deck',
    },
}

local gible = {
    object_type = "Challenge",
    key = "gible",
    jokers = {
        {id = "j_maelmc_gible"},
    },
    deck = {
      cards = {{s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='7'},{s='H',r='7'},{s='C',r='7'},{s='D',r='7'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
                {s='S',r='8'},{s='H',r='8'},{s='C',r='8'},{s='D',r='8'},
        },
      type = 'Challenge Deck',
    },
}

local ralts = {
    object_type = "Challenge",
    key = "ralts",
    jokers = {
        {id = "j_poke_sentret"},
        {id = "j_poke_natu"},
        {id = "j_maelmc_ralts"},
        {id = "j_poke_elgyem"},
    },
    consumeables = {
        {id = "c_poke_megastone"},
    },
}

return {name = "Challenges", 
        list = {glimmora, copperajah, spiritomb, gym_leader, kecleon, lunatone_solrock, inkay, binacle, ralts, gible}
}