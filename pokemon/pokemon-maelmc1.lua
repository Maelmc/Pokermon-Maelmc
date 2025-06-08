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
  megas = {"gmax_copperajah"}
}

-- Gmax Copperajah
local gmax_copperajah = {
  name = "gmax_copperajah",
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
  pos = {x = 4, y = 0},
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
  atlas = "Others-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if using The Soul, evolve
    if context.using_consumeable and context.consumeable and context.consumeable.ability.name == card.ability.extra.evolve_using then
      
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
    end

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

        elseif context.card.config.center.rarity == "poke_safari" or context.card.config.center.rarity == 3 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 5

        elseif context.card.config.center.rarity == 4 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 10
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

local spiritombl={
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
}

-- Gym Leader
local gym_leader={
  name = "gym_leader",
  poke_custom_prefix = "maelmc",
  pos = {x = 2, y = 2},
  config = {extra = {boss = false}},
  loc_vars = function(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'gym_leader_tag_pool', vars = {'Uncommon', 'Rare', 'Handy', 'Garbage', 'Investment'}}
    return {vars = {}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Other",
  atlas = "Others-Maelmc",
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
              local card = create_card('Energy', G.consumeables, nil, nil, nil, nil, nil, 'pory')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
            return true
        end)}))
      end

      card.ability.extra.boss = false
      return true
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

return {name = "Maelmc's Jokers 1", 
        list = {glimmet, glimmora, cufant, copperajah, gmax_copperajah, odd_keystone, spiritomb, spiritombl, gym_leader, kecleon},
}