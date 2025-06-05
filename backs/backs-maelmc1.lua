local hazarddeck = {
	name = "hazarddeck",
	key = "hazarddeck",
  unlocked = true,
  discovered = true,
	config = {jokers = {'j_maelmc_glimmet', 'j_maelmc_cufant'}, extra = {hazard_ratio = 10}},
  loc_vars = function(self, info_queue, center)
    return {vars = {self.config.jokers, self.config.extra.hazard_ratio}}
  end,
	pos = { x = 1, y = 0 },
	atlas = "pokedeck-Maelmc",
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_add_hazards(self.config.extra.hazard_ratio)
    end
  end
}

local dList = {hazarddeck}

return {name = "Back",
        init = init,
        list = dList
}