-- Describe all the logic for debuffing or undebuffing

-- return values: true, false, or 'prevent_debuff'
SMODS.current_mod.set_debuff = function(card)
   if card:is_suit("Hearts") and card:get_seal() == "Red" and next(find_joker("swoobat")) then return 'prevent_debuff' end
   if card:get_id() and card:get_id() ~= 7 and next(find_joker("mega_barbaracle")) then return true end
   return false
end

