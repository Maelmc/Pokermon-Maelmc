-- Sinistea
local sinistea={
  name = "sinistea",
  gen = 8,
  config = { extra = { rounds = 4 } },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_maelmc_cleanse_tag', set = 'Tag' }
    return {vars = {localize { type = 'name_text', set = 'Tag', key = "tag_maelmc_cleanse_tag" }, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_maelmc_cleanse_tag'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
      return nil, true -- This is for Joker retrigger purposes
    end

    return level_evo(self, card, context, "j_maelmc_polteageist")
  end,
}

-- Polteageist
local polteageist={
  name = "polteageist",
  gen = 8,
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_maelmc_cleanse_tag', set = 'Tag' }
    info_queue[#info_queue + 1] = { key = 'tag_ethereal', set = 'Tag' }
    return {vars = {localize { type = 'name_text', set = 'Tag', key = "tag_maelmc_cleanse_tag" },localize { type = 'name_text', set = 'Tag', key = "tag_ethereal" }}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_maelmc_cleanse_tag'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))

      G.E_MANAGER:add_event(Event({
        func = (function()
          add_tag(Tag('tag_ethereal'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end)
      }))
      return nil, true -- This is for Joker retrigger purposes
    end
  end,
}

-- Cursola
local cursola={
  name = "cursola",
  gen = 8,
  pos = {x = 16, y = 57},
  config = {extra = {Xmult_multi = 1.5, Xmult_multi1 = 2, volatile = 'left', perish_rounds = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'poke_volatile_'..card.ability.extra.volatile}
    end
    return {vars = {card.ability.extra.Xmult_multi, card.ability.extra.Xmult_multi1, card.ability.extra.perish_rounds}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  volatile = true,
  calculate = function(self, card, context)

    -- 'Til Death Do Us Part challenge perish rounds change
    if G.GAME.modifiers.maelmc_perish_3 then
      G.GAME.perishable_rounds = 3
    end

    -- add perish
    if context.setting_blind and not context.blueprint and volatile_active(self, card, card.ability.extra.volatile) then
      for _, target in ipairs(G.jokers.cards) do
        if target ~= card and not (target.ability.eternal or target.ability.perishable) and target.config.center.perishable_compat then
          target:set_perishable(true)
          target.ability.perish_tally = card.ability.extra.perish_rounds
          card:juice_up()
          card_eval_status_text(target, 'extra', nil, nil, nil, {message = localize('maelmc_perish_body_dot'), COLOUR = G.C.DARK_EDITION})
        end
      end
    end

    -- xmult on each perishable
    if context.other_joker and context.other_joker.ability and context.other_joker.ability.perishable then
      G.E_MANAGER:add_event(Event({
        func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
        end
      })) 
      if context.other_joker.ability.perish_tally > 0 then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_multi}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult_multi
        }
      else
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_multi1}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult_multi1
        }
      end
    end
  end,
}

-- Cufant
local cufant = {
  name = "cufant",
  gen = 8,
  pos = {x = 14, y = 58},
  config = {extra = {hazard_level = 1, done = false, to_steel = 1, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel

    return {vars = {abbr.hazard_level, abbr.to_steel, abbr.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      card.ability.extra.done = false
    end

    if context.end_of_round and context.cardarea == G.hand and not card.ability.extra.done then
      local count = 0
      local all_hazards = {}
      for _, v in pairs(G.hand.cards) do
        count = count + 1
        if SMODS.has_enhancement(v, "m_poke_hazard") and not v.destroyed and not v.shattered then
          table.insert(all_hazards,v)
        end
      end

      if #all_hazards <= card.ability.extra.to_steel then
        for _, v in pairs(all_hazards) do
          v:set_ability(G.P_CENTERS.m_steel,nil,true)
           card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize("maelmc_steel_ex"), colour = G.C.GREY})
        end
      else
        for _ = 1, card.ability.extra.to_steel do
          local i = pseudorandom("cufant",1,#all_hazards)
          all_hazards[i]:set_ability(G.P_CENTERS.m_steel,nil,true)
          card_eval_status_text(all_hazards[i], 'extra', nil, nil, nil, {message = localize("maelmc_steel_ex"), colour = G.C.GREY})
          table.remove(all_hazards,i)
        end
      end
      card.ability.extra.done = true
    end
    
    return level_evo(self, card, context, "j_maelmc_copperajah")
  end,
  add_to_deck = function(self, card, from_debuff)
    poke_change_hazard_level(card.ability.extra.hazard_level)
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end,
}

-- Copperajah
local copperajah = {
  name = "copperajah",
  gen = 8,
  pos = {x = 16, y = 58},
  config = {extra = {hazard_level = 1, done = false, to_steel = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel

    return {vars = {abbr.hazard_level, abbr.to_steel}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Metal",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      card.ability.extra.done = false
    end

    if context.end_of_round and context.cardarea == G.hand and not card.ability.extra.done then
      local count = 0
      local all_hazards = {}
      for _, v in pairs(G.hand.cards) do
        count = count + 1
        if SMODS.has_enhancement(v, "m_poke_hazard") and not v.destroyed and not v.shattered then
          table.insert(all_hazards,v)
        end
      end

      if #all_hazards <= card.ability.extra.to_steel then
        for _, v in pairs(all_hazards) do
          v:set_ability(G.P_CENTERS.m_steel,nil,true)
           card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize("maelmc_steel_ex"), colour = G.C.GREY})
        end
      else
        for _ = 1, card.ability.extra.to_steel do
          local i = pseudorandom("cufant",1,#all_hazards)
          all_hazards[i]:set_ability(G.P_CENTERS.m_steel,nil,true)
          card_eval_status_text(all_hazards[i], 'extra', nil, nil, nil, {message = localize("maelmc_steel_ex"), colour = G.C.GREY})
          table.remove(all_hazards,i)
        end
      end
      card.ability.extra.done = true
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    poke_change_hazard_level(card.ability.extra.hazard_level)
  end,
  remove_from_deck = function(self, card, from_debuff)
    poke_change_hazard_level(-card.ability.extra.hazard_level)
  end,
  megas = {"gmax_copperajah"}
}

-- Gmax Copperajah
local gmax_copperajah = {
  name = "gmax_copperajah",
  gen = 8,
  pos = {x = 8, y = 13},
  soul_pos = { x = 9, y = 13 },
  config = {extra = {Xmult_mod = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel

    local steel_count = 0
    if G.playing_cards then
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_steel") then
          steel_count = steel_count + 1
        end
      end
    end
    return {vars = {abbr.Xmult_mod, 1 + abbr.Xmult_mod * steel_count}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "AtlasJokersBasicGen08",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local steel_count = 0
        for _, v in pairs(G.playing_cards) do
          if SMODS.has_enhancement(v, "m_steel") then
            steel_count = steel_count + 1
          end
        end
        return {
          colour = G.C.XMULT,
          Xmult = 1 + card.ability.extra.Xmult_mod * steel_count
        }
      end
    end
  end,
}

local bloodmoon_ursaluna = {
  name = "bloodmoon_ursaluna",
  gen = 9,
  pos = {x = 0, y = 11},
  config = {extra = {Xmult = 1, Xmult2 = 1, Xmult_multi = 1.5, Xmult_mod = 0.1, suit = "Hearts"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local abbr = card.ability.extra
    return {vars = {abbr.suit, abbr.Xmult_multi, abbr.Xmult_mod, abbr.Xmult2}}
  end,
  designer = "Gem",
  rarity = "poke_safari",
  cost = 15,
  stage = "Basic",
  ptype = "Earth",
  atlas = "AtlasJokersBasicGen08",
  aux_poke = true,
  custom_pool_func = true,
  blueprint_compat = true,
  perishable_compat = false,
  calculate = function(self, card, context)

    if context.skipping_booster and not context.blueprint then
      card.ability.extra.Xmult_multi = card.ability.extra.Xmult_multi + card.ability.extra.Xmult_mod
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex"), colour = G.C.XMULT})
    end

    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and (not context.blueprint) then
      card.ability.extra.Xmult2 = card.ability.extra.Xmult2 * card.ability.extra.Xmult_multi
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          colour = G.C.XMULT,
          Xmult = card.ability.extra.Xmult2
        }
      end
    end

    if context.before or context.end_of_round then
      card.ability.extra.Xmult2 = card.ability.extra.Xmult
    end

  end,
  in_pool = function(self)
    return false
  end,
}

return {
  name = "Maelmc's Jokers Gen 8",
  list = {
    sinistea, polteageist,
    cursola,
    cufant, copperajah, gmax_copperajah,
    bloodmoon_ursaluna,
  },
}