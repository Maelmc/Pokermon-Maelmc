-- Glimmora 969
local glimmet={
  name = "glimmet",
  poke_custom_prefix = "maelmc",
  pos = {x = 16, y = 64},
  config = {extra = {hazards = 4, chips = 10, hazard_triggered = 0}, evo_rqmt = 25},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {abbr.hazards}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    local hazard_count = 0
    if G.playing_cards then
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          hazard_count = hazard_count + 1
        end
      end
    else
      hazard_count = abbr.hazards
    end
    return {vars = {abbr.hazards, abbr.chips, hazard_count * abbr.chips, math.max(0, self.config.evo_rqmt - abbr.hazard_triggered)}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- adding hazards
    if context.setting_blind then
      poke_set_hazards(card.ability.extra.hazards)
    end

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
          for _, v in pairs(G.playing_cards) do
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
}

-- Glimmora 970
local glimmora={
  name = "glimmora",
  pos = {x = 18, y = 64},
  config = {extra = {hazards = 4, chips = 20, base_increase = 25, req_increase = 5, increase_in = 25, increase_by = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {abbr.hazards}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    local hazard_count = 0
    if G.playing_cards then
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          hazard_count = hazard_count + 1
        end
      end
    else
      hazard_count = abbr.hazards
    end
    return {vars = {abbr.hazards, abbr.increase_by, abbr.increase_in, abbr.req_increase, abbr.chips, abbr.chips * hazard_count}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- adding hazards
    if context.setting_blind then
      poke_set_hazards(card.ability.extra.hazards)
    end

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
              card.ability.extra.hazards = card.ability.extra.hazards + card.ability.extra.increase_by
            end
          end
          local hazard_count = 0
          for _, v in pairs(G.playing_cards) do
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
}

local ogerpon={
  name = "ogerpon", 
  pos = {x = 4, y = 4},
  soul_pos = {x = 5, y = 4},
  config = {extra = {money = 2, money_mod = 2, retriggers = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Leaf Stone"}}
    --info_queue[#info_queue+1] = { set = 'Item', key = 'c_poke_leafstone', vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), 3}}
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

  end,
  calc_dollar_bonus = function(self, card)
    if card.ability.extra.money > 0 then
      return ease_poke_dollars(card, "ogerpon", card.ability.extra.money, true)
    end
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
  pos = {x = 2, y = 5},
  soul_pos = {x = 3, y = 5},
  config = {extra = {Xchips_multi = 3, chips = 30}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Water Stone"}}
    --info_queue[#info_queue+1] = {set = 'Item', key = 'c_poke_waterstone', vars = {1, 50}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    return {vars = {card.ability.extra.Xchips_multi, card.ability.extra.chips}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Water",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
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
        context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
        context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
        return {
          message = localize("maelmc_ivy_cudgle_ex"),
          colour = G.C.CHIPS,
          chips = total_chips*card.ability.extra.Xchips_multi,
          card = card
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
  pos = {x = 8, y = 4},
  soul_pos = {x = 9, y = 4},
  config = {extra = {Xmult_multi = 3, delete = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Fire Stone"}}
    --info_queue[#info_queue+1] = { set = 'Item', key = 'c_poke_firestone', vars = {4}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_mult
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"One Punch Idiot, Gem"}}
    local hearthflame_card = G.GAME.current_round.maelmc_hearthflame_card or {rank = "Ace", suit = "Spades"}
    return {vars = {localize(hearthflame_card.rank, "ranks"), localize(hearthflame_card.suit, "suits_plural"), card.ability.extra.Xmult_multi, card.ability.extra.delete, colours = {G.C.SUITS[hearthflame_card.suit]}}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Fire",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
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
      local deleted = nil
      for _ = 1,card.ability.extra.delete do
        local non_mult_card = {}
        for _, v in pairs(G.hand.cards) do
          if not SMODS.has_enhancement(v, "m_mult") then
            non_mult_card[#non_mult_card+1] = v
          end
        end
        local to_delete = pseudorandom_element(non_mult_card, 'maelmc_ogerpon_hearthflame')
        if to_delete then
          deleted = 1
          poke_remove_card(to_delete, card)
        end
      end
      if deleted then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("maelmc_ivy_cudgle_ex"), colour = G.C.MULT})
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
  pos = {x = 6, y = 5},
  soul_pos = {x = 7, y = 5},
  config = {extra = {mult = 1, mult_divide = 10}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Hard Stone"}}
    --info_queue[#info_queue+1] = { set = 'Item', key = 'c_poke_hardstone', vars = {1, 10}}
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    return {vars = {card.ability.extra.mult, card.ability.extra.mult_divide}}
  end,
  rarity = 4, 
  cost = 20,
  stage = "Legendary",
  ptype = "Earth",
  atlas = "AtlasJokersBasicGen09",
  aux_poke = true,
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

-- function that determines what card ogerpon hearthflame uses for the round, copied from The Idol
local function reset_maelmc_hearthflame_card()
    G.GAME.current_round.maelmc_hearthflame_card = { rank = 'Ace', suit = 'Spades' }
    local valid_hearthflame_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card,"m_mult") then
            valid_hearthflame_cards[#valid_hearthflame_cards + 1] = playing_card
        end
    end
    local hearthflame_card = pseudorandom_element(valid_hearthflame_cards, 'maelmc_ogerpon_hearthflame' .. G.GAME.round_resets.ante)
    if hearthflame_card then
        G.GAME.current_round.maelmc_hearthflame_card.rank = hearthflame_card.base.value
        G.GAME.current_round.maelmc_hearthflame_card.suit = hearthflame_card.base.suit
        G.GAME.current_round.maelmc_hearthflame_card.id = hearthflame_card.base.id
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
  reset_maelmc_hearthflame_card()
end

return {
  name = "Maelmc's Jokers Gen 9",
  list = {
    glimmet, glimmora,
    ogerpon, ogerpon_wellspring, ogerpon_hearthflame, ogerpon_cornerstone,
  },
}