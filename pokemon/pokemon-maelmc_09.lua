-- Glimmora 969
local glimmet={
  name = "glimmet",
  gen = 9,
  poke_custom_prefix = "maelmc",
  pos = {x = 16, y = 64},
  config = {extra = {hazard_level = 1, chips = 20, hazard_triggered = 0}, evo_rqmt = 10},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    local hazard_count = 0
    if G.hand then
      for _, v in pairs(G.hand.cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          hazard_count = hazard_count + 1
        end
      end
    end
    return {vars = {abbr.hazard_level, abbr.chips, hazard_count * abbr.chips, math.max(0, self.config.evo_rqmt - abbr.hazard_triggered)}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- scoring hazards
    if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          if not context.blueprint then
            card.ability.extra.hazard_triggered = card.ability.extra.hazard_triggered + 1
          end
          local hazard_count = 0
          for _, v in pairs(G.hand.cards) do
            if SMODS.has_enhancement(v, "m_poke_hazard") then
              hazard_count = hazard_count + 1
            end
          end
          return {
              chips = hazard_count * card.ability.extra.chips,
              card = card
          }
      end
    end
    return scaling_evo(self, card, context, "j_maelmc_glimmora", card.ability.extra.hazard_triggered, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    poke_change_hazard_level(card.ability.extra.hazard_level)
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end,
}

-- Glimmora 970
local glimmora={
  name = "glimmora",
  gen = 9,
  pos = {x = 18, y = 64},
  config = {extra = {hazard_level = 1, hazard_max = 1, chips = 20, base_increase = 25, req_increase = 5, increase_in = 20, increase_by = 1}},
  poke_custom_values_to_keep = {"hazard_level", "hazard_max", "chips", "base_increase", "req_increase", "increase_in", "increase_by"},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    local hazard_count = 0
    if G.hand then
      for _, v in pairs(G.hand.cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          hazard_count = hazard_count + 1
        end
      end
    end
    return {vars = {abbr.hazard_level, abbr.hazard_max, abbr.increase_by, abbr.increase_in, abbr.req_increase, abbr.chips, abbr.chips * hazard_count}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- scoring hazards
    if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          if not context.blueprint then
            card.ability.extra.increase_in = card.ability.extra.increase_in - 1
            if card.ability.extra.increase_in <= 0 then
              card.ability.extra.base_increase = card.ability.extra.base_increase + card.ability.extra.req_increase
              card.ability.extra.increase_in = card.ability.extra.base_increase
              card.ability.extra.hazard_level = card.ability.extra.hazard_level + card.ability.extra.increase_by
              card.ability.extra.hazard_max = card.ability.extra.hazard_max + card.ability.extra.increase_by
              poke_change_hazard_max(1)
              poke_change_hazard_level(1)
            end
          end
          local hazard_count = 0
          for _, v in pairs(G.hand.cards) do
            if SMODS.has_enhancement(v, "m_poke_hazard") then
              hazard_count = hazard_count + 1
            end
          end
          return {
              chips = hazard_count * card.ability.extra.chips,
              card = card
          }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = (function()
        poke_change_hazard_max(card.ability.extra.hazard_max)
        poke_change_hazard_level(card.ability.extra.hazard_level)
        return true
      end)
    }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_max(-card.ability.extra.hazard_max)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end,
  megas = {"mega_glimmora"},
}

local mega_glimmora={
  name = "mega_glimmora",
  gen = 9,
  pos = {x = 0, y = 2},
  soul_pos = {x = 1, y = 2},
  config = {extra = {chips_mod = 50, hazard_level = 1, hazard_max = 1, chips = 0, base_increase = 0, req_increase = 0, increase_in = 0, increase_by = 0}},
  poke_custom_values_to_keep = {"hazard_level", "hazard_max", "chips", "base_increase", "req_increase", "increase_in", "increase_by"},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    local hazard_count = 0
    if G.playing_cards then
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          hazard_count = hazard_count + 1
        end
      end
    end
    return {vars = {abbr.hazard_level, abbr.hazard_max, abbr.chips_mod, abbr.chips_mod * hazard_count}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Earth",
  atlas = "maelmc_jokers",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.first_hand_drawn then
      local to_draw = {}
      for _, v in pairs(G.deck.cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          to_draw[#to_draw+1] = v
        end
      end
      SMODS.calculate_context({drawing_cards = true, amount = #to_draw})
      for k, v in pairs(to_draw) do
        draw_card(G.deck,G.hand, k*100/#to_draw,'up', true, v)
      end
    end
    -- scoring hazards
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local hazard_count = 0
        for _, v in pairs(G.playing_cards) do
          if SMODS.has_enhancement(v, "m_poke_hazard") then
            hazard_count = hazard_count + 1
          end
        end
        return {
          chips = hazard_count * card.ability.extra.chips_mod
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
      func = (function()
        poke_change_hazard_max(card.ability.extra.hazard_max)
        poke_change_hazard_level(card.ability.extra.hazard_level)
        return true
      end)
    }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_max(-card.ability.extra.hazard_max)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end,
}

-- Poltchageist
local poltchageist = {
  name = "poltchageist",
  gen = 9,
  config = { extra = { rounds = 4 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_maelmc_spell_tag', set = 'Tag' }
    return {vars = {localize { type = 'name_text', set = 'Tag', key = "tag_maelmc_spell_tag" }, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_maelmc_spell_tag'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
      return nil, true -- This is for Joker retrigger purposes
    end

    return level_evo(self, card, context, "j_maelmc_sinistcha")
  end,
}

-- Sinistcha
local sinistcha = {
  name = "sinistcha",
  gen = 9,
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_maelmc_spell_tag', set = 'Tag' }
    info_queue[#info_queue + 1] = { key = 'tag_ethereal', set = 'Tag' }
    return {vars = {localize { type = 'name_text', set = 'Tag', key = "tag_maelmc_spell_tag" },localize { type = 'name_text', set = 'Tag', key = "tag_ethereal" }}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_maelmc_spell_tag'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))

      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_ethereal'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
      return nil, true -- This is for Joker retrigger purposes
    end
  end,
}

local ogerpon={
  name = "ogerpon", 
  gen = 9,
  pos = {x = 4, y = 4},
  soul_pos = {x = 5, y = 4},
  config = {extra = {money = 0, money_mod = 2, retriggers = 1, beat_boss = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Leaf Stone"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    return {vars = {card.ability.extra.money_mod, card.ability.extra.money, card.ability.extra.retriggers}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Grass",
  atlas = "AtlasJokersBasicGen09",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- cannot change type
    --[[if not context.blueprint then
      local type = get_type(card)
      if type ~= self.ptype then
        apply_type_sticker(card, card.ability.extra.type)
      end
    end]]

    -- increase money earned when lucky trigger
    if context.individual and context.cardarea == G.play and context.other_card.lucky_trigger and not context.blueprint then
      card.ability.extra.money = card.ability.extra.money  + card.ability.extra.money_mod
      return {
          message = localize("maelmc_ivy_cudgle_ex"),
          colour = G.C.MONEY,
          card = card
        }
    end

    -- retrigger lucky
    if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card,"m_lucky") then
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end

    if (context.end_of_round and G.GAME.blind.boss) and not context.blueprint then
      card.ability.extra.beat_boss = true
    end

    if context.starting_shop and card.ability.extra.beat_boss then
      card.ability.extra.beat_boss = false
      card.ability.extra.money = 0
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end

  end,
  calc_dollar_bonus = function(self, card)
    return ease_poke_dollars(card, "ogerpon", card.ability.extra.money, true)
	end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Grass")
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_leafstone")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
}

local ogerpon_wellspring={
  name = "ogerpon_wellspring",
  gen = 9,
  pos = {x = 2, y = 5},
  soul_pos = {x = 3, y = 5},
  config = {extra = {Xchips_multi = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Water Stone"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    return {vars = {card.ability.extra.Xchips_multi, card.ability.extra.chips}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Water",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- cannot change type
    --[[if not context.blueprint then
      local type = get_type(card)
      if type ~= self.ptype then
        apply_type_sticker(card, card.ability.extra.type)
      end
    end]]

    -- bonus cards give x3 their total chips on top of their chips, like Wigglytuff
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        local total_chips = poke_total_chips(context.other_card)
        return {
          message = localize("maelmc_ivy_cudgle_ex"),
          colour = G.C.CHIPS,
          chips = total_chips*card.ability.extra.Xchips_multi,
          card = card
        }
      end
    end

    -- if hand contains no Bonus card, create a Water Stone
    if context.cardarea == G.jokers and context.scoring_hand and context.before then
      local bonus = false
      for _, v in pairs(context.scoring_hand) do
        if SMODS.has_enhancement(v, "m_bonus") then
          bonus = true
          break
        end
      end
      if not bonus and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        return {
          extra = {focus = (context.blueprint_card or card), message = localize('poke_plus_pokeitem'), colour = G.ARGS.LOC_COLOURS.pink, func = function()
            G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.0,
              func = function()
                local _card = create_card('Item',G.consumeables, nil, nil, nil, nil, "c_poke_waterstone")
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                G.GAME.consumeable_buffer = 0
                return true
              end
            }))
          end}
        }
      end
    end

    --[[
    -- give fourth root of current chips as xmult
    if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      -- _G.hand_chips for current total chips
      -- _G.mult for current total mult
      local current_chips = _G.hand_chips
      return {
        colour = G.C.MULT,
        xmult = (current_chips)^(1/4),
        card = card
      }
    end]]

  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Water")
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_waterstone")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
}

local ogerpon_hearthflame={
  name = "ogerpon_hearthflame",
  gen = 9,
  pos = {x = 8, y = 4},
  soul_pos = {x = 9, y = 4},
  config = {extra = {Xmult_multi = 3, delete = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Fire Stone"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_mult
    local hearthflame_card = G.GAME.current_round.maelmc_hearthflame_card or {rank = "Ace", suit = "Spades"}
    return {vars = {localize(hearthflame_card.rank, "ranks"), localize(hearthflame_card.suit, "suits_plural"), card.ability.extra.Xmult_multi, card.ability.extra.delete, colours = {G.C.SUITS[hearthflame_card.suit]}}}
  end,
  designer = "One Punch Idiot, Gem",
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Fire",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- cannot change type
    --[[if not context.blueprint then
      local type = get_type(card)
      if type ~= self.ptype then
        apply_type_sticker(card, card.ability.extra.type)
      end
    end]]

    -- delete n non-mult cards held in hand when 1st hand played has 1 card
    if context.before and G.GAME.current_round.hands_played == 0 and context.full_hand and #context.full_hand == 1 then
      local deleted = false
      for _ = 1, card.ability.extra.delete do
        local non_mult_card = {}
        for _, v in pairs(G.hand.cards) do
          if not SMODS.has_enhancement(v, "m_mult") then
            non_mult_card[#non_mult_card+1] = v
          end
        end
        local to_delete = pseudorandom_element(non_mult_card, 'maelmc_ogerpon_hearthflame')
        if to_delete then
          deleted = true
          poke_remove_card(to_delete, card)
        end
      end
      if deleted then
        card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = localize("maelmc_ivy_cudgle_ex"), colour = G.C.MULT})
      end
    end

    -- scoring
    if context.individual and context.cardarea == G.play and
      context.other_card:get_id() == G.GAME.current_round.maelmc_hearthflame_card.id and
      context.other_card:is_suit(G.GAME.current_round.maelmc_hearthflame_card.suit) and
      SMODS.has_enhancement(context.other_card,"m_mult") then
        return {
            colour = G.C.MULT,
            xmult = card.ability.extra.Xmult_multi
        }
    end

    -- juice until 1st hand played
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return (G.GAME.current_round.hands_played == 0) and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Fire")
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_firestone")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
}

local ogerpon_cornerstone={
  name = "ogerpon_cornerstone",
  gen = 9,
  pos = {x = 6, y = 5},
  soul_pos = {x = 7, y = 5},
  config = {extra = {mult = 1, mult_divide = 10}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Hard Stone"}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_divide}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Earth",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- stone cards as their own rank in the lovely patch
    -- rank defined in pokermon-maelmc.lua

    -- cannot change type
    --[[if not context.blueprint then
      local type = get_type(card)
      if type ~= self.ptype then
        apply_type_sticker(card, card.ability.extra.type)
      end
    end]]

    if context.before and context.cardarea == G.jokers then
      local stonecount = 0
      for _, v in pairs(context.full_hand) do
        if SMODS.has_enhancement(v,"m_stone") then
          stonecount = stonecount + 1
        end
      end
      if stonecount >= 3 or stonecount == 2 and (context.scoring_name == "Pair" or context.scoring_name == "Two Pair" or context.scoring_name == "Full House") then
        return {
          message = localize("maelmc_ivy_cudgle_ex"),
          colour = G.C.GREY,
        }
      end
    end

    -- stones give n/10th of their chips as +mult
    if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card,"m_stone") then
      local total_chips = poke_total_chips(context.other_card)
      return {
          colour = G.C.MULT,
          mult = total_chips * card.ability.extra.mult / card.ability.extra.mult_divide
      }
    end
    
  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Earth")
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      local _card = create_card("Item", G.consumeables, nil, nil, nil, nil, "c_poke_hardstone")
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
    end
  end,
}

return {
  name = "Maelmc's Jokers Gen 9",
  list = {
    glimmet, glimmora, mega_glimmora,
    poltchageist, sinistcha,
    ogerpon, ogerpon_wellspring, ogerpon_hearthflame, ogerpon_cornerstone,
  },
}