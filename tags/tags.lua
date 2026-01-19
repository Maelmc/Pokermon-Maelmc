local cleanse_tag = {
	object_type = "Tag",
	atlas = "maelmc_tags",
	name = "cleanse_tag",
	pos = { x = 1, y = 0 },
	config = {},
	key = "cleanse_tag",
  min_ante = 2,
	loc_vars = function(self, info_queue)
		return {}
	end,
	apply = function(self, tag, context)
    if context.cleanse_tag then
      tag:yep(localize("maelmc_safe"), G.C.DARK_EDITION,
        function ()
          return true
        end
      )
      tag.triggered = true
      return true
    end
	end,
}

local spell_tag = {
	object_type = "Tag",
	atlas = "maelmc_tags",
	name = "spell_tag",
	pos = { x = 2, y = 0 },
	config = {},
	key = "spell_tag",
  min_ante = 2,
	loc_vars = function(self, info_queue)
		return {}
	end,
	apply = function(self, tag, context)
    if context.spell_tag then
      tag:yep("+", G.C.DARK_EDITION,
        function ()
          return true
        end
      )
      tag.triggered = true
      return true
    end
	end,
}

return {
  name = "Maelmc's Tags",
  list = {
    cleanse_tag,
    spell_tag,
  }
}