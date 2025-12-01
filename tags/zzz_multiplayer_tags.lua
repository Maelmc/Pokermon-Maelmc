local shadow_tag = {
	object_type = "Tag",
	atlas = "maelmc_tags",
	name = "shadow_tag",
	pos = { x = 0, y = 0 },
	config = { type = "eval" },
	key = "shadow_tag",
  discovered = true,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_maelmc_trapped"]
		if next(SMODS.find_mod("NanoMultiplayer")) then
      add_nemesis_info(info_queue)
    elseif next(SMODS.find_mod("Multiplayer")) then
      MP.UTILS.add_nemesis_info(info_queue)
    else
      info_queue[#info_queue+1] = {set = 'Other', key = 'multiplayer_ex_tag'}
    end
		return { vars = {localize { type = 'name_text', set = 'Enhanced', key = "m_maelmc_trapped" }} }
	end,
	apply = function(self, tag, context)
		if context and context.type == "new_blind_choice" then
			tag:yep(localize("maelmc_trapped_ex"), G.C.DARK_EDITION,
				function ()
					local _card = create_playing_card({
              front = G.P_CARDS.S_2,
              center = G.P_CENTERS.m_maelmc_trapped}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced}
					)
					playing_card_joker_effects({_card})
					return true
				end
			)
      tag.triggered = true
			return true
		end
	end,
  in_pool = function(self)
    -- you don't want this to appear as a skip tag lol
    return false
  end
}

return {
  name = "Maelmc's Multiplayer Tags",
  list = {
    shadow_tag,
  }
}