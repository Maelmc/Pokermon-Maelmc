-- Glimmora 969
local glimmet={
  name = "glimmet",
  poke_custom_prefix = "maelmc",
  pos = {x = 4, y = 5},
  config = {extra = {hazard_ratio = 10, chips = 4, hazard_triggered = 0, hazard_per_ratio = 2}, evo_rqmt = 25},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards'}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard

    local to_add = math.floor(52 / abbr.hazard_ratio)
    if G.playing_cards then
      local count = #G.playing_cards
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          count = count - 1
        end
      end
      to_add = math.floor(count / abbr.hazard_ratio)
    end
    return {vars = {to_add * abbr.hazard_per_ratio, abbr.hazard_ratio, abbr.chips, math.max(0, self.config.evo_rqmt - abbr.hazard_triggered), abbr.hazard_per_ratio}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Earth",
  atlas = "Pokedex9-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_add_hazards(card.ability.extra.hazard_ratio)
      poke_add_hazards(card.ability.extra.hazard_ratio)
    end
    if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          if not context.blueprint then
            card.ability.extra.hazard_triggered = card.ability.extra.hazard_triggered + 1
          end
          return {
              chips = card.ability.extra.chips,
              card = card
          }
      end
    end
    return scaling_evo(self, card, context, "j_maelmc_glimmora", card.ability.extra.hazard_triggered, self.config.evo_rqmt)
  end,
}

-- Glimmora 970
local glimmora={
  name = "glimmora",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 5},
  config = {extra = {hazard_ratio = 10, chips = 8, hazard_triggered = 0, decrease_every = 20, hazard_per_ratio = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards'}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard

    local to_add = math.floor(52 / abbr.hazard_ratio)
    if G.playing_cards then
      local count = #G.playing_cards
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          count = count - 1
        end
      end
      to_add = math.floor(count / abbr.hazard_ratio)
    end
    return {vars = {to_add * abbr.hazard_per_ratio , abbr.hazard_ratio, abbr.chips, abbr.hazard_per_ratio, abbr.decrease_every, abbr.decrease_every - abbr.hazard_triggered }}
  end,
  rarity = 2,
  cost = 5,
  stage = "One",
  ptype = "Earth",
  atlas = "Pokedex9-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      for i = 1,card.ability.extra.hazard_per_ratio do
        poke_add_hazards(card.ability.extra.hazard_ratio)
      end
    end
    if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") then
      if context.other_card.debuff then
          return {
              message = localize('k_debuffed'),
              colour = G.C.RED,
              card = card,
          }
      else
          if not context.blueprint then
            card.ability.extra.hazard_triggered = card.ability.extra.hazard_triggered + 1
            if card.ability.extra.hazard_triggered >= card.ability.extra.decrease_every then
              card.ability.extra.hazard_triggered = card.ability.extra.hazard_triggered - card.ability.extra.decrease_every
              card.ability.extra.hazard_ratio = math.max(card.ability.extra.hazard_per_ratio,card.ability.extra.hazard_ratio - 1)
            end
          end
          return {
              chips = card.ability.extra.chips,
              card = card
          }
      end
    end
  end,
}

-- Cufant
local cufant = {
  name = "cufant",
  poke_custom_prefix = "maelmc",
  pos = {x = 4, y = 5},
  config = {extra = {hazard_ratio = 10, to_steel = 1, reset_steel = 1, rounds = 5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards'}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard

    local to_add = math.floor(52 / abbr.hazard_ratio)
    if G.playing_cards then
      local count = #G.playing_cards
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          count = count - 1
        end
      end
      to_add = math.floor(count / abbr.hazard_ratio)
    end
    return {vars = {to_add, abbr.hazard_ratio, abbr.reset_steel, abbr.rounds}}
  end,
  rarity = 3,
  cost = 7,
  stage = "Basic",
  ptype = "Metal",
  atlas = "Pokedex8-Maelmc",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_add_hazards(card.ability.extra.hazard_ratio)
      card.ability.extra.to_steel = card.ability.extra.reset_steel
    end
    if context.individual and not context.blueprint and context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and card.ability.extra.to_steel > 0 then
      context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
      card.ability.extra.to_steel = card.ability.extra.to_steel - 1
      return {
        message = localize("maelmc_steel"),
        colour = G.C.GREY
      }
    end
    return level_evo(self, card, context, "j_maelmc_copperajah")
  end,
}

-- Copperajah
local copperajah = {
  name = "copperajah",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 5},
  config = {extra = {hazard_ratio = 10, to_steel = 3, reset_steel = 3, mult = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'mega_poke'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards'}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard

    local to_add = math.floor(52 / abbr.hazard_ratio)
    local steel_count = 0
    if G.playing_cards then
      local count = #G.playing_cards
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          count = count - 1
        end
        if SMODS.has_enhancement(v, "m_steel") then
          steel_count = steel_count + 1
        end
      end
      to_add = math.floor(count / abbr.hazard_ratio)
    end
    return {vars = {to_add, abbr.hazard_ratio, abbr.reset_steel, abbr.mult, abbr.mult * steel_count}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Metal",
  atlas = "Pokedex8-Maelmc",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_add_hazards(card.ability.extra.hazard_ratio)
      card.ability.extra.to_steel = card.ability.extra.reset_steel
    end
    if context.individual and not context.blueprint and context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and card.ability.extra.to_steel > 0 then
      context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
      card.ability.extra.to_steel = card.ability.extra.to_steel - 1
      return {
        message = localize("maelmc_steel"),
        colour = G.C.GREY
      }
    end
    if context.joker_main then
        local steel_count = 0
        for _, v in pairs(G.playing_cards) do
          if SMODS.has_enhancement(v, "m_steel") then
            steel_count = steel_count + 1
          end
        end
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.mult * steel_count}},
          colour = G.C.MULT,
          mult = card.ability.extra.mult * steel_count
        }
      end
  end,
  megas = {"gmax_copperajah"}
}

-- Gmax Copperajah
local gmax_copperajah = {
  name = "gmax_copperajah",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 2},
  soul_pos = { x = 5, y = 5 },
  config = {extra = {hazard_ratio = 10, to_steel = 5, reset_steel = 5, Xmult = 0.1, mult = 6}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards'}
    info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard

    local to_add = math.floor(52 / abbr.hazard_ratio)
    local steel_count = 0
    if G.playing_cards then
      local count = #G.playing_cards
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_poke_hazard") then
          count = count - 1
        end
        if SMODS.has_enhancement(v, "m_steel") then
          steel_count = steel_count + 1
        end
      end
      to_add = math.floor(count / abbr.hazard_ratio)
    end
    return {vars = {to_add, abbr.hazard_ratio, abbr.reset_steel, abbr.Xmult, 1 + abbr.Xmult * steel_count, abbr.mult, abbr.mult * steel_count }}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "Gmax-Maelmc",
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.setting_blind then
      poke_add_hazards(card.ability.extra.hazard_ratio)
      card.ability.extra.to_steel = card.ability.extra.reset_steel
    end
    if context.individual and not context.blueprint and context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and card.ability.extra.to_steel > 0 then
      context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
      card.ability.extra.to_steel = card.ability.extra.to_steel - 1
      return {
        message = localize("maelmc_gmax_steelsurge"),
        colour = G.C.GREY
      }
    end
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
          mult = card.ability.extra.mult * steel_count,
          Xmult = 1 + card.ability.extra.Xmult * steel_count
        }
      end
    end
  end,
}

return {name = "Maelmc's Jokers 1", 
        list = {glimmet, glimmora, cufant, copperajah, gmax_copperajah},
}