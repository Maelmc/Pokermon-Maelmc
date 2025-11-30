local shadow_tag = {
	object_type = "Tag",
	atlas = "maelmc_tags",
	name = "shadow_tag",
	pos = { x = 0, y = 0 },
	config = { type = "new_blind_choice" },
	key = "shadow_tag",
  discovered = true,
	loc_vars = function(self, info_queue)
		if next(SMODS.find_mod("NanoMultiplayer")) then
      add_nemesis_info(info_queue)
    elseif next(SMODS.find_mod("Multiplayer")) then
      MP.UTILS.add_nemesis_info(info_queue)
    else
      info_queue[#info_queue+1] = {set = 'Other', key = 'multiplayer_ex_tag'}
    end
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context and context.type == tag.ability.type then
			-- for now nothing i just wanna see it in game
      tag.triggered = true
		end
	end,
  in_pool = function(self)
    -- you don't want this to appear as a skip tag lol
    return false
  end
}

return {
  name = "Maelmc's Tags",
  list = {
    shadow_tag,
  }
}