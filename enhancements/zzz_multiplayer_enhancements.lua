local trapped = {
  key = "trapped",
  atlas = "maelmc_enhancements",
  pos = { x = 0, y = 0 },
  config = {},
  loc_vars = function(self, info_queue, center)
    if next(SMODS.find_mod("NanoMultiplayer")) then
      add_nemesis_info(info_queue)
    elseif next(SMODS.find_mod("Multiplayer")) then
      MP.UTILS.add_nemesis_info(info_queue)
    else
      info_queue[#info_queue+1] = {set = 'Other', key = 'multiplayer_ex_enh'}
    end
    return {vars = {}}
  end,
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  weight = 0,
  in_pool = function(self, args) return false end,
}

return {
   name = "Maelmc's Multiplayer Enhancements",
   list = {
    trapped
   }
}