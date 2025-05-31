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

local mydeck = {
	name = "mydeck",
	key = "mydeck",  
	order = 17,
  unlocked = true,
  discovered = true,
	config = {vouchers = { "v_poke_goodrod"}, consumables = {'c_poke_earth_energy'}, jokers = {'j_poke_jynx','j_maelmc_glimmet','j_maelmc_glimmora','j_poke_gigalith','j_poke_gigalith'}},
  loc_vars = function(self, info_queue, center)
    return {vars = {localize("goodrod_variable"), localize("pokeball_variable")}}
  end,
	pos = { x = 0, y = 0 },
	atlas = "pokedeck-Maelmc",
}

local dList = {mydeck}

--[[if pokermon_config.pokeballs then
  table.insert(dList, 1, pokemondeck)
end]]

return {name = "Back",
        init = init,
        list = dList
}