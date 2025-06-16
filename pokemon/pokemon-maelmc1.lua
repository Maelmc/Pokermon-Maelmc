-- https://stackoverflow.com/questions/2282444/how-to-check-if-a-table-contains-an-element-in-lua
-- function to check if the table contains an element, used to search for specific hazard cards for cufant's family
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

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

-- Cufant
local cufant = {
  name = "cufant",
  poke_custom_prefix = "maelmc",
  pos = {x = 4, y = 5},
  config = {extra = {hazard_ratio = 10, to_steel = 1, reset_steel = 1, rounds = 5, all_hazard = {}, hazard_to_steel = {}}},
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
      card.ability.extra.hazard_to_steel = {}
      card.ability.extra.all_hazard = {}
    end
    
    -- this is not super clean code, there are probably better ways to do this
    if context.end_of_round and context.cardarea == G.hand then
      if #card.ability.extra.all_hazard == 0 and #card.ability.extra.hazard_to_steel == 0 then
        -- find all hazard cards in hand
        card.ability.extra.hazard_to_steel = {}
        card.ability.extra.all_hazard = {}
        local count = 0
        for _, v in pairs(G.hand.cards) do
          count = count + 1
          if SMODS.has_enhancement(v, "m_poke_hazard") then
            table.insert(card.ability.extra.all_hazard,v)
          end
        end

        -- get 3 of them
        if #card.ability.extra.all_hazard <= card.ability.extra.reset_steel then
          --print("3 or less")
          card.ability.extra.hazard_to_steel = card.ability.extra.all_hazard
        else 
          for i = 1,card.ability.extra.reset_steel do
            -- get one to hazard_to_steel and remove it from pos
            local tmp_hazard = math.random(#card.ability.extra.all_hazard)
            card.ability.extra.hazard_to_steel[#card.ability.extra.hazard_to_steel+1]=card.ability.extra.all_hazard[tmp_hazard]
            table.remove(card.ability.extra.all_hazard,tmp_hazard)
          end
        end
      end

      -- turn them into steel
      if context.individual and not context.blueprint and table.contains(card.ability.extra.hazard_to_steel,context.other_card) then
        context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
        return {
          message = localize("maelmc_steel"),
          colour = G.C.GREY
        }
      end
    end
    return level_evo(self, card, context, "j_maelmc_copperajah")
  end,
}

-- Copperajah
local copperajah = {
  name = "copperajah",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 5},
  config = {extra = {hazard_ratio = 10, reset_steel = 3, mult = 3, all_hazard = {}, hazard_to_steel = {}}},
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
      card.ability.extra.hazard_to_steel = {}
      card.ability.extra.all_hazard = {}
    end
    
    -- this is not super clean code, there are probably better ways to do this
    if context.end_of_round and context.cardarea == G.hand then
      if #card.ability.extra.all_hazard == 0 and #card.ability.extra.hazard_to_steel == 0 then
        -- find all hazard cards in hand
        card.ability.extra.hazard_to_steel = {}
        card.ability.extra.all_hazard = {}
        local count = 0
        for _, v in pairs(G.hand.cards) do
          count = count + 1
          if SMODS.has_enhancement(v, "m_poke_hazard") then
            table.insert(card.ability.extra.all_hazard,v)
          end
        end

        -- get 3 of them
        if #card.ability.extra.all_hazard <= card.ability.extra.reset_steel then
          card.ability.extra.hazard_to_steel = card.ability.extra.all_hazard
        else 
          for i = 1,card.ability.extra.reset_steel do
            -- get one to hazard_to_steel and remove it from pos
            local tmp_hazard = math.random(#card.ability.extra.all_hazard)
            card.ability.extra.hazard_to_steel[#card.ability.extra.hazard_to_steel+1]=card.ability.extra.all_hazard[tmp_hazard]
            table.remove(card.ability.extra.all_hazard,tmp_hazard)
          end
        end
      end

      -- turn them into steel
      if context.individual and not context.blueprint and table.contains(card.ability.extra.hazard_to_steel,context.other_card) then
        context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
        return {
          message = localize("maelmc_steel"),
          colour = G.C.GREY
        }
      end
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
  megas = {"mega_copperajah"}
}

-- Gmax Copperajah
local mega_copperajah = {
  name = "mega_copperajah",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 2},
  soul_pos = { x = 5, y = 5 },
  config = {extra = {hazard_ratio = 10, to_steel = 5, reset_steel = 5, Xmult = 0.1, mult = 6, all_hazard = {}, hazard_to_steel = {}}},
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
      card.ability.extra.hazard_to_steel = {}
      card.ability.extra.all_hazard = {}
    end
    
    -- this is not super clean code, there are probably better ways to do this
    if context.end_of_round and context.cardarea == G.hand then
      if #card.ability.extra.all_hazard == 0 and #card.ability.extra.hazard_to_steel == 0 then
        -- find all hazard cards in hand
        card.ability.extra.hazard_to_steel = {}
        card.ability.extra.all_hazard = {}
        
        local count = 0
        for _, v in pairs(G.hand.cards) do
          count = count + 1
          if SMODS.has_enhancement(v, "m_poke_hazard") then
            table.insert(card.ability.extra.all_hazard,v)
          end
        end

        -- get 3 of them
        if #card.ability.extra.all_hazard <= card.ability.extra.reset_steel then
          card.ability.extra.hazard_to_steel = card.ability.extra.all_hazard
        else 
          for i = 1,card.ability.extra.reset_steel do
            -- get one to hazard_to_steel and remove it from pos
            local tmp_hazard = math.random(#card.ability.extra.all_hazard)
            card.ability.extra.hazard_to_steel[#card.ability.extra.hazard_to_steel+1]=card.ability.extra.all_hazard[tmp_hazard]
            table.remove(card.ability.extra.all_hazard,tmp_hazard)
          end
        end
      end

      -- turn them into steel
      if context.individual and not context.blueprint and table.contains(card.ability.extra.hazard_to_steel,context.other_card) then
        context.other_card:set_ability(G.P_CENTERS.m_steel,nil,true)
        return {
          message = localize("maelmc_gmax_steelsurge"),
          colour = G.C.GREY
        }
      end
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

-- Spiritomb 442
local odd_keystone={
  name = "odd_keystone",
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 0},
  config = {extra = {evolve_progress = 0, evolve_after = 108, evolve_using = "The Soul"}},
  loc_vars = function(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = { set = 'Spectral', key = 'c_soul'}
    return {vars = {abbr.evolve_progress, abbr.evolve_after, abbr.evolve_using}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  atlas = "Custom-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if using The Soul, evolve
    --[[if context.using_consumeable and context.consumeable and context.consumeable.ability.name == card.ability.extra.evolve_using then
      
      local nb_joker_pre_soul = #G.jokers.cards
      local nb_consumables_pre_soul = #G.consumeables.cards

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0, func = function()
        local legendary_to_delete = G.jokers.cards[#G.jokers.cards]

        -- if MissingNo, remove all the created items
        if legendary_to_delete.ability.name == "missingno" then
          local nb_jokers = #G.jokers.cards
          while nb_joker_pre_soul < nb_jokers do
            G.jokers.cards[#G.jokers.cards]:remove()
            nb_jokers = #G.jokers.cards
          end
          local nb_consumables = #G.consumeables.cards
          while nb_consumables_pre_soul < nb_consumables do
            G.consumeables.cards[#G.consumeables.cards]:remove()
            nb_consumables = #G.consumeables.cards
          end
        else
          -- remove the legendary that is not missingno
          legendary_to_delete:remove()
        end

        attention_text({
          text = localize('maelmc_consume'),
          scale = 1.3, 
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.SECONDARY_SET.Tarot,
          align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
          offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
          silent = true
        })
        return true end})
      )
      return {
        message = poke_evolve(card, "j_maelmc_spiritombl"),
      }
    end]]

    if context.remove_playing_cards and not context.blueprint then
      for _, _ in ipairs(context.removed) do
        card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
        G.E_MANAGER:add_event(Event({
          func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_soul_collected')}); return true
          end
        }))
      end
    end

    if context.selling_card and not context.selling_self and not context.blueprint then
      if context.card.config.center.rarity then -- if it's a joker, and thus has a rarity
        if context.card.config.center.rarity == 1 or context.card.config.center.rarity == 2 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + context.card.config.center.rarity

        elseif context.card.config.center.rarity == "poke_safari" or context.card.config.center.rarity == "poke_mega" or context.card.config.center.rarity == 3 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 5

        elseif context.card.config.center.rarity == 4 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 10

        else -- if somehow the joker isn't common, uncommon, rare, safari, legendary or mega??
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
        end

      else -- if it's a consumeable
        card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
      end
      G.E_MANAGER:add_event(Event({
        func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_soul_collected')}); return true
        end
      }))
    end

    return scaling_evo(self, card, context, "j_maelmc_spiritomb", card.ability.extra.evolve_progress, card.ability.extra.evolve_after)
  end,
}

local spiritomb={
  name = "spiritomb",
  poke_custom_prefix = "maelmc",
  pos = {x = 13, y = 3},
  config = {extra = {chips = 108, mult = 108, h_size = 3, to_negative = 108}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    if not card.edition or (card.edition and not card.edition.negative) then
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end
    return {vars = {abbr.chips, abbr.mult, abbr.h_size, abbr.to_negative}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "Pokedex4-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.playing_card_added and not card.getting_sliced and #G.playing_cards >= card.ability.extra.to_negative and not (card.edition and card.edition.negative) then
      local edition = {negative = true}
      card:set_edition(edition, true)
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          mult = card.ability.extra.mult,
          chips = card.ability.extra.chips,
          card = card
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end
}

--[[local spiritombl={
  name = "spiritombl",
  poke_custom_prefix = "maelmc",
  pos = {x = 10, y = 10},
  soul_pos = { x = 11, y = 10 },
  config = {extra = {Xmult_mod = 1.08, to_negative = 108}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    if not card.edition or (card.edition and not card.edition.negative) then
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end
    return {vars = {abbr.Xmult_mod, math.max(abbr.Xmult_mod, (G.playing_cards and #G.playing_cards or 1) * abbr.Xmult_mod), abbr.to_negative}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Psychic",
  atlas = "Pokedex4-Maelmc",
  aux_poke = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local Xmult = card.ability.extra.Xmult_mod * #G.playing_cards
        if Xmult > 1 then
          return {
            colour = G.C.XMULT,
            Xmult = Xmult,
            card = card
          }
        end
      end
    end
  end,
  in_pool = function(self)
    return false
  end
}]]

-- Gym Leader
local gym_leader={
  name = "gym_leader",
  poke_custom_prefix = "maelmc",
  pos = {x = 1, y = 0},
  config = {extra = {boss = false, form = "Earth"}},
  loc_vars = function(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"Type"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'gym_leader_tag_pool', vars = {'Uncommon', 'Rare', 'Handy', 'Garbage', 'Investment'}}
    return {vars = {abbr.form}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Other",
  atlas = "Custom-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    
    if context.setting_blind and context.blind.boss then
      card.ability.extra.boss = true
    end

    if context.end_of_round and card.ability.extra.boss then
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_gym_beaten')}); return true
        end
      }))
      local tag = ''
      local tag_choice = pseudorandom('sylveon')
      if tag_choice < 1/6 then
        tag = 'tag_handy'
      elseif tag_choice < 2/6 then
        tag = 'tag_garbage'
      elseif tag_choice < 3/6 then
        tag = 'tag_investment'
      elseif tag_choice < 4/6 then
        tag = 'tag_buffoon'
      elseif tag_choice < 5/6 then
        tag = 'tag_uncommon'
      else
        tag = 'tag_rare'
      end
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = (function()
            add_tag(Tag(tag))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
      }))

      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          func = (function()
              local energy_name = string.lower("c_poke_"..card.ability.extra.form.."_energy")
              local energy = create_card("Energy", G.pack_cards, nil, nil, nil, nil, energy_name, nil)
              energy:add_to_deck()
              G.consumeables:emplace(energy)
              G.GAME.consumeable_buffer = 0
            return true
        end)}))
      end

      card.ability.extra.boss = false
      return true
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      local poketype_list = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Darkness", "Metal", "Fairy", "Dragon", "Earth"}
      card.ability.extra.form = pseudorandom_element(poketype_list, pseudoseed("gym_leader"))
      self:set_sprites(card)
    end
  end,
  set_sprites = function(self, card, front)
    local leader_table = {
      Grass = {x = 1, y = 0},
      Fire = {x = 2, y = 0},
      Water = {x = 3, y = 0},
      Lightning = {x = 4, y = 0},
      Psychic = {x = 5, y = 0},
      Fighting = {x = 6, y = 0},
      Colorless = {x = 7, y = 0},
      Darkness = {x = 8, y = 0},
      Metal = {x = 9, y = 0},
      Fairy = {x = 10, y = 0},
      Dragon = {x = 11, y = 0},
      Earth = {x = 12, y = 0},
    }
    if card.ability and card.ability.extra and leader_table[card.ability.extra.form] then
      card.children.center:set_sprite_pos(leader_table[card.ability.extra.form])
    else
      card.children.center:set_sprite_pos(leader_table["Earth"])
    end 
  end,
}

-- Kecleon 352
local kecleon={
  name = "kecleon",
  poke_custom_prefix = "maelmc",
  pos = {x = 3, y = 10},
  config = {extra = {type_change = 0, mult_mod = 6, current_type = "Colorless"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.mult_mod, abbr.mult_mod * abbr.type_change}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "Pokedex3-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- all context to be futureproof
    if not context.blueprint then
      local type = get_type(card)
      if type ~= card.ability.extra.current_type then
        card.ability.extra.current_type = type
        card.ability.extra.type_change = card.ability.extra.type_change + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_color_change')})
      end
    end
    
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = card.ability.extra.mult_mod * card.ability.extra.type_change
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

  end,
}

-- Lunatone 337
local lunatone={
  name = "lunatone",
  poke_custom_prefix = "maelmc",
  pos = {x = 5, y = 8},
  config = {extra = {clubs_odds = 4, suit = "Clubs", level_amt = 1, level_odds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), abbr.clubs_odds, abbr.suit, abbr.level_odds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Earth",
  atlas = "Pokedex3-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      -- turn cards to club
      local clubs_trigg = 0
      for _, v in pairs(context.scoring_hand) do
        if not (v:is_suit(card.ability.extra.suit)) and (pseudorandom('lunatone') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.clubs_odds) then
          clubs_trigg = 1
          local rank = v:get_id()
          if rank > 9 then
            if rank == 10 then rank = "T" end
            if rank == 11 then rank = "J" end
            if rank == 12 then rank = "Q" end
            if rank == 13 then rank = "K" end
            if rank == 14 then rank = "A" end
          end
          v:set_base(G.P_CARDS["C_"..rank])
        end
      end
      if clubs_trigg == 1 then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_clubs')})
      end

      if (pseudorandom('lunatone') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.level_odds) then
        local hand = context.scoring_name
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand, 'poker_hands'), chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult, level=G.GAME.hands[hand].level})
        level_up_hand(card, hand, nil, card.ability.extra.level_amt)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
      end
    end
  end,
}

-- Solrock 338
local solrock={
  name = "solrock",
  poke_custom_prefix = "maelmc",
  pos = {x = 6, y = 8},
  config = {extra = {hearts_odds = 4, suit = "Hearts", wild_odds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    local abbr = card.ability.extra
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), abbr.hearts_odds, abbr.suit, abbr.wild_odds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Earth",
  atlas = "Pokedex3-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      -- turn cards to club
      local hearts_trigg = 0
      local wild_trigg = 0
      for _, v in pairs(context.scoring_hand) do
        if not (v:is_suit(card.ability.extra.suit)) then
          if (pseudorandom('solrock') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.hearts_odds) then
            hearts_trigg = 1
            local rank = v:get_id()
            if rank > 9 then
              if rank == 10 then rank = "T" end
              if rank == 11 then rank = "J" end
              if rank == 12 then rank = "Q" end
              if rank == 13 then rank = "K" end
              if rank == 14 then rank = "A" end
            end
            v:set_base(G.P_CARDS["H_"..rank])
          elseif not (SMODS.has_enhancement(v, "m_wild")) and (pseudorandom('solrock') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.wild_odds) then
            wild_trigg = 1
            v:set_ability(G.P_CENTERS.m_wild,nil,true)
          end
        end
      end
      if hearts_trigg == 1 then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_hearts')})
      end
      if wild_trigg == 1 then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_wild')})
      end
    end
  end,
}

-- Inkay 686
local inkay={
  name = "inkay",
  poke_custom_prefix = "maelmc",
  pos = {x = 8, y = 2},
  config = {extra = {mult = 8, odds = 2, flipped_triggered = 0}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {50, abbr.mult, math.max(0, self.config.evo_rqmt - abbr.flipped_triggered)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dark",
  atlas = "Pokedex6-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- flag all face down cards
    if G.hand then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i].maelmc_flipped = true
        end
      end
    end

    -- give mult per scored face down card
    if context.individual and context.cardarea == G.play and context.other_card.maelmc_flipped then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        card.ability.extra.flipped_triggered = card.ability.extra.flipped_triggered + 1
        return {
          mult = card.ability.extra.mult ,
          card = card
        }
      end
    end

    -- remove flag and flip back cards
    if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
      G.GAME.modifiers.flipped_cards = 2
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
      end
      for _, v in pairs(G.playing_cards) do
        if v.maelmc_flipped then
          v.maelmc_flipped = nil
        end
      end
    end
    return scaling_evo(self, card, context, "j_maelmc_malamar", card.ability.extra.flipped_triggered, self.config.evo_rqmt)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.modifiers.flipped_cards = card.ability.extra.odds
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.modifiers.flipped_cards = nil
  end
}

-- Malamar 687
local malamar={
  name = "malamar",
  poke_custom_prefix = "maelmc",
  pos = {x = 9, y = 2},
  config = {extra = {Xmult = 1.5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.Xmult}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "Pokedex6-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- flag all face down cards
    if G.hand then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i].maelmc_flipped = true
        end
      end
    end

    -- give mult per scored face down card
    if context.individual and context.cardarea == G.play and context.other_card.maelmc_flipped then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        return {
          Xmult = card.ability.extra.Xmult ,
          card = card
        }
      end
    end

    -- remove flag and flip back cards
    if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
      G.GAME.modifiers.flipped_cards = 1
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
      end
      for _, v in pairs(G.playing_cards) do
        if v.maelmc_flipped then
          v.maelmc_flipped = nil
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.modifiers.flipped_cards = 1
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.modifiers.flipped_cards = nil
  end
}

-- Binacle 688
local binacle={
  name = "binacle",
  poke_custom_prefix = "maelmc",
  pos = {x = 10, y = 2},
  config = {extra = {value = "7", retriggers = 1, retrigger_hand = 2, retrigger_held = 2, retriggered_hand = 0, retriggered_held = 0, retriggered_held_end = 0, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.value, abbr.retrigger_hand, abbr.retrigger_held, abbr.retriggers, abbr.rounds}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Base",
  ptype = "Earth",
  atlas = "Pokedex6-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.setting_blind then
      card.ability.extra.retriggered_held_end = 0
    end
    if context.before then
      card.ability.extra.retriggered_hand = 0
      card.ability.extra.retriggered_held = 0
    end

    if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 7 and card.ability.extra.retriggered_hand < card.ability.extra.retrigger_hand then
      if not context.blueprint then
        card.ability.extra.retriggered_hand = card.ability.extra.retriggered_hand + 1
      end
      return {
          message = localize('k_again_ex'),
          repetitions = card.ability.extra.retriggers,
          card = card
      }
    end

    if context.repetition and context.cardarea == G.hand and context.other_card:get_id() == 7 then
      if context.end_of_round then
        if card.ability.extra.retriggered_held_end < card.ability.extra.retrigger_held then
          if not context.blueprint then
            card.ability.extra.retriggered_held_end = card.ability.extra.retriggered_held_end + 1
          end
          return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
          }
        end
        
      elseif card.ability.extra.retriggered_held < card.ability.extra.retrigger_held then
        if not context.blueprint then
          card.ability.extra.retriggered_held = card.ability.extra.retriggered_held + 1
        end
        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
        }
      end
    end

    return level_evo(self, card, context, "j_maelmc_barbaracle")
  end,
}

-- Barbaracle 689
local barbaracle={
  name = "barbaracle",
  poke_custom_prefix = "maelmc",
  pos = {x = 11, y = 2},
  config = {extra = {value = "7", retriggers = 1, retrigger_hand = 7, retrigger_held = 7, retriggered_hand = 0, retriggered_held = 0, retriggered_held_end = 0}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.value, abbr.retrigger_hand, abbr.retrigger_held, abbr.retriggers}}
  end,
  rarity = "poke_safari",
  cost = 6,
  stage = "One",
  ptype = "Earth",
  atlas = "Pokedex6-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.setting_blind then
      card.ability.extra.retriggered_held_end = 0
    end
    if context.before then
      card.ability.extra.retriggered_hand = 0
      card.ability.extra.retriggered_held = 0
    end

    if context.repetition and context.cardarea == G.play and card.ability.extra.retriggered_hand < card.ability.extra.retrigger_hand then
      if (context.other_card:get_id() == 7) then
        if not context.blueprint then
          card.ability.extra.retriggered_hand = card.ability.extra.retriggered_hand + 1
        end
        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
        }
      end
    end

    if context.repetition and context.cardarea == G.hand and context.other_card:get_id() == 7 then
      if context.end_of_round then
        if card.ability.extra.retriggered_held_end < card.ability.extra.retrigger_held then
          if not context.blueprint then
            card.ability.extra.retriggered_held_end = card.ability.extra.retriggered_held_end + 1
          end
          return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
          }
        end

      elseif card.ability.extra.retriggered_held < card.ability.extra.retrigger_held then
        if not context.blueprint then
          card.ability.extra.retriggered_held = card.ability.extra.retriggered_held + 1
        end
        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
        }
      end
    end

  end,
}

-- Ralts 280
local ralts={
  name = "ralts",
  poke_custom_prefix = "maelmc",
  pos = {x = 8, y = 2},
  config = {extra = {mult_mod = 1, planet_amount = 1, priestress_odds = 8, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_high_priestess'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local mult = 0
    for k, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.planet_amount, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.priestress_odds, card.ability.extra.rounds}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Base",
  ptype = "Psychic",
  atlas = "Pokedex3-Maelmc",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      if (pseudorandom('ralts') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.priestress_odds) then
        local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_high_priestess")
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("k_plus_tarot"), colour = G.C.PURPLE})
      else
        for _ = 1,card.ability.extra.planet_amount do
          local temp_hands = {}
          local min_level = nil
          for k, v in pairs(G.GAME.hands) do
            if v.visible then
              local hand = v
              hand.handname = k
              if next(temp_hands) == nil then
                table.insert(temp_hands, hand)
                min_level = hand.level
              elseif min_level == hand.level then
                table.insert(temp_hands, hand)
              elseif min_level > hand.level then
                temp_hands = {}
                table.insert(temp_hands, hand)
                min_level = hand.level
              end
            end
          end
          
          local _hand =  pseudorandom_element(temp_hands, pseudoseed('ralts'))
          local _planet = nil
          for x, y in pairs(G.P_CENTER_POOLS.Planet) do
            if y.config.hand_type == _hand.handname then
              _planet = y.key
              break
            end
          end

          local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        for _, v in pairs(G.GAME.hands) do
          mult = mult + (v.level - 1) * card.ability.extra.mult_mod
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

    return level_evo(self, card, context, "j_maelmc_kirlia")
  end,
}

-- Kirlia 281
local kirlia={
  name = "kirlia",
  poke_custom_prefix = "maelmc",
  pos = {x = 9, y = 2},
  config = {extra = {mult_mod = 2, planet_amount = 1, priestress_odds = 4, rounds = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_black_hole'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local mult = 0
    for k, v in pairs(G.GAME.hands) do
      mult = mult + (v.level - 1) * card.ability.extra.mult_mod
    end
    return {vars = {card.ability.extra.mult_mod, mult, card.ability.extra.planet_amount, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.priestress_odds, card.ability.extra.rounds}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Psychic",
  atlas = "Pokedex3-Maelmc",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      local edition = {negative = true}

      if (pseudorandom('kirlia') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.priestress_odds) then
        local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_high_priestess")
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("k_plus_tarot"), colour = G.C.PURPLE})

      else
        for _ = 1,card.ability.extra.planet_amount do
          local temp_hands = {}
          local min_level = nil
          for k, v in pairs(G.GAME.hands) do
            if v.visible then
              local hand = v
              hand.handname = k
              if next(temp_hands) == nil then
                table.insert(temp_hands, hand)
                min_level = hand.level
              elseif min_level == hand.level then
                table.insert(temp_hands, hand)
              elseif min_level > hand.level then
                temp_hands = {}
                table.insert(temp_hands, hand)
                min_level = hand.level
              end
            end
          end
          
          local _hand =  pseudorandom_element(temp_hands, pseudoseed('kirlia'))
          local _planet = nil
          for x, y in pairs(G.P_CENTER_POOLS.Planet) do
            if y.config.hand_type == _hand.handname then
              _planet = y.key
              break
            end
          end

          local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet)
          _card:set_edition(edition, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local mult = 0
        for _, v in pairs(G.GAME.hands) do
          mult = mult + (v.level - 1) * card.ability.extra.mult_mod
        end
        if mult > 0 then
          return {
            colour = G.C.MULT,
            mult = mult,
            card = card
          }
        end
      end
    end

    return level_evo(self, card, context, "j_maelmc_gardevoir")
  end,
}

-- Gardevoir 282
local gardevoir={
  name = "gardevoir",
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 3},
  config = {extra = {xmult_mod = 0.05, planet_amount = 2, blackhole_odds = 8}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_black_hole'}
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Foxthor, One Punch Idiot"}}
    local xmult = 1
    for k, v in pairs(G.GAME.hands) do
      xmult = xmult + (v.level - 1) * card.ability.extra.xmult_mod
    end
    return {vars = {card.ability.extra.xmult_mod, xmult, card.ability.extra.planet_amount, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.blackhole_odds}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Psychic",
  atlas = "Pokedex3-Maelmc",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      local edition = {negative = true}

      if (pseudorandom('gardevoir') < (G.GAME and G.GAME.probabilities.normal or 1)/card.ability.extra.blackhole_odds) then
        local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_black_hole")
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})

      else
        for _ = 1,card.ability.extra.planet_amount do
          local temp_hands = {}
          local min_level = nil
          for k, v in pairs(G.GAME.hands) do
            if v.visible then
              local hand = v
              hand.handname = k
              if next(temp_hands) == nil then
                table.insert(temp_hands, hand)
                min_level = hand.level
              elseif min_level == hand.level then
                table.insert(temp_hands, hand)
              elseif min_level > hand.level then
                temp_hands = {}
                table.insert(temp_hands, hand)
                min_level = hand.level
              end
            end
          end
          
          local _hand =  pseudorandom_element(temp_hands, pseudoseed('kirlia'))
          local _planet = nil
          for x, y in pairs(G.P_CENTER_POOLS.Planet) do
            if y.config.hand_type == _hand.handname then
              _planet = y.key
              break
            end
          end

          local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet)
          _card:set_edition(edition, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
          card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end      
      end
    end

    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local xmult = 1
        for _, v in pairs(G.GAME.hands) do
          xmult = xmult + (v.level - 1) * card.ability.extra.xmult_mod
        end
        if xmult > 1 then
          return {
            colour = G.C.MULT,
            xmult = xmult,
            card = card
          }
        end
      end
    end
  end,
  megas = {"mega_gardevoir"}
}

local mega_gardevoir={
  name = "mega_gardevoir",
  poke_custom_prefix = "maelmc",
  pos = {x = 3, y = 3},
  soul_pos = { x = 4, y = 3 },
  config = {extra = {blackhole_amount = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.blackhole_amount}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Psychic",
  atlas = "Megas-Maelmc",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    --[[if context.setting_blind then
      return {
        message = poke_evolve(card, "j_maelmc_gardevoir"),
      }
    end]]
  end,
  add_to_deck = function(self, card, from_debuff)
    if not from_debuff then
      for _ = 1,card.ability.extra.blackhole_amount do
        local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_black_hole")
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
      end
    end
  end,
}

return {
  name = "Maelmc's Jokers 1",
  list = {
    ralts, kirlia, gardevoir, mega_gardevoir,
    kecleon,
    lunatone, solrock,
    odd_keystone, spiritomb, --spiritombl
    inkay, malamar,
    binacle, barbaracle,
    cufant, copperajah, mega_copperajah,
    glimmet, glimmora,
    gym_leader
  },
}