-- Galarian Corsola 222
local g_corsola={
  name = "g_corsola",
  poke_custom_prefix = "maelmc",
  pos = {x = 3, y = 3},
  config = {extra = {Xmult_multi = 1.5, volatile = 'left', perish_rounds = 3, perished_to_evo = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local compatible = false
    if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
        local target = G.jokers.cards[#G.jokers.cards]
        compatible = (target ~= card and target.config.center.perishable_compat == true and not target.ability.perishable)
    end 
    local main_end = { -- creates the "compatible" or "incompatible" box, copied from VanillaRemade's Blueprint
            {
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                        }
                    }
                }
            }
        }
    return {vars = {card.ability.extra.Xmult_multi,  card.ability.extra.perish_rounds, card.ability.extra.perished_to_evo}, main_end = main_end}
  end,
  rarity = 2,
  cost = 7,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "Regionals-Maelmc",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  volatile = true,
  calculate = function(self, card, context)

    -- add perish
    if context.setting_blind and not context.blueprint and volatile_active(self, card, card.ability.extra.volatile) then
      local target = G.jokers.cards[#G.jokers.cards]
      if target ~= card and not (target.ability.eternal or target.ability.perishable) and target.config.center.perishable_compat then
        target:set_perishable(true)
        target.ability.perish_tally = card.ability.extra.perish_rounds
        card:juice_up()
        card_eval_status_text(target, 'extra', nil, nil, nil, {message = localize('maelmc_cursed_body_dot'), COLOUR = G.C.DARK_EDITION})
      end
    end

    -- xmult on each perishable
    if context.other_joker and context.other_joker.ability and context.other_joker.ability.perishable and context.other_joker.ability.perish_tally > 0 then
        G.E_MANAGER:add_event(Event({
            func = function()
                context.other_joker:juice_up(0.5, 0.5)
                return true
            end
        })) 
        return {
            message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_multi}}, 
            colour = G.C.XMULT,
            Xmult_mod = card.ability.extra.Xmult_multi
        }
    end

    if G.jokers and G.jokers.cards then
        local evo_con = 0
        for _, v in ipairs(G.jokers.cards) do
            if v.ability.perishable and v.ability.ability.perish_tally <= 0 then
                evo_con = evo_con + 1
            end
        end
        return scaling_evo(self, card, context, "j_poke_cursola", evo_con, card.ability.extra.perished_to_evo)
    end
  end,
}

return {
  name = "Maelmc's Jokers Gen 2",
  list = {
    g_corsola,
  },
}