local wonder_trade = {
  name = "wonder_trade",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 1},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    if next(SMODS.find_mod("NanoMultiplayer")) then
      add_nemesis_info(info_queue)
    elseif next(SMODS.find_mod("Multiplayer")) then
      MP.UTILS.add_nemesis_info(info_queue)
    else
      info_queue[#info_queue+1] = {set = 'Other', key = 'multiplayer_ex_jok'}
    end
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Other",
  atlas = "maelmc_jokers",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.ending_shop and (not card.edition or card.edition.type ~= "mp_phantom") then
      local compat = {}
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.key ~= "j_maelmc_wonder_trade" then
          table.insert(compat,G.jokers.cards[i])
        end
      end
      local tosend = pseudorandom_element(compat,"wonder_trade")
      if tosend then
        local msg = wonder_trade_string_maker(tosend)
        MP.ACTIONS.wonder_trade(msg)
      end
    end
  end,
  add_to_deck = function(self, card, from_debuffed)
    if next(SMODS.find_mod("Multiplayer")) or next(SMODS.find_mod("NanoMultiplayer")) then
      if not from_debuffed and (not card.edition or card.edition.type ~= "mp_phantom") then
          MP.ACTIONS.send_phantom("j_maelmc_wonder_trade")
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if next(SMODS.find_mod("Multiplayer")) or next(SMODS.find_mod("NanoMultiplayer")) then
      if not from_debuff and (not card.edition or card.edition.type ~= "mp_phantom") then
          MP.ACTIONS.remove_phantom("j_maelmc_wonder_trade")
      end
    end
  end,
  custom_pool_func = true,
  in_pool = function(self)
    return (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code and MP.LOBBY.config.multiplayer_jokers and pokemon_in_pool(self)
  end
}

local mean_look = {
  name = "mean_look",
  poke_custom_prefix = "maelmc",
  pos = {x = 11, y = 1},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    if next(SMODS.find_mod("NanoMultiplayer")) then
      add_nemesis_info(info_queue)
    elseif next(SMODS.find_mod("Multiplayer")) then
      MP.UTILS.add_nemesis_info(info_queue)
    else
      info_queue[#info_queue+1] = {set = 'Other', key = 'multiplayer_ex_jok'}
    end
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_maelmc_shadow_tag', set = 'Tag', specific_vars = {localize { type = 'name_text', set = 'Enhanced', key = "m_maelmc_trapped" }} }
    return {vars = {localize { type = 'name_text', set = 'Tag', key = "tag_maelmc_shadow_tag" }}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Other",
  atlas = "maelmc_jokers",
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.selling_self then
      MP.ACTIONS.mean_look()
    end
  end,
  custom_pool_func = true,
  in_pool = function(self)
    return (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code and MP.LOBBY.config.multiplayer_jokers and pokemon_in_pool(self)
  end
}

return {
  name = "Maelmc's Multiplayer Jokers",
  list = {
    wonder_trade,
    mean_look
  },
}