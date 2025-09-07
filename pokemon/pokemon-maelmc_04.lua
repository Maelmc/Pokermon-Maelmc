-- Spiritomb 442
local spiritomb={
  name = "spiritomb",
  --poke_custom_prefix = "maelmc",
  pos = {x = 12, y = 29},
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
  atlas = "AtlasJokersBasicNatdex",
  aux_poke = true,
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
  end,
  in_pool = function(self)
    return false
  end,
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

-- Gible 443
local gible={
  name = "gible",
  --poke_custom_prefix = "maelmc",
  pos = {x = 14, y = 29},
  config = {extra = {retriggers = 1, rightmost = 2, mult = 2, retriggered = 0}, evo_rqmt = 16},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"princessroxie"}}
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.rightmost, abbr.retriggers, abbr.mult, math.max(0, self.config.evo_rqmt - abbr.retriggered)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Base",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local to_retrigger = {}
      for i, v in ipairs(G.hand.cards) do
        if i > #G.hand.cards - card.ability.extra.rightmost then
          table.insert(to_retrigger,v)
        end
      end
      if table.contains(to_retrigger,context.other_card) then
        return {
          colour = G.C.MULT,
          mult = card.ability.extra.mult,
          card = card
        }
      end
    end

    if context.repetition and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local to_retrigger = {}
      for i, v in ipairs(G.hand.cards) do
        if i > #G.hand.cards - card.ability.extra.rightmost then
          table.insert(to_retrigger,v)
        end
      end
      if table.contains(to_retrigger,context.other_card) then
        if not context.blueprint then
          card.ability.extra.retriggered = card.ability.extra.retriggered + card.ability.extra.retriggers
        end
        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
        }
      end
    end

    return scaling_evo(self, card, context, "j_maelmc_gabite", card.ability.extra.retriggered, self.config.evo_rqmt)
  end,
}

-- Gabite 444
local gabite={
  name = "gabite",
  --poke_custom_prefix = "maelmc",
  pos = {x = 16, y = 29},
  config = {extra = {retriggers = 1, rightmost = 4, mult = 3, retriggered = 0}, evo_rqmt = 40},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"princessroxie"}}
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.rightmost, abbr.retriggers, abbr.mult, math.max(0, self.config.evo_rqmt - abbr.retriggered)}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local to_retrigger = {}
      for i, v in ipairs(G.hand.cards) do
        if i > #G.hand.cards - card.ability.extra.rightmost then
          table.insert(to_retrigger,v)
        end
      end
      if table.contains(to_retrigger,context.other_card) then
        return {
          colour = G.C.MULT,
          mult = card.ability.extra.mult,
          card = card
        }
      end
    end

    if context.repetition and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local to_retrigger = {}
      for i, v in ipairs(G.hand.cards) do
        if i > #G.hand.cards - card.ability.extra.rightmost then
          table.insert(to_retrigger,v)
        end
      end
      if table.contains(to_retrigger,context.other_card) then
        if not context.blueprint then
          card.ability.extra.retriggered = card.ability.extra.retriggered + card.ability.extra.retriggers
        end
        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
        }
      end
    end

    return scaling_evo(self, card, context, "j_maelmc_garchomp", card.ability.extra.retriggered, self.config.evo_rqmt)
  end,
}

-- Garchomp 445
local garchomp={
  name = "garchomp",
  --poke_custom_prefix = "maelmc",
  pos = {x = 18, y = 29},
  config = {extra = {retriggers = 1, mult = 4, h_size = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"princessroxie"}}
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.h_size, abbr.retriggers, abbr.mult}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.hand and context.scoring_name == "Pair" then
      return {
        colour = G.C.MULT,
        mult = card.ability.extra.mult,
        card = card
      }
    end

    if context.repetition and context.cardarea == G.hand and context.scoring_name == "Pair" then
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  megas = {"mega_garchomp"}
}

local mega_garchomp={
  name = "mega_garchomp",
  --poke_custom_prefix = "maelmc",
  pos = {x = 2, y = 7},
  soul_pos = {x = 3, y = 7},
  config = {extra = {retriggers = 1, Xmult_multi = 1.5, h_size = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.h_size, abbr.retriggers, abbr.Xmult_multi}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Dragon",
  atlas = "AtlasJokersBasicGen04",
  blueprint_compat = true,
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local pair_of = nil
      for _, v in pairs(context.scoring_hand) do
        if not SMODS.has_enhancement(v, "m_stone") then
          pair_of = v:get_id()
        end
      end
      
      if context.other_card:get_id() == pair_of then
        return {
          colour = G.C.MULT,
          xmult = card.ability.extra.Xmult_multi,
          card = card
        }
      end
    end

    if context.repetition and context.cardarea == G.hand and context.scoring_name == "Pair" then
      local pair_of = nil
      for _, v in pairs(context.scoring_hand) do
        if not SMODS.has_enhancement(v, "m_stone") then
          pair_of = v:get_id()
        end
      end

      if context.other_card:get_id() == pair_of then
        return {
          message = localize('k_again_ex'),
          repetitions = card.ability.extra.retriggers,
          card = card
        }
      end
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end
}

return {
  name = "Maelmc's Jokers Gen 4",
  list = {
    spiritomb, --spiritombl
    gible, gabite, garchomp, mega_garchomp,
  },
}