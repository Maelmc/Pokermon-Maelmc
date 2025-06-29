--[[local glimmora = {
    object_type = "Challenge",
    key = "glimmora",
    jokers = {
        {id = "j_poke_jynx"},
        {id = "j_poke_jirachi_copy"},
        {id = "j_maelmc_glimmora"},
        {id = "j_poke_gigalith"},
        {id = "j_poke_golurk"},
    },
}]]

--[[local copperajah = {
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
}]]

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

--[[local spiritomb = {
    object_type = "Challenge",
    key = "spiritomb",
    jokers = {
        {id = "j_maelmc_odd_keystone"},
        {id = "j_poke_persian"},
        {id = "j_poke_magmortar"},
        {id = "j_poke_tall_grass"},
    },
    consumeables = {
        {id = "c_hermit"},
    },
}]]

local gym_challenge = {
    object_type = "Challenge",
    key = "gym_challenge",
    rules = {
        custom = {
            {id = 'maelmc_gym_challenge'},
            {id = 'maelmc_ban_no_perish'}
        },
    },
    jokers = {
        {id = "j_maelmc_gym_leader", eternal = true, edition = 'negative'},
    }
}

local tildeathdouspart = {
    object_type = "Challenge",
    key = "tildeathdouspart",
    rules = {
        custom = {
            {id = 'maelmc_perish_3'},
            {id = 'maelmc_ban_no_perish'}
        },
    },
    restrictions = {
        banned_cards = {}
    },
    jokers = {
        {id = "j_maelmc_cursola", eternal = true, edition = 'negative'},
    }
}

--[[local kecleon = {
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
}]]

--[[local lunatone_solrock = {
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
}]]

--[[local inkay = {
    object_type = "Challenge",
    key = "inkay",
    jokers = {
        {id = "j_maelmc_inkay"},
        {id = "j_poke_raticate"},
    },
}]]

--[[local binacle = {
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
}]]

--[[local ralts = {
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
}]]

--[[local gible = {
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
    consumeables = {
        {id = "c_poke_megastone"},
    },
}]]

--[[local ogerpon = {
    object_type = "Challenge",
    key = "ogerpon",
    jokers = {
        {id = "j_maelmc_ogerpon"},
        {id = "j_maelmc_ogerpon_wellspring"},
        {id = "j_maelmc_ogerpon_hearthflame"},
        {id = "j_maelmc_ogerpon_cornerstone"},
    },
    deck = {
      cards = {{s='S',r='2',e='m_stone'},{s='H',r='2',e='m_mult'},{s='C',r='2',e='m_bonus'},{s='D',r='2',e='m_lucky'},
            {s='S',r='3',e='m_mult'},{s='H',r='3',e='m_bonus'},{s='C',r='3',e='m_lucky'},{s='D',r='3',e='m_stone'},
            {s='S',r='4',e='m_bonus'},{s='H',r='4',e='m_lucky'},{s='C',r='4',e='m_stone'},{s='D',r='4',e='m_mult'},
            {s='S',r='5',e='m_lucky'},{s='H',r='5',e='m_stone'},{s='C',r='5',e='m_mult'},{s='D',r='5',e='m_bonus'},
            {s='S',r='6',e='m_stone'},{s='H',r='6',e='m_mult'},{s='C',r='6',e='m_bonus'},{s='D',r='6',e='m_lucky'},
            {s='S',r='7',e='m_mult'},{s='H',r='7',e='m_bonus'},{s='C',r='7',e='m_lucky'},{s='D',r='7',e='m_stone'},
            {s='S',r='8',e='m_bonus'},{s='H',r='8',e='m_lucky'},{s='C',r='8',e='m_stone'},{s='D',r='8',e='m_mult'},
            {s='S',r='9',e='m_lucky'},{s='H',r='9',e='m_stone'},{s='C',r='9',e='m_mult'},{s='D',r='9',e='m_bonus'},
            {s='S',r='T',e='m_stone'},{s='H',r='T',e='m_mult'},{s='C',r='T',e='m_bonus'},{s='D',r='T',e='m_lucky'},
            {s='S',r='J',e='m_mult'},{s='H',r='J',e='m_bonus'},{s='C',r='J',e='m_lucky'},{s='D',r='J',e='m_stone'},
            {s='S',r='Q',e='m_bonus'},{s='H',r='Q',e='m_lucky'},{s='C',r='Q',e='m_stone'},{s='D',r='Q',e='m_mult'},
            {s='S',r='K',e='m_lucky'},{s='H',r='K',e='m_stone'},{s='C',r='K',e='m_mult'},{s='D',r='K',e='m_bonus'},
            {s='S',r='A',e='m_stone'},{s='H',r='A',e='m_mult'},{s='C',r='A',e='m_bonus'},{s='D',r='A',e='m_lucky'},
        },
      type = 'Challenge Deck',
    },
}]]

--[[local teal = {
    object_type = "Challenge",
    key = "teal",
    jokers = {
        {id = "j_maelmc_ogerpon"},
    }
}]]

--[[local wellspring = {
    object_type = "Challenge",
    key = "wellspring",
    jokers = {
        {id = "j_maelmc_ogerpon_wellspring"},
    },
    consumeables = {
        {id = "c_maelmc_wellspringmask"},
    },
}]]

--[[local hearthflame = {
    object_type = "Challenge",
    key = "hearthflame",
    jokers = {
        {id = "j_maelmc_ogerpon_hearthflame"},
    },
    consumeables = {
        {id = "c_maelmc_hearthflamemask"},
    },
}]]

--[[local cornerstone = {
    object_type = "Challenge",
    key = "cornerstone",
    jokers = {
        {id = "j_maelmc_ogerpon_cornerstone"},
    },
    consumeables = {
        {id = "c_maelmc_cornerstonemask"},
    },
}]]

return {name = "Challenges",
        list = {
            gym_challenge,
            tildeathdouspart,
            --[[glimmora,
            copperajah,
            spiritomb,
            gym_leader,
            kecleon,
            lunatone_solrock,
            inkay,
            binacle,
            ralts,
            gible,
            --ogerpon,
            teal, wellspring, hearthflame, cornerstone,]]
        }
}