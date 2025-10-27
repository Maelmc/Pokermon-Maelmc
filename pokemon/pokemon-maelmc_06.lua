-- Inkay 686
local inkay={
  name = "inkay",
  pos = {x = 20, y = 45},
  config = {extra = {mult = 8, num = 1, dem = 2, flipped_triggered = 0}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'inkay')
    return {vars = {num, dem, abbr.mult, math.max(0, self.config.evo_rqmt - abbr.flipped_triggered)}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Dark",
  atlas = "AtlasJokersBasicNatdex",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- 1 in 2 is flipped
    if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, 'inkay', card.ability.extra.num, card.ability.extra.dem, 'inkay') then
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
        if not context.blueprint then
          G.E_MANAGER:add_event(Event({
            func = function() 
              card.ability.extra.flipped_triggered = card.ability.extra.flipped_triggered + 1
          return true end }))
        end
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
  remove_from_deck = function(self, card, from_debuff)
    if #find_joker("inkay") + #find_joker("malamar") == 0 then
      if G.hand and G.hand.cards then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
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

-- Credits to emmadenslemma for the idea and the code
SMODS.DrawStep({
  key = 'inkay_rotate',
  order = -1001,
  layers = { shadow = true, both = true },
  func = function(self)
    if not G.SETTINGS.paused and self.config.center.key == 'j_maelmc_inkay' then
      -- Handle reloading Inkay
      if self.flipped_registered == nil then self.flipped_registered = self.ability.extra.flipped_triggered end
      -- Only rotate once when the card jiggles
      -- -- Known issue: this also rotates once if you mouse over it while it's scoring
      -- -- this should be done in Inkay's scoring code instead of here
      if self.juice and not self.flip_juice_spent then
        self.flipped_registered = math.min(self.flipped_registered + 1, self.ability.extra.flipped_triggered)
        self.flip_juice_spent = true
      end
      if not self.juice and self.flip_juice_spent then
        self.flip_juice_spent = false
      end
      -- Actual rotation part
      local add_rot_amt = math.pi * math.min(self.flipped_registered / self.config.center.config.evo_rqmt, 1)
      self.VT.r = self.VT.r + add_rot_amt
      for _, v in pairs(self.children) do
        v.VT.r = self.VT.r
      end
    end
  end
})

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
  remove_from_deck = function(self, card, from_debuff)
    if #find_joker("inkay") + #find_joker("malamar") == 0 then
      if G.hand and G.hand.cards then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
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