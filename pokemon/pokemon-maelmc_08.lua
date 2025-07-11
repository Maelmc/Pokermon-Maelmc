-- Cursola
local cursola={
  name = "cursola",
  poke_custom_prefix = "maelmc",
  pos = {x = 1, y = 4},
  config = {extra = {Xmult_multi = 2, volatile = 'left', perish_rounds = 3}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_multi, card.ability.extra.perish_rounds}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Psychic",
  atlas = "Pokedex8",
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
  atlas = "Pokedex8",
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
          message = localize("maelmc_steel_ex"),
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
  config = {extra = {hazard_ratio = 10, reset_steel = 3, mult_mod = 3, all_hazard = {}, hazard_to_steel = {}}},
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
    return {vars = {to_add, abbr.hazard_ratio, abbr.reset_steel, abbr.mult_mod, abbr.mult_mod * steel_count}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Metal",
  atlas = "Pokedex8",
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
          message = localize("maelmc_steel_ex"),
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
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.mult_mod * steel_count}},
          colour = G.C.MULT,
          mult = card.ability.extra.mult_mod * steel_count
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
  config = {extra = {hazard_ratio = 10, to_steel = 5, reset_steel = 5, Xmult_mod = 0.1, mult_mod = 6, all_hazard = {}, hazard_to_steel = {}}},
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
    return {vars = {to_add, abbr.hazard_ratio, abbr.reset_steel, abbr.Xmult_mod, 1 + abbr.Xmult_mod * steel_count, abbr.mult_mod, abbr.mult_mod * steel_count }}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Metal",
  atlas = "Gmax",
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
          message = localize("maelmc_gmax_steelsurge_ex"),
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
          mult = card.ability.extra.mult_mod * steel_count,
          Xmult = 1 + card.ability.extra.Xmult_mod * steel_count
        }
      end
    end
  end,
}

return {
  name = "Maelmc's Jokers Gen 8",
  list = {
    cursola,
    cufant, copperajah, mega_copperajah,
  },
}