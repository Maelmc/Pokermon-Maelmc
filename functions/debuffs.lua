-- Describe all the logic for debuffing or undebuffing

-- return values: true, false, or 'prevent_debuff'
SMODS.current_mod.set_debuff = function(card)
   if card:is_suit("Hearts") and card:get_seal() == "Red" and next(find_joker("swoobat")) then return 'prevent_debuff' end
   return false
end

