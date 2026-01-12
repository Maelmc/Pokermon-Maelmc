-- Describe all the logic for debuffing or undebuffing

-- return values: true, false, or 'prevent_debuff'
SMODS.current_mod.set_debuff = function(card)
   if card:is_suit("Hearts",true) and card:get_seal(true) == "Red" and next(SMODS.find_card("j_maelmc_swoobat")) then return 'prevent_debuff' end
   if card:get_id() and card:get_id() ~= 7 and next(SMODS.find_card("j_maelmc_mega_barbaracle")) then return true end
   if card.ability and card.ability.consumeable and (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_bloodmoon_beast" and not G.GAME.blind.disabled) then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_hearthflame_mask" and not G.GAME.blind.disabled) and (is_type(card,"Fire") or SMODS.has_enhancement(card,'m_mult')) then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_wellspring_mask" and not G.GAME.blind.disabled) and (is_type(card,"Water") or SMODS.has_enhancement(card,'m_bonus')) then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_cornerstone_mask" and not G.GAME.blind.disabled) and (is_type(card,"Earth") or SMODS.has_enhancement(card,'m_stone')) then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_teal_mask" and not G.GAME.blind.disabled) and (is_type(card,"Grass") or SMODS.has_enhancement(card,'m_lucky')) then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_rock_giant" and not G.GAME.blind.disabled) and SMODS.has_enhancement(card,'m_stone') then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_ice_giant" and not G.GAME.blind.disabled) and SMODS.has_enhancement(card,'m_glass') then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_steel_giant" and not G.GAME.blind.disabled) and SMODS.has_enhancement(card,'m_steel') then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_draconic_giant" and not G.GAME.blind.disabled) and SMODS.has_enhancement(card,'m_mult') then return true end
   if (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_electric_giant" and not G.GAME.blind.disabled) and SMODS.has_enhancement(card,'m_gold') then return true end
   return false
end

