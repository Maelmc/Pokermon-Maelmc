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

local mysterydeck = {
	name = "mysterydeck",
	key = "mysterydeck",
  unlocked = true,
  discovered = true,
	config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {localize("maelmc_wondertrade")}}
  end,
	pos = { x = 2, y = 0 },
	atlas = "maelmc_pokedeck",
  apply = function(self)
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_maelmc_wonder_trade', nil)
        card:add_to_deck()
        card:set_edition({negative = true})
        card:set_eternal(true)
        G.jokers:emplace(card)
        return true
      end
    }))
  end
}

local list = { hazarddeck }

if next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer')) then
  table.insert(list, mysterydeck)
end

return {name = "Back",
  init = init,
  list = list,
}