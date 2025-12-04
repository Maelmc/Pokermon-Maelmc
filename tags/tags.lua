local cleanse_tag = {
	object_type = "Tag",
	atlas = "maelmc_tags",
	name = "cleanse_tag",
	pos = { x = 1, y = 0 },
	config = {},
	key = "cleanse_tag",
  min_ante = 2,
  discovered = true,
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

return {
  name = "Maelmc's Tags",
  list = {
    cleanse_tag,
  }
}