init = function()
  local backapply_orig = Back.apply_to_run
  function Back.apply_to_run(self)
    backapply_orig(self)
    			G.E_MANAGER:add_event(Event({
					func = function()
            if G.GAME.modifiers.poke_force_seal then
              for i = 1, #G.playing_cards do
                G.playing_cards[i]:set_seal(G.GAME.modifiers.poke_force_seal, true)
              end
            end
						return true
					end,
				}))
  end
end

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

--[[if pokermon_config.pokeballs then
  table.insert(dList, 1, pokemondeck)
end]]

return {name = "Back",
        init = init,
        list = dList
}