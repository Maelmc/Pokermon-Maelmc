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
    --guzzlord,
  },
}