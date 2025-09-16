-- Nihilego 793
local nihilego = {
  name = "nihilego",
  pos = PokemonSprites["nihilego"].base.pos,
  soul_pos = {x = PokemonSprites["nihilego"].base.pos.x + 1, y = PokemonSprites["nihilego"].base.pos.y},
  config = {extra = {h_size = 3, chips = 1, next_boost = 1, next_increase = 1, unscalable_chips = 11}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.h_size, card.ability.extra.next_boost - get_total_energy(card), card.ability.extra.unscalable_chips, card.ability.extra.unscalable_chips * ((G.deck and G.deck.cards) and #G.deck.cards or 52)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.hand:change_size(1)
      card.ability.extra.h_size = card.ability.extra.h_size + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.unscalable_chips * #G.deck.cards
      }
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

-- Buzzwole 794
local buzzwole = {
  name = "buzzwole",
  pos = PokemonSprites["buzzwole"].base.pos,
  soul_pos = {x = PokemonSprites["buzzwole"].base.pos.x + 1, y = PokemonSprites["buzzwole"].base.pos.y},
  config = {extra = {hands = 2, chips = 1, next_boost = 1, next_increase = 1, unscalable_mult = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.hands, card.ability.extra.next_boost - get_total_energy(card), card.ability.extra.unscalable_mult}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return (get_total_energy(c) >= card.ability.extra.next_boost or G.GAME.current_round.hands_played == 0) and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
      if not from_debuff then
        ease_hands_played(1)
      end
      card.ability.extra.hands = card.ability.extra.hands + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

    if context.joker_main and G.GAME.current_round.hands_played == 0 then
      return {
        xmult = card.ability.extra.unscalable_mult * G.GAME.current_round.hands_left
      }
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

-- Pheromosa 795
local pheromosa = {
  name = "pheromosa",
  pos = PokemonSprites["pheromosa"].base.pos,
  soul_pos = {x = PokemonSprites["pheromosa"].base.pos.x + 1, y = PokemonSprites["pheromosa"].base.pos.y},
  config = {extra = {d_size = 4, chips = 1, next_boost = 1, next_increase = 1, unscalable_dollars = 2, poker_hands = {"Flush Five","Flush House","Five of a Kind","Straight Flush","Four of a Kind"}}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.d_size, card.ability.extra.next_boost - get_total_energy(card), card.ability.extra.unscalable_dollars}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.before and table.contains(card.ability.extra.poker_hands, context.scoring_name) then
      G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.unscalable_dollars * G.GAME.current_round.discards_left
      return {
        dollars = card.ability.extra.unscalable_dollars * G.GAME.current_round.discards_left,
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              G.GAME.dollar_buffer = 0
              return true
            end
          }))
        end
      }
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
      ease_discard(1)
      card.ability.extra.d_size = card.ability.extra.d_size + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end,
}

-- Xurkitree 796
local xurkitree = {
  name = "xurkitree",
  pos = PokemonSprites["xurkitree"].base.pos,
  soul_pos = {x = PokemonSprites["xurkitree"].base.pos.x + 1, y = PokemonSprites["xurkitree"].base.pos.y},
  config = {extra = {energy_bonus = 2, chips = 1, next_boost = 1, next_increase = 1, unscalable_dollars = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    local energy_usable = 0
    if G.jokers and G.jokers.cards then
      print(G.GAME.energy_plus)
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] ~= card then
          print(get_total_energy(G.jokers.cards[i]))
          energy_usable = energy_usable + energy_max + (G.GAME.energy_plus or 0) - math.min(get_total_energy(G.jokers.cards[i]), (G.GAME.energy_plus or 0))
        end
      end
    end
    return {vars = {card.ability.extra.energy_bonus, card.ability.extra.next_boost - get_total_energy(card), card.ability.extra.unscalable_dollars, card.ability.extra.unscalable_dollars * energy_usable}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Lightning",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.energy_plus = G.GAME.energy_plus + 1
      card.ability.extra.energy_bonus = card.ability.extra.energy_bonus + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.energy_plus then
      G.GAME.energy_plus = card.ability.extra.energy_bonus
    else
      G.GAME.energy_plus = G.GAME.energy_plus + card.ability.extra.energy_bonus
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if not G.GAME.energy_plus then
      G.GAME.energy_plus = 0
    else
      G.GAME.energy_plus = G.GAME.energy_plus - card.ability.extra.energy_bonus
    end
  end,
  calc_dollar_bonus = function(self, card)
    local energy_usable = 0
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] ~= card then
        energy_usable = energy_usable + energy_max + (G.GAME.energy_plus or 0) - math.min(get_total_energy(G.jokers.cards[i]), (G.GAME.energy_plus or 0))
      end
    end
    return card.ability.extra.unscalable_dollars * energy_usable
  end
  
}

-- Celesteela 797
local celesteela = {
  name = "celesteela",
  pos = PokemonSprites["celesteela"].base.pos,
  soul_pos = {x = PokemonSprites["celesteela"].base.pos.x + 1, y = PokemonSprites["celesteela"].base.pos.y},
  config = {extra = {card_limit = 1, chips = 1, next_boost = 2, next_increase = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.card_limit, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.E_MANAGER:add_event(Event({
        func = function()
          G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
          return true
        end 
      }))
      card.ability.extra.card_limit = card.ability.extra.card_limit + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    local add = card.ability.extra.card_limit
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + add
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    local add = card.ability.extra.card_limit
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - add
      return true end }))
  end,
}

-- Kartana 798
local kartana = {
  name = "kartana",
  pos = PokemonSprites["kartana"].base.pos,
  soul_pos = {x = PokemonSprites["kartana"].base.pos.x + 1, y = PokemonSprites["kartana"].base.pos.y},
  config = {extra = {booster_choice_mod = 1, chips = 1, next_boost = 3, next_increase = 3, unscalable_mult = 0, unscalable_mult2 = 5, size_of_booster = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.booster_choice_mod, card.ability.extra.next_boost - get_total_energy(card), card.ability.extra.unscalable_mult2, card.ability.extra.unscalable_mult}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod + 1
      card.ability.extra.booster_choice_mod = card.ability.extra.booster_choice_mod + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

    if context.open_booster and not context.blueprint then
      card.ability.extra.size_of_booster = G.GAME.pack_choices
    end

    if context.skipping_booster and not context.blueprint then
      card.ability.extra.unscalable_mult = card.ability.extra.unscalable_mult + card.ability.extra.unscalable_mult2 * G.GAME.pack_choices
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.unscalable_mult2 * G.GAME.pack_choices} },
        colour = G.C.RED,
      }
    end

    if context.joker_main then
      if card.ability.extra.unscalable_mult ~= 0 then
        return {
          mult = card.ability.extra.unscalable_mult
        }
      end
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    if G.GAME.modifiers.booster_choice_mod then
      G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod + card.ability.extra.booster_choice_mod
    else
      G.GAME.modifiers.booster_choice_mod = card.ability.extra.booster_choice_mod
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.GAME.modifiers.booster_choice_mod then
      G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod - card.ability.extra.booster_choice_mod
    else
      G.GAME.modifiers.booster_choice_mod = 0
    end
  end,
}

