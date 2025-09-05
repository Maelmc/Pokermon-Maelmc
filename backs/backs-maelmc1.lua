local hazarddeck = {
	name = "hazarddeck",
	key = "hazarddeck",
  unlocked = true,
  discovered = true,
	config = {extra = {hazards = 4, h_size = 1, total_h_size = 0}},
  loc_vars = function(self, info_queue, center)
    return {vars = {self.config.extra.hazards}}
  end,
	pos = { x = 1, y = 0 },
	atlas = "maelmc_pokedeck",
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_set_hazards(self.config.extra.hazards)
    end

    --[[if context.end_of_round then
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") and v.ability.card_limit then
          v.ability.card_limit = nil
        end
      end
    end]]
  end,
  apply = function(self)
    G.GAME.modifiers.hazard_deck = true
  end
}

local dList = {hazarddeck}

return {name = "Back",
  init = init,
  list = dList
}