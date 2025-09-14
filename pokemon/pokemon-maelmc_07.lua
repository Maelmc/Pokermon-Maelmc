-- Nihilego 793
local nihilego = {
  name = "nihilego",
  pos = PokemonSprites["nihilego"].base.pos,
  soul_pos = {x = PokemonSprites["nihilego"].base.pos.x + 1, y = PokemonSprites["nihilego"].base.pos.y},
  config = {extra = {h_size = 3, chips = 1, next_boost = 1, next_increase = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.h_size, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and get_total_energy(card) >= card.ability.extra.next_boost then
      G.hand:change_size(1)
      card.ability.extra.h_size = card.ability.extra.h_size + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
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
  config = {extra = {hands = 2, chips = 1, next_boost = 1, next_increase = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.hands, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Fighting",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
      card.ability.extra.hands = card.ability.extra.hands + 1
      card.ability.extra.next_increase = card.ability.extra.next_increase + 1
      card.ability.extra.next_boost = card.ability.extra.next_boost + card.ability.extra.next_increase
      return {
        message = localize("maelmc_beast_boost")
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
  config = {extra = {d_size = 4, chips = 1, next_boost = 1, next_increase = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'beast_boost'}
    return {vars = {card.ability.extra.d_size, card.ability.extra.next_boost - get_total_energy(card)}}
  end,
  rarity = "maelmc_ultra_beast",
  cost = 15,
  stage = "Ultra Beast",
  ptype = "Grass",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and get_total_energy(card) >= card.ability.extra.next_boost then
      G.GAME.round_resets.d_size = G.GAME.round_resets.d_size + 1
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
    --guzzlord,
  },
}