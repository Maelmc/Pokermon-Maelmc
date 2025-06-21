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
  cost = 5,
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
  config = {extra = {hazard_ratio = 10, chips = 8, hazard_triggered = 0, decrease_every = 25, hazard_per_ratio = 2}},
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
  rarity = "poke_safari",
  cost = 6,
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

local ogerpon={
  name = "ogerpon", 
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 12},
  soul_pos = {x = 1, y = 12},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
  end,
  rarity = 4, 
  cost = 20,
  stage = "Basic",
  ptype = "Grass",
  atlas = "Pokedex9-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Grass")
  end,
}

local ogerpon_wellspring={
  name = "ogerpon_wellspring", 
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 12},
  soul_pos = {x = 2, y = 12},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
  end,
  rarity = 4, 
  cost = 20,
  stage = "Basic",
  ptype = "Water",
  atlas = "Pokedex9-Maelmc",
  aux_poke = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Water")
  end
}

local ogerpon_hearthflame={
  name = "ogerpon_hearthflame", 
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 12},
  soul_pos = {x = 3, y = 12},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
  end,
  rarity = 4, 
  cost = 20,
  stage = "Basic",
  ptype = "Fire",
  atlas = "Pokedex9-Maelmc",
  aux_poke = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Fire")
  end
}

local ogerpon_cornerstone={
  name = "ogerpon_cornerstone", 
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 12},
  soul_pos = {x = 4, y = 12},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
  end,
  rarity = 4, 
  cost = 20,
  stage = "Basic",
  ptype = "Earth",
  atlas = "Pokedex9-Maelmc",
  aux_poke = true,
  no_collection = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- stone cards as their own rank in the lovely patch

  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    apply_type_sticker(card, "Earth")
  end
}

return {
  name = "Maelmc's Jokers Gen 9",
  list = {
    glimmet, glimmora,
    --ogerpon, ogerpon_wellspring, ogerpon_hearthflame, ogerpon_cornerstone,
  },
}