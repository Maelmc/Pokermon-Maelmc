-- Nihilego 793
local nihilego = {
  name = "nihilego",
  gen = 7,
  pos = PokemonSprites["nihilego"].base.pos,
  soul_pos = {x = PokemonSprites["nihilego"].base.pos.x + 1, y = PokemonSprites["nihilego"].base.pos.y},
  config = {extra = {h_size = 3, chips = 1, next_boost = 1, next_increase = 1, unscalable_chips = 7}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.h_size,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_chips,
              card.ability.extra.unscalable_chips * ((G.deck and G.deck.cards) and #G.deck.cards or 52),
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
  gen = 7,
  pos = PokemonSprites["buzzwole"].base.pos,
  soul_pos = {x = PokemonSprites["buzzwole"].base.pos.x + 1, y = PokemonSprites["buzzwole"].base.pos.y},
  config = {extra = {hands = 2, chips = 1, next_boost = 1, next_increase = 1, unscalable_mult = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.hands,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_mult,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
      ease_hands_played(1)
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
  gen = 7,
  pos = PokemonSprites["pheromosa"].base.pos,
  soul_pos = {x = PokemonSprites["pheromosa"].base.pos.x + 1, y = PokemonSprites["pheromosa"].base.pos.y},
  config = {extra = {d_size = 4, chips = 1, next_boost = 1, next_increase = 1, unscalable_dollars = 2, poker_hands = {"Flush Five","Flush House","Five of a Kind","Straight Flush","Four of a Kind"}}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.d_size,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_dollars,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
  gen = 7,
  pos = PokemonSprites["xurkitree"].base.pos,
  soul_pos = {x = PokemonSprites["xurkitree"].base.pos.x + 1, y = PokemonSprites["xurkitree"].base.pos.y},
  config = {extra = {energy_bonus = 2, chips = 1, next_boost = 1, next_increase = 1, unscalable_dollars = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    local energy_usable = 0
    if G.jokers and G.jokers.cards then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] ~= card then
          energy_usable = energy_usable + energy_max + (G.GAME.energy_plus or 0) - math.min(get_total_energy(G.jokers.cards[i]), (G.GAME.energy_plus or 0))
        end
      end
    end
    return {vars = {
              card.ability.extra.energy_bonus,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_dollars,
              card.ability.extra.unscalable_dollars * energy_usable,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
  gen = 7,
  pos = PokemonSprites["celesteela"].base.pos,
  soul_pos = {x = PokemonSprites["celesteela"].base.pos.x + 1, y = PokemonSprites["celesteela"].base.pos.y},
  config = {extra = {card_limit = 1, chips = 1, next_boost = 2, next_increase = 2, unscalable_mult = 1, unscalable_mult2 = 0.2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.card_limit,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_mult2,
              card.ability.extra.unscalable_mult,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
      card.ability.extra.card_limit = card.ability.extra.card_limit + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

    if context.setting_blind and not context.blueprint then
      card.ability.extra.unscalable_mult = card.ability.extra.unscalable_mult + card.ability.extra.unscalable_mult2 * (G.consumeables.config.card_limit - #G.consumeables.cards)
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.unscalable_mult2 * (G.consumeables.config.card_limit - #G.consumeables.cards) } },
        colour = G.C.RED,
      }
    end

    if context.joker_main and card.ability.extra.unscalable_mult ~= 1 then
      return {
        xmult = card.ability.extra.unscalable_mult
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
  gen = 7,
  pos = PokemonSprites["kartana"].base.pos,
  soul_pos = {x = PokemonSprites["kartana"].base.pos.x + 1, y = PokemonSprites["kartana"].base.pos.y},
  config = {extra = {booster_choice_mod = 1, chips = 1, next_boost = 3, next_increase = 3, unscalable_mult = 0, unscalable_mult2 = 5, size_of_booster = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.booster_choice_mod,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_mult2,
              card.ability.extra.unscalable_mult,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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
  gen = 7,
  pos = PokemonSprites["stakataka"].base.pos,
  soul_pos = {x = PokemonSprites["stakataka"].base.pos.x + 1, y = PokemonSprites["stakataka"].base.pos.y},
  config = {extra = {voucher_slots = 1, chips = 1, next_boost = 2, next_increase = 2, unscalable_dollars = 7, voucher_bought = 0, beat_boss = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.voucher_slots,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_dollars,
              card.ability.extra.unscalable_dollars * (1 + (G.GAME.modifiers.extra_vouchers or 0) - card.ability.extra.voucher_bought),
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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

    if context.buying_card and context.card.ability.set == "Voucher" and not context.blueprint then
      card.ability.extra.voucher_bought = card.ability.extra.voucher_bought + 1
      return {
        message = localize { type = 'variable', key = 'maelmc_dollars_minus', vars = { card.ability.extra.unscalable_dollars } },
        colour = G.C.GOLD
      }
    end

    if (context.end_of_round and G.GAME.blind.boss) and not context.blueprint then
      card.ability.extra.beat_boss = true
    end

    if context.starting_shop and card.ability.extra.beat_boss and not context.blueprint then
      card.ability.extra.beat_boss = false
      card.ability.extra.voucher_bought = 0
      return {
        message = localize('k_reset'),
        colour = G.C.GOLD
      }
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    SMODS.change_voucher_limit(card.ability.extra.voucher_slots)
  end,
  remove_from_deck = function(self, card, from_debuff)
    SMODS.change_voucher_limit(-card.ability.extra.voucher_slots)
  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.unscalable_dollars * (1 + (G.GAME.modifiers.extra_vouchers or 0) - card.ability.extra.voucher_bought)
  end
}

-- Blacephalon 806
local blacephalon = {
  name = "blacephalon",
  gen = 7,
  pos = PokemonSprites["blacephalon"].base.pos,
  soul_pos = {x = PokemonSprites["blacephalon"].base.pos.x + 1, y = PokemonSprites["blacephalon"].base.pos.y},
  config = {extra = {card_slots = 1, chips = 1, next_boost = 2, next_increase = 2, unscalable_mult = 23, unscalable_negative_mult = 11, amount_bought = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.card_slots,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.unscalable_mult,
              card.ability.extra.unscalable_negative_mult,
              card.ability.extra.unscalable_mult * (G.GAME.shop.joker_max or 3) - card.ability.extra.unscalable_negative_mult * card.ability.extra.amount_bought,
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
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

    if context.buying_card and context.card.ability.set ~= "Voucher" and not context.blueprint then
      card.ability.extra.amount_bought = card.ability.extra.amount_bought + 1
      return {
        message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.unscalable_negative_mult } },
        colour = G.C.RED
      }
    end

    if context.joker_main then
      return {
        mult = card.ability.extra.unscalable_mult * (G.GAME.shop.joker_max or 3) - card.ability.extra.unscalable_negative_mult * card.ability.extra.amount_bought
      }
    end

    if (context.end_of_round and G.GAME.blind.boss) and not context.blueprint then
      card.ability.extra.amount_bought = 0
      return {
        message = localize('k_reset'),
        colour = G.C.RED
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

--Guzzlord 799
local guzzlord = {
  name = "guzzlord",
  gen = 7,
  pos = PokemonSprites["guzzlord"].base.pos,
  soul_pos = {x = PokemonSprites["guzzlord"].base.pos.x + 1, y = PokemonSprites["guzzlord"].base.pos.y},
  config = {extra = {to_eat = 1, chips = 1, next_boost = 3, next_increase = 3, unscalable_mult = 1, unscalable_mult2 = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'ultra_beast'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {
              card.ability.extra.to_eat,
              card.ability.extra.unscalable_mult2 * card.ability.extra.to_eat,
              card.ability.extra.unscalable_mult,
              card.ability.extra.next_boost - get_total_energy(card),
              card.ability.extra.to_eat <= 1 and "" or "s",
              card.ability.extra.next_boost - get_total_energy(card) <= 1 and "" or "s",
            }}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local eval = function(c) return get_total_energy(c) >= card.ability.extra.next_boost and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.end_of_round and context.main_eval and not context.blueprint and get_total_energy(card) >= card.ability.extra.next_boost then
      card.ability.extra.to_eat = card.ability.extra.to_eat + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
      }
    end

    if context.joker_main then
      return {
        xmult = card.ability.extra.unscalable_mult
      }
    end

    if context.ending_shop and not context.blueprint then
      for _ = 1, card.ability.extra.to_eat do
        local pool = {}
        -- listing everything that guzzlord can eat
        if (SMODS.Mods["Talisman"] or {}).can_load then
          if to_big(G.GAME.dollars) > to_big(0) then table.insert(pool,{weight = 100, name = "money"}) end
        else
          if G.GAME.dollars > 0 then table.insert(pool,{weight = 100, name = "money"}) end
        end
        if #G.consumeables.cards > 0 then table.insert(pool,{weight = 100, name = "consumable"}) end
        if #G.jokers.cards > 1 then table.insert(pool,{weight = 100, name = "joker"}) end
        if #G.playing_cards > 1 then table.insert(pool,{weight = 100, name = "playing cards"}) end
        if G.GAME.round_resets.hands > 1 then table.insert(pool,{weight = 75, name = "hand"}) end
        if G.GAME.round_resets.discards > 0 then table.insert(pool,{weight = 75, name = "discard"}) end
        if G.hand.config.card_limit > 1 then table.insert(pool,{weight = 75, name = "hand size"}) end
        if (G.GAME.round_resets.hazard_level or 0) > 0 then table.insert(pool,{weight = 75, name = "hazard level"}) end
        if G.jokers.config.card_limit > 1 then table.insert(pool,{weight = 50, name = "joker slot"}) end
        if G.consumeables.config.card_limit > 0 then table.insert(pool,{weight = 50, name = "consumable slot"}) end
        if G.shop_jokers.config.card_limit > 1 then table.insert(pool,{weight = 50, name = "card slot"}) end
        if (G.GAME.modifiers.extra_boosters or 0) > -2 then table.insert(pool,{weight = 50, name = "booster slot"}) end
        if (G.GAME.modifiers.extra_vouchers or 0) > -1 then table.insert(pool,{weight = 50, name = "voucher slot"}) end
        if (G.GAME.energy_plus or 0) > -energy_max then table.insert(pool,{weight = 50, name = "energy limit"}) end
        if (G.GAME.hazard_max or 3) > 0 then table.insert(pool,{weight = 50, name = "hazard limit"}) end
        if not G.GAME.modifiers.guzzlord_eat_shop_reroll then table.insert(pool,{weight = 1, name = "shop reroll"}) end
        if not G.GAME.modifiers.guzzlord_eat_shop_sign then table.insert(pool,{weight = 1, name = "shop sign"}) end

        if not next(pool) then
          card.ability.extra.unscalable_mult = card.ability.extra.unscalable_mult - card.ability.extra.unscalable_mult2
          SMODS.calculate_effect({message = localize("maelmc_hungry_dot")}, card)
        else
          card.ability.extra.unscalable_mult = card.ability.extra.unscalable_mult + card.ability.extra.unscalable_mult2
          local rng = maelmc_weighted_random(pool,"guzzlord")
          local result = rng["name"]

          if result == "money" then
            local lost = 0 
            if (SMODS.Mods["Talisman"] or {}).can_load then
              lost = math.random(1,math.ceil(to_number(to_big(G.GAME.dollars))/2))
            else
              lost = math.random(1,math.ceil(G.GAME.dollars)/2)
            end
            SMODS.calculate_effect({dollars = -lost}, card)

          elseif result == "consumable" then
            local consum = pseudorandom_element(G.consumeables.cards,pseudoseed("guzzlord"))
            consum.getting_sliced = true
            consum:start_dissolve({ G.C.RED }, nil, 1.6)
            SMODS.calculate_effect({message = G.localization.descriptions[consum.ability.set][consum.config.center_key]["name"]}, card)

          elseif result == "joker" then
            local torand = {}
            for _, v in ipairs(G.jokers.cards) do
              if v ~= card then
                table.insert(torand,v)
              end
            end
            local jok = pseudorandom_element(torand,pseudoseed("guzzlord"))
            jok.getting_sliced = true
            jok:start_dissolve({ G.C.RED }, nil, 1.6)
            SMODS.calculate_effect({message = G.localization.descriptions["Joker"][jok.config.center_key]["name"]}, card)
          
          elseif result == "playing cards" then
            local car = pseudorandom_element(G.playing_cards,pseudoseed("guzzlord"))
            car.getting_sliced = true
            car:start_dissolve({ G.C.RED }, nil, 1.6)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_playing_card_minus', vars = { 1 } } }, card)

          elseif result == "hand" then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
            ease_hands_played(-1)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_hand_minus', vars = { 1 } } }, card)
          
          elseif result == "discard" then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
            ease_discard(-1)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_discard_minus', vars = { 1 } } }, card)

          elseif result == "hand size" then
            G.hand.config.real_card_limit = (G.hand.config.real_card_limit or G.hand.config.card_limit) - 1
            G.hand.config.card_limit = math.max(0, G.hand.config.real_card_limit)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_hand_size_minus', vars = { 1 } } }, card)

          elseif result == "hazard level" then
            G.GAME.round_resets.hazard_level = G.GAME.round_resets.hazard_level - 1
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_hazard_level_minus', vars = { 1 } } }, card)
          
          elseif result == "joker slot" then
            G.jokers.config.real_card_limit = (G.jokers.config.real_card_limit or G.jokers.config.card_limit) - 1
            G.jokers.config.card_limit = math.max(0, G.jokers.config.real_card_limit)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_joker_slot_minus', vars = { 1 } } }, card)
          
          elseif result == "consumable slot" then
            G.consumeables.config.real_card_limit = (G.consumeables.config.real_card_limit or G.consumeables.config.card_limit) - 1
            G.consumeables.config.card_limit = math.max(0, G.consumeables.config.real_card_limit)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_consumable_slot_minus', vars = { 1 } } }, card)
          
          elseif result == "card slot" then
            change_shop_size(-1)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_card_slot_minus', vars = { 1 } } }, card)
          
          elseif result == "booster slot" then
            if G.GAME.modifiers.extra_boosters then G.GAME.modifiers.extra_boosters = G.GAME.modifiers.extra_boosters - 1
            else G.GAME.modifiers.extra_boosters = -1 end
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_pack_slot_minus', vars = { 1 } } }, card)
          
          elseif result == "voucher slot" then
            SMODS.change_voucher_limit(-1)
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_voucher_slot_minus', vars = { 1 } } }, card)
          
          elseif result == "energy limit" then
            if G.GAME.energy_plus then G.GAME.energy_plus = G.GAME.energy_plus - 1
            else G.GAME.energy_plus = -1 end
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_energy_limit_minus', vars = { 1 } } }, card)

          elseif result == "hazard limit" then
            if G.GAME.hazard_max then G.GAME.hazard_max = G.GAME.hazard_max - 1
            else G.GAME.hazard_max = 2 end
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'maelmc_hazard_limit_minus', vars = { 1 } } }, card)

          elseif result == "shop reroll" then
            G.GAME.modifiers.guzzlord_eat_shop_reroll = true
            SMODS.calculate_effect({message = localize("maelmc_shop_reroll")}, card)
          
          elseif result == "shop sign" then
            G.GAME.modifiers.guzzlord_eat_shop_sign = true
            SMODS.calculate_effect({message = localize("maelmc_shop_sign")}, card)
          end
        end
      end
      return true
    end
  end,
}

return {
  name = "Maelmc's Jokers Gen 7",
  list = {
    nihilego,
    buzzwole,
    pheromosa,
    xurkitree,
    celesteela,
    kartana,
    guzzlord,
    stakataka,
    blacephalon,
  },
}