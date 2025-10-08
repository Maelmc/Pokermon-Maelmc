-- Ralts 280
local ralts={
  name = "ralts",
  pos = {x = 18, y = 18},
  config = {extra = {mult_mod = 1, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    --info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_high_priestess'}
    local mult = 0
    if (SMODS.Mods["Talisman"] or {}).can_load then
      for _, v in pairs(G.GAME.hands) do
        mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
      end
    else
      for _, v in pairs(G.GAME.hands) do
        mult = mult + (v.level - 1) * card.ability.extra.mult_mod
      end
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = 2,
  cost = 6,
  stage = "Base",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        if (SMODS.Mods["Talisman"] or {}).can_load then
          for _, v in pairs(G.GAME.hands) do
            mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
          end
        else
          for _, v in pairs(G.GAME.hands) do
            mult = mult + (v.level - 1) * card.ability.extra.mult_mod
          end
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

    return level_evo(self, card, context, "j_maelmc_kirlia")
  end,
}

-- Kirlia 281
local kirlia={
  name = "kirlia",
  --poke_custom_prefix = "maelmc",
  pos = {x = 20, y = 18},
  config = {extra = {mult_mod = 2, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    --info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_black_hole'}
    local mult = 0
    if (SMODS.Mods["Talisman"] or {}).can_load then
      for _, v in pairs(G.GAME.hands) do
        mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
      end
    else
      for _, v in pairs(G.GAME.hands) do
        mult = mult + (v.level - 1) * card.ability.extra.mult_mod
      end
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.rounds}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = "poke_safari",
  cost = 7,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        if (SMODS.Mods["Talisman"] or {}).can_load then
          for _, v in pairs(G.GAME.hands) do
            mult = mult + (to_number(v.level) - 1) * card.ability.extra.mult_mod
          end
        else
          for _, v in pairs(G.GAME.hands) do
            mult = mult + (v.level - 1) * card.ability.extra.mult_mod
          end
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

    return level_evo(self, card, context, "j_maelmc_gardevoir")
  end,
}

-- Gardevoir 282
local gardevoir={
  name = "gardevoir",
  --poke_custom_prefix = "maelmc",
  pos = {x = 22, y = 18},
  config = {extra = {Xmult_mod = 0.1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    --info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_black_hole'}
    local xmult = 1
    if (SMODS.Mods["Talisman"] or {}).can_load then
      for _, v in pairs(G.GAME.hands) do
        xmult = xmult + (to_number(v.level) - 1) * card.ability.extra.Xmult_mod
      end
    else
      for _, v in pairs(G.GAME.hands) do
        xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_mod
      end
    end
    return {vars = {card.ability.extra.Xmult_mod, xmult}}
  end,
  designer = "Foxthor, One Punch Idiot",
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xmult = 1
        if (SMODS.Mods["Talisman"] or {}).can_load then
          for _, v in pairs(G.GAME.hands) do
            xmult = xmult + (to_number(v.level) - 1) * card.ability.extra.Xmult_mod
          end
        else
          for _, v in pairs(G.GAME.hands) do
            xmult = xmult + (v.level - 1) * card.ability.extra.Xmult_mod
          end
        end
        if xmult > 1 then
          return {
            colour = G.C.MULT,
            xmult = xmult,
            card = card
          }
        end
      end
    end
  end,
  megas = {"mega_gardevoir"}
}

local mega_gardevoir={
  name = "mega_gardevoir",
  --poke_custom_prefix = "maelmc",
  pos = {x = 6, y = 4},
  soul_pos = { x = 7, y = 4 },
  config = {extra = {blackhole_amount = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Black Hole"}}
    return {vars = {card.ability.extra.blackhole_amount}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen03",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    --[[if context.setting_blind then
      return {
        message = poke_evolve(card, "j_maelmc_gardevoir"),
      }
    end]]
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      for _ = 1,card.ability.extra.blackhole_amount do
        local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_black_hole")
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
      end
    end
  end,
}

-- Gulpin 316
local gulpin={
  name = "gulpin",
  pos = PokemonSprites["gulpin"].base.pos,
  config = {extra = {stockpile = 0, max_stockpile = 3,
    money = 3, money1 = 8, money2 = 15,
    xmult = 1.5, xmult1 = 3, xmult2 = 4.5,
    volatile = "left", volatile2 = "right",
    stockpile_count = 0}, evo_rqmt = 5},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'stockpile'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'volatile_both'}
    local abbr = card.ability.extra
    local stockpile_left = math.max(0, self.config.evo_rqmt - card.ability.extra.stockpile_count)
    return {vars = {abbr.stockpile, abbr.money, abbr.money1, abbr.money2, abbr.xmult, abbr.xmult1, abbr.xmult2, stockpile_left}}
  end,
  poke_custom_values_to_keep = {"stockpile"},
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint and card.ability.extra.stockpile < card.ability.extra.max_stockpile then
      card.ability.extra.stockpile = card.ability.extra.stockpile + 1
      card.ability.extra.stockpile_count = card.ability.extra.stockpile_count + 1
      return {
        message = localize("maelmc_stockpile")
      }
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and volatile_active(self, card, card.ability.extra.volatile2) then
        local xmult = 0
        if card.ability.extra.stockpile == 0 then return nil
        elseif card.ability.extra.stockpile == 1 then xmult = card.ability.extra.xmult
        elseif card.ability.extra.stockpile == 2 then xmult =  card.ability.extra.xmult1
        else xmult = card.ability.extra.xmult2 end
        if not context.blueprint then
          card.ability.extra.stockpile = 0
        end
        return {
          colour = G.C.XMULT,
          Xmult = xmult,
        }
      end
    end

    return scaling_evo(self, card, context, "j_maelmc_swalot", card.ability.extra.stockpile_count, self.config.evo_rqmt)
  end,
  calc_dollar_bonus = function(self, card)
    if volatile_active(self, card, card.ability.extra.volatile) then
      local money = 0
      if card.ability.extra.stockpile == 0 then return nil
      elseif card.ability.extra.stockpile == 1 then money = card.ability.extra.money
      elseif card.ability.extra.stockpile == 2 then money =  card.ability.extra.money1
      else money = card.ability.extra.money2 end
      card.ability.extra.stockpile = 0
      return ease_poke_dollars(card, "gulpin", money, true)
    end
  end
}

-- Swalot 317
local swalot={
  name = "swalot",
  pos = PokemonSprites["swalot"].base.pos,
  config = {extra = {stockpile = 0, max_stockpile = 3,
    money = 5, money1 = 12, money2 = 21,
    xmult = 2, xmult1 = 4, xmult2 = 6,
    volatile = "left", volatile2 = "right"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'stockpile'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'volatile_both'}
    local abbr = card.ability.extra
    return {vars = {abbr.stockpile, abbr.money, abbr.money1, abbr.money2, abbr.xmult, abbr.xmult1, abbr.xmult2}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint and card.ability.extra.stockpile < card.ability.extra.max_stockpile then
      card.ability.extra.stockpile = card.ability.extra.stockpile + 1
      return {
        message = localize("maelmc_stockpile")
      }
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and volatile_active(self, card, card.ability.extra.volatile2) then
        local xmult = 0
        if card.ability.extra.stockpile == 0 then return nil
        elseif card.ability.extra.stockpile == 1 then xmult = card.ability.extra.xmult
        elseif card.ability.extra.stockpile == 2 then xmult =  card.ability.extra.xmult1
        else xmult = card.ability.extra.xmult2 end
        if not context.blueprint then
          card.ability.extra.stockpile = 0
        end
        return {
          colour = G.C.XMULT,
          Xmult = xmult,
        }
      end
    end
  end,
  calc_dollar_bonus = function(self, card)
    if volatile_active(self, card, card.ability.extra.volatile) then
      local money = 0
      if card.ability.extra.stockpile == 0 then return nil
      elseif card.ability.extra.stockpile == 1 then money = card.ability.extra.money
      elseif card.ability.extra.stockpile == 2 then money =  card.ability.extra.money1
      else money = card.ability.extra.money2 end
      card.ability.extra.stockpile = 0
      return ease_poke_dollars(card, "swalot", money, true)
    end
  end
}

-- Lunatone 337
local lunatone={
  name = "lunatone",
  --poke_custom_prefix = "maelmc",
  pos = {x = 12, y = 22},
  config = {extra = {num_clubs = 1, dem_clubs = 4, suit = "Clubs", level_amt = 1, num_level = 1, dem_level = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    local num_clubs, dem_clubs = SMODS.get_probability_vars(card, card.ability.extra.num_clubs, card.ability.extra.dem_clubs, 'lunatone')
    local num_level, dem_level = SMODS.get_probability_vars(card, card.ability.extra.num_level, card.ability.extra.dem_level, 'lunatone')
    return {vars = {num_clubs, dem_clubs, abbr.suit, num_level, dem_level}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      -- turn cards to club
      local clubs_trigg = 0
      for _, v in pairs(context.scoring_hand) do
        if not (v:is_suit(card.ability.extra.suit)) and SMODS.pseudorandom_probability(card, 'lunatone', card.ability.extra.num_clubs, card.ability.extra.dem_clubs, 'lunatone') then
          clubs_trigg = 1
          local rank = v:get_id()
          if rank > 9 then
            if rank == 10 then rank = "T" end
            if rank == 11 then rank = "J" end
            if rank == 12 then rank = "Q" end
            if rank == 13 then rank = "K" end
            if rank == 14 then rank = "A" end
          end
          v:set_base(G.P_CARDS["C_"..rank])
        end
      end
      if clubs_trigg == 1 then
        card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = localize('maelmc_clubs')})
      end

      if SMODS.pseudorandom_probability(card, 'lunatone', card.ability.extra.num_level, card.ability.extra.dem_level, 'lunatone') then
        return {
          level_up = true,
          message = localize('k_level_up_ex')
        }
      end
    end
  end,
}

-- Solrock 338
local solrock={
  name = "solrock",
  --poke_custom_prefix = "maelmc",
  pos = {x = 14, y = 22},
  config = {extra = {num_hearts = 1, dem_hearts = 4, suit = "Hearts", num_wild = 1, dem_wild = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    local abbr = card.ability.extra
    local num_hearts, dem_hearts = SMODS.get_probability_vars(card, card.ability.extra.num_hearts, card.ability.extra.dem_hearts, 'solrock')
    local num_wild, dem_wild = SMODS.get_probability_vars(card, card.ability.extra.num_wild, card.ability.extra.dem_wild, 'solrock')
    return {vars = {num_hearts, dem_hearts, abbr.suit, num_wild, dem_wild}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      -- turn cards to club
      local hearts_trigg = 0
      local wild_trigg = 0
      for _, v in pairs(context.scoring_hand) do
        if not (v:is_suit(card.ability.extra.suit)) then
          if SMODS.pseudorandom_probability(card, 'solrock', card.ability.extra.num_hearts, card.ability.extra.dem_hearts, 'solrock') then
            hearts_trigg = 1
            local rank = v:get_id()
            if rank > 9 then
              if rank == 10 then rank = "T" end
              if rank == 11 then rank = "J" end
              if rank == 12 then rank = "Q" end
              if rank == 13 then rank = "K" end
              if rank == 14 then rank = "A" end
            end
            v:set_base(G.P_CARDS["H_"..rank])
          elseif not (SMODS.has_enhancement(v, "m_wild")) and SMODS.pseudorandom_probability(card, 'solrock', card.ability.extra.num_wild, card.ability.extra.dem_wild, 'solrock') then
            wild_trigg = 1
            v:set_ability(G.P_CENTERS.m_wild,nil,true)
          end
        end
      end
      if hearts_trigg == 1 then
        card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = localize('maelmc_hearts')})
      end
      if wild_trigg == 1 then
        card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = localize('maelmc_wild')})
      end
    end
  end,
}

-- Kecleon 352
local kecleon={
  name = "kecleon",
  --poke_cust1om_prefix = "maelmc",
  pos = {x = 12, y = 23},
  config = {extra = {mult = 0, mult_mod = 6, current_type = "Colorless"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.mult_mod, abbr.mult}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- all context to be futureproof
    if not context.blueprint then
      local type = get_type(card)
      if type ~= card.ability.extra.current_type then
        card.ability.extra.current_type = type
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        self:set_sprites(card)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_color_change')})
      end
    end
    
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and card.ability.extra.mult > 0 then
        return {
          colour = G.C.MULT,
          mult = card.ability.extra.mult,
          card = card
        }
      end
    end
  end,
  set_sprites = function(self,card,front)
    local type_table = {
      Grass = {x = 6, y = 1},
      Fire = {x = 4, y = 1},
      Water = {x = 2, y = 2},
      Lightning = {x = 8, y = 1},
      Psychic = {x = 0, y = 2},
      Fighting = {x = 2, y = 1},
      Colorless = {x = 12, y = 23},
      Dark = {x = 6, y = 0},
      Metal = {x = 10, y = 1},
      Fairy = {x = 0, y = 1},
      Dragon = {x = 8, y = 0},
      Earth = {x = 10, y = 0},
    }
    local type = get_type(card) or "Colorless"
    if type == "Colorless" and card.children.center.atlas.name ~= "poke_AtlasJokersBasicNatdex" then
      card.children.center.atlas = G.ASSET_ATLAS["poke_AtlasJokersBasicNatdex"]
    elseif type ~= "Colorless" and card.children.center.atlas.name ~= "poke_AtlasJokersBasicGen03" then
      card.children.center.atlas = G.ASSET_ATLAS["poke_AtlasJokersBasicGen03"]
    end
    card.children.center:set_sprite_pos(type_table[type])
  end,
  add_to_deck = function(self, card, from_debuff)
    self:set_sprites(card)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      self:set_sprites(card)
    end
  end,
}

-- Tropius 357
local tropius = {
  name = "tropius",
  --poke_custom_prefix = "maelmc",
  pos = {x = 22, y = 23},
  config = {extra = {num_banana = 1, dem_banana = 2, num_cavendish = 1, dem_cavendish = 10}},
  loc_vars = function(self, info_queue, card)
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num_banana, card.ability.extra.dem_banana, 'tropius')
    return {vars = {num, dem}}
  end,
  rarity = 1,
  cost = 7,
  stage = "Basic",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and ((#G.jokers.cards + G.GAME.joker_buffer) < G.jokers.config.card_limit)
    and (#find_joker("Gros Michel") + #find_joker("Cavendish") == 0)
    and SMODS.pseudorandom_probability(card, 'tropius', card.ability.extra.num_banana, card.ability.extra.dem_banana, 'tropius') then
      local banana = nil
      if G.GAME and G.GAME.pool_flags and G.GAME.pool_flags.gros_michel_extinct
      and SMODS.pseudorandom_probability(card, 'tropius', card.ability.extra.num_cavendish, card.ability.extra.dem_cavendish, 'tropius') then
        banana = {set = "Joker", area = G.jokers, key = "j_cavendish"}
      end
      banana = banana or {set = "Joker", area = G.jokers, key = "j_gros_michel"}
      local final_banana = SMODS.create_card(banana)
      final_banana:add_to_deck()
      G.jokers:emplace(final_banana)
      final_banana:start_materialize()
      return {
        message = localize("maelmc_banana_ex")
      }
    end
  end,
}

-- Deoxys 386
local deoxys = {
  name = "deoxys",
  pos = {x = 2, y = 3},
  soul_pos = { x = 3, y = 3},
  config = {extra = {hands = 1, d_size = 1, h_size = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
		return {vars = {center.ability.extra.hands, center.ability.extra.d_size, center.ability.extra.h_size}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen03",
  blueprint_compat = false,
  calculate = function(self,card,context)
    if context.setting_blind then
      ease_hands_played(card.ability.extra.hands)
      ease_discard(card.ability.extra.d_size)
      G.hand:change_size(card.ability.extra.h_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
    end
    if context.end_of_round and card.ability.extra.in_round then
      G.hand:change_size(-card.ability.extra.h_size)
      card.ability.extra.in_round = false
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    local ok = true
    for _, v in pairs(G.consumeables.cards) do
      if v.config.center.name == "meteorite" then
        ok = false
        break
      end
    end
    if ok then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_maelmc_meteorite")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
}

local deoxys_attack = {
  name = "deoxys_attack",
  pos = {x = 4, y = 3},
  soul_pos = { x = 5, y = 3},
  config = {extra = {hands = 3}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
		return {vars = {center.ability.extra.hands}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen03",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self,card,context)
    if context.setting_blind then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  in_pool = function(self)
    return false
  end,
}

local deoxys_defense = {
  name = "deoxys_defense", 
  pos = {x = 6, y = 3},
  soul_pos = { x = 7, y = 3},
  config = {extra = {d_size = 5}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.d_size}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen03",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self,card,context)
    if context.setting_blind then
      ease_discard(card.ability.extra.d_size)
    end
  end,
  in_pool = function(self)
    return false
  end,
}

local deoxys_speed = {
  name = "deoxys_speed",
  pos = { x = 8, y = 3 },
  soul_pos = { x = 9, y = 3 },
  config = { extra = { h_size = 4} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.h_size } }
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicGen03",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self,card,context)
    if context.setting_blind then
      G.hand:change_size(card.ability.extra.h_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
    end
  end,
  in_pool = function(self)
    return false
  end,
}

return {
  name = "Maelmc's Jokers Gen 3",
  list = {
    ralts, kirlia, gardevoir, mega_gardevoir,
    gulpin, swalot,
    lunatone, solrock,
    kecleon,
    tropius,
    deoxys, deoxys_attack, deoxys_defense, deoxys_speed
  },
}