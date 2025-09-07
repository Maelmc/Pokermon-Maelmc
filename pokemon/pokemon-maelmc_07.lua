-- Guzzlord 799
local guzzlord = {
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
}

return {
  name = "Maelmc's Jokers Gen 7",
  list = {
    --guzzlord,
  },
}