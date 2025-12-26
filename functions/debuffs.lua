-- Describe all the logic for debuffing or undebuffing

-- return values: true, false, or 'prevent_debuff'
SMODS.current_mod.set_debuff = function(card)
   if card:is_suit("Hearts",true) and card:get_seal(true) == "Red" and next(SMODS.find_card("j_maelmc_swoobat")) then return 'prevent_debuff' end
   if card:get_id() and card:get_id() ~= 7 and next(SMODS.find_card("j_maelmc_mega_barbaracle")) then return true end
   if card.ability and card.ability.consumeable and (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_bloodmoon_beast" and not G.GAME.blind.disabled) then return true end
   return false
end