-- Stakataka 805
local stakataka = {
  name = "stakataka",
  pos = PokemonSprites["stakataka"].base.pos,
  soul_pos = {x = PokemonSprites["stakataka"].base.pos.x + 1, y = PokemonSprites["stakataka"].base.pos.y},
  config = {extra = {voucher_slots = 1, chips = 1, next_boost = 2, next_increase = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.voucher_slots, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Earth",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      SMODS.change_voucher_limit(1)
      card.ability.extra.voucher_slots = card.ability.extra.voucher_slots + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    SMODS.change_voucher_limit(card.ability.extra.voucher_slots)
  end,
  remove_from_deck = function(self, card, from_debuff)
    SMODS.change_voucher_limit(-card.ability.extra.voucher_slots)
  end,
}

-- Blacephalon 806
local blacephalon = {
  name = "blacephalon",
  pos = PokemonSprites["blacephalon"].base.pos,
  soul_pos = {x = PokemonSprites["blacephalon"].base.pos.x + 1, y = PokemonSprites["blacephalon"].base.pos.y},
  config = {extra = {card_slots = 1, chips = 1, next_boost = 2, next_increase = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.card_slots, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      change_shop_size(1)
      card.ability.extra.card_slots = card.ability.extra.card_slots + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    change_shop_size(card.ability.extra.card_slots)
  end,
  remove_from_deck = function(self, card, from_debuff)
    change_shop_size(-card.ability.extra.card_slots)
  end,
}

-- Guzzlord 799
--[[local guzzlord = {
  name = "guzzlord",
  pos = {x = 10, y = 7},
  soul_pos = {x = 11, y = 7},
  config = {extra = {Xmult = 1, Xmult_mod = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult,card.ability.extra.Xmult_mod}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- code to detect self destruct and scale in lovely patch
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        if card.ability.extra.Xmult > 1 then
            return {
                colour = G.C.MULT,
                xmult = card.ability.extra.Xmult,
                card = card
            }
        end
      end
    end
  end,
}]]

return {
  name = "Maelmc's Jokers Gen 7",
  list = {
    nihilego,
    buzzwole,
    pheromosa,
    xurkitree,
    celesteela,
    kartana,
    stakataka,
    blacephalon
    --guzzlord,
  },
}