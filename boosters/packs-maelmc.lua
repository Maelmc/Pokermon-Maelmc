local meteorite_pack = {
    name = "Meteorite Pack",
    key = "meteorite_pack",
    kind = "Spectral",
    atlas = "maelmc_mart",
    pos = { x = 5, y = 0 },
    config = { extra = 4, choose = 1 },
    cost = 999,
    order = 4,
    weight = 0,
    draw_hand = false,
    unlocked = true,
    discovered = true,
    no_collection = true,
    create_card = function(self, card, i)
        -- force pack_choices to 1
        G.GAME.pack_choices = 1

        local deoxys_cards = {'c_maelmc_fake_deoxys', 'c_maelmc_fake_deoxys_attack', 'c_maelmc_fake_deoxys_defense', 'c_maelmc_fake_deoxys_speed'}
        local temp_card = {area = G.pack_cards, key = deoxys_cards[1 + (i-1)%4], no_edition = true, skip_materialize = true}
        return SMODS.create_card(temp_card)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra - 1, 1 } }
    end,
    in_pool = function(self)
        return false
    end,
    ease_background_colour = function(self)
        --Copy planet packs
        ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.SECONDARY_SET.Planet, G.C.BLACK, 0.9))
        ease_background_colour{new_colour = G.C.BLACK, contrast = 3}
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0,0, {
        timer = 0.07,
        scale = 0.1,
        initialize = true,
        lifespan = 15,
        speed = 0.1,
        padding = -4,
        attach = G.ROOM_ATTACH,
        colours = {G.C.WHITE, HEX('a7d6e0'), HEX('fddca0')},
        fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0,0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE},
            fill = true
        })
    end,
    group_key = "k_maelmc_meteorite_pack",
}

return {name = "Maelmc's Packs",
    list = {
        --meteorite_pack,
    }
}