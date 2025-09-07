-- Inkay 686
local inkay={
  name = "inkay",
  pos = {x = 20, y = 45},
  config = {extra = {mult = 8, odds = 2, flipped_triggered = 0}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), abbr.odds, abbr.mult, math.max(0, self.config.evo_rqmt - abbr.flipped_triggered)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- 1 in 2 is flipped
    if context.stay_flipped and context.to_area == G.hand and pseudorandom('inkay') < G.GAME.probabilities.normal / card.ability.extra.odds then
      return {
          stay_flipped = true
      }
    end

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
}

-- Malamar 687
local malamar={
  name = "malamar",
  pos = {x = 22, y = 45},
  config = {extra = {Xmult_multi = 1.5}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.Xmult_multi}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- all are flipped
    if context.stay_flipped and context.to_area == G.hand then
      return {
          stay_flipped = true
      }
    end

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
          Xmult = card.ability.extra.Xmult_multi ,
          card = card
        }
      end
    end

    -- remove flag and flip back cards
    if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
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
}

-- Binacle 688
local binacle={
  name = "binacle",
  pos = {x = 24, y = 45},
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
  atlas = "AtlasJokersBasicNatdex",
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
  pos = {x = 26, y = 45},
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
  atlas = "AtlasJokersBasicNatdex",
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

return {
  name = "Maelmc's Jokers Gen 6",
  list = {
    inkay, malamar,
    binacle, barbaracle,
  },
}