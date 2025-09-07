-- Woobat
local woobat = {
  name = "woobat",
  pos = {x = 2, y = 35},
  config = {extra = {odds = 2, heart_stamped_count = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {""..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, self.config.evo_rqmt}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  volatile = true,
  calculate = function(self, card, context)

    if context.before and context.cardarea == G.jokers and (pseudorandom('woobat') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.odds) then
      local all_heart = true
      for _, v in pairs(context.scoring_hand) do
        if not v:is_suit("Hearts") then
          all_heart = false
          break
        end
      end
      if all_heart then
        local compatible = {}
        for _, v in pairs(G.hand.cards) do
          if v:is_suit("Hearts") then
            compatible[#compatible+1] = v
          end
        end
        local to_stamp = pseudorandom_element(compatible, 'maelmc_woobat')
        if to_stamp then
          to_stamp:set_seal("Red",true)
          return {
            message = localize("maelmc_hearthstamp_ex")
          }
        end
      end
    end

    return scaling_evo(self, card, context, "j_maelmc_swoobat", card.ability.extra.heart_stamped_count, self.config.evo_rqmt)
  end,
  update = function(self, card, dt)
    if not poke_is_in_collection(card) then
      local heart_stamped_count = 0
      for _, v in pairs(G.playing_cards) do
        if v:is_suit("Hearts") and v:get_seal() == "Red" then
          heart_stamped_count = heart_stamped_count + 1
        end
      end
      card.ability.extra.heart_stamped_count = heart_stamped_count
    end
  end
}

local swoobat = {
  name = "swoobat",
  pos = {x = 4, y = 35},
  config = {extra = {odds = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {""..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  volatile = true,
  calculate = function(self, card, context)

    if context.before and context.cardarea == G.jokers then
      local all_heart = true
      for _, v in pairs(context.scoring_hand) do
        if not v:is_suit("Hearts") then
          all_heart = false
          break
        end
      end
      if all_heart then
        local stamp_set = false
        for _, v in pairs(G.hand.cards) do
          if v:is_suit("Hearts") and (pseudorandom('swoobat') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.odds) then
            v:set_seal("Red",true)
            stamp_set = true
          end
        end
        if stamp_set then
          return {
            message = localize("maelmc_hearthstamp_ex")
          }
        end
      end
    end
  end,
}

return {
  name = "Maelmc's Jokers Gen 5",
  list = {
    woobat, swoobat,
  },
}
