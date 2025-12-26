local sepia={
  key = "sepia",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("A98162"),
  pos = { x = 0, y = 0 },
  atlas = "maelmc_boss_blinds",
  artist = "Deleca7755",
  discovered = false,
  debuff = {},
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.play_sepia_song = true
  end,
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.individual and context.cardarea ==  G.play and context.scoring_hand and not context.end_of_round then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.GAME.dollar_buffer = 0
            return true
          end
        }))
        return {
          x_mult = 0.9,
          dollars = -1
        }
      end
    end
  end,
  defeat = function(self)
    --not in an event otherwise the music resets in an awkward way
    play_sound('timpani')
    SMODS.add_card({ set = 'Joker', key = "j_maelmc_meloetta" })
    G.GAME.sepia_quest_complete = true
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      func = function()
        G.GAME.play_sepia_song = false
        return true
      end
    }))
  end,
  disable = function(self)
    self.config.disabled = true
  end,
  in_pool = function(self)
    return false
  end,
}

local bloodmoon_beast={
  key = "bloodmoon_beast",
  dollars = 8,
  mult = 2,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("D97986"),
  pos = { x = 0, y = 1 },
  atlas = "maelmc_boss_blinds",
  artist = "Soulja",
  discovered = false,
  debuff = { suit = "Hearts" },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.bloodmoon_beast_quest_completed = "in progress"
    for i = 1, #G.consumeables.cards do
      G.consumeables.cards[i]:set_debuff(true)
    end
  end,
  calculate = function(self, blind, context)
    for i = 1, #G.consumeables.cards do
      if not G.consumeables.cards[i].debuff then
        G.consumeables.cards[i]:set_debuff(true)
      end
    end
  end,
  defeat = function(self)
    G.GAME.bloodmoon_beast_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_bloodmoon_ursaluna" })
        return true
      end
    }))
    for i = 1, #G.consumeables.cards do
      G.consumeables.cards[i]:set_debuff(false)
    end
  end,
  disable = function(self)
    self.config.disabled = true
    for i = 1, #G.consumeables.cards do
      G.consumeables.cards[i]:set_debuff(false)
    end
  end,
  in_pool = function(self)
    return false
  end,
}

return {
  name = "Blinds",
  list = {
    sepia,
    bloodmoon_beast,
  }
}