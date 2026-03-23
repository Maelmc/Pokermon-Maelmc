local ludicolo = {
  key = "ludicolo",
  atlas = "maelmc_ludicolo",
  pos = { x = 0, y = 0 },
  config = { },
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  always_scores = true,
  weight = 0,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      return {
        message = localize("maelmc_ludicolo_ex"),
        sound = 'maelmc_ludicolo'
      }
    end
  end,
  in_pool = function(self, args) return false end,
}

return {
   name = "Maelmc's April's Fools",
   list = {
    ludicolo,
   }
}