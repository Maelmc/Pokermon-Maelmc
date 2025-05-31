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

local hazardtest = {
	name = "hazardtest",
	key = "hazardtest",
  unlocked = true,
  discovered = true,
	config = {vouchers = { "v_poke_goodrod"}, consumables = {'c_poke_earth_energy'}, jokers = {'j_poke_jynx','j_maelmc_glimmet','j_maelmc_glimmora','j_poke_gigalith','j_poke_golurk'}},
  loc_vars = function(self, info_queue, center)
    return {vars = {self.config.vouchers, self.config.consumables, self.config.jokers}}
  end,
	pos = { x = 0, y = 0 },
	atlas = "pokedeck-Maelmc",
}

local hazardstack = {
	name = "hazardstack",
	key = "hazardstack",
  unlocked = true,
  discovered = true,
	config = {jokers = {'j_maelmc_glimmet'}, extra = {hazard_ratio = 10}},
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

local dList = {hazardtest, hazardstack}

--[[if pokermon_config.pokeballs then
  table.insert(dList, 1, pokemondeck)
end]]

return {name = "Back",
        init = init,
        list = dList
}