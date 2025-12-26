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
    play_sound('timpani')
    SMODS.add_card({ set = 'Joker', key = "j_maelmc_meloetta" })
    G.GAME.sepia_quest_complete = true
    G.E_MANAGER:add_event(Event({
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

return {
  name = "Blinds",
  list = {
    sepia,
  }
}