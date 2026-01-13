local rock_giant = {
  key = "rock_giant",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("DF771F"),
  pos = { x = 0, y = 6 },
  atlas = "maelmc_boss_blinds",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting regirock"
    G.GAME.maelmc_quest_set = false
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_regirock" })
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

local ice_giant = {
  key = "ice_giant",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("879FFF"),
  pos = { x = 0, y = 7 },
  atlas = "maelmc_boss_blinds",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting regice"
    G.GAME.maelmc_quest_set = false
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_regice" })
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

local steel_giant = {
  key = "steel_giant",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("7F8F97"),
  pos = { x = 0, y = 8 },
  atlas = "maelmc_boss_blinds",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting registeel"
    G.GAME.maelmc_quest_set = false
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_registeel" })
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

local ramping_giant = {
  key = "ramping_giant",
  dollars = 10,
  mult = 4,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("D7E7FF"),
  pos = { x = 0, y = 0 },
  atlas = "maelmc_boss_blinds_big",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting regigigas"
    G.GAME.maelmc_quest_set = false
    G.GAME.maelmc_regigigas_mult = 4
    G.GAME.maelmc_regigigas_initial = true
  end,
  press_play = function(self)
    G.GAME.blind.triggered = true
    G.GAME.blind.prepped = true
  end,
  drawn_to_hand = function(self)
    if G.GAME.maelmc_regigigas_initial then
      G.GAME.maelmc_regigigas_initial = nil
    elseif G.GAME.blind.prepped then
      G.GAME.blind.chips = G.GAME.blind.chips / G.GAME.maelmc_regigigas_mult * (G.GAME.maelmc_regigigas_mult+1)
      G.GAME.maelmc_regigigas_mult = G.GAME.maelmc_regigigas_mult + 1
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
      G.GAME.blind:wiggle()
    end
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.GAME.maelmc_regigigas_mult = nil
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_agar_regigigas" })
        return true
      end
    }))
  end,
  disable = function(self)
    self.config.disabled = true
    G.GAME.blind.chips = G.GAME.blind.chips / (G.GAME.maelmc_regigigas_mult or 4) * 2
    G.GAME.maelmc_regigigas_mult = nil
  end,
  in_pool = function(self)
    return false
  end,
}

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

local electric_giant = {
  key = "electric_giant",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("E6EE31"),
  pos = { x = 0, y = 9 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting regieleki"
    G.GAME.maelmc_quest_set = false
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_regieleki" })
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

local draconic_giant = {
  key = "draconic_giant",
  dollars = 10,
  mult = 3,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("D53983"),
  pos = { x = 0, y = 10 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.giants_quest_completed = "fighting regidrago"
    G.GAME.maelmc_quest_set = false
  end,
  defeat = function(self)
    G.GAME.giants_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_regidrago" })
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
    G.GAME.maelmc_quest_set = false
  end,
  calculate = function(self, blind, context)
    if not self.config.disabled then
      for i = 1, #G.consumeables.cards do
        if not G.consumeables.cards[i].debuff then
          G.consumeables.cards[i]:set_debuff(true)
        end
      end
    end
  end,
  defeat = function(self)
    G.GAME.bloodmoon_beast_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1, #G.consumeables.cards do
          G.consumeables.cards[i]:set_debuff(false)
        end
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_bloodmoon_ursaluna" })
        return true
      end
    }))
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

local hearthflame_mask={
  key = "hearthflame_mask",
  dollars = 0,
  mult = 1,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("D73F00"),
  pos = { x = 0, y = 2 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.kitikami_ogre_quest_completed = "fighting hearthflame"
    G.GAME.maelmc_quest_set = false
  end,
  calculate = function(self, blind, context)
    local beat = false
    if (SMODS.Mods["Talisman"] or {}).can_load and to_big(G.GAME.chips) >= G.GAME.blind.chips then
      beat = true
    elseif not (SMODS.Mods["Talisman"] or {}).can_load and G.GAME.chips >= G.GAME.blind.chips then
      beat = true
    end
    if beat then
      G.GAME.chips = 0
      if not blind.prep_next then
        blind.prep_next = true
        G.E_MANAGER:add_event(Event({
          func = function()
            maelmc_set_next_boss("bl_maelmc_wellspring_mask",false,false,true,true)
            blind.prep_next = false
            G.P_BLINDS["bl_maelmc_hearthflame_mask"].unlocked = true
            G.P_BLINDS["bl_maelmc_hearthflame_mask"].discovered = true
            return true
          end
        }))
      end
    end
  end,
  defeat = function(self)
  end,
  disable = function(self)
    self.config.disabled = true
  end,
  in_pool = function(self)
    return false
  end,
}

local wellspring_mask={
  key = "wellspring_mask",
  dollars = 0,
  mult = 1,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("006DC6"),
  pos = { x = 0, y = 3 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.kitikami_ogre_quest_completed = "fighting wellspring"
    ease_hands_played(1)
  end,
  calculate = function(self, blind, context)
    local beat = false
    if (SMODS.Mods["Talisman"] or {}).can_load and to_big(G.GAME.chips) >= G.GAME.blind.chips then
      beat = true
    elseif not (SMODS.Mods["Talisman"] or {}).can_load and G.GAME.chips >= G.GAME.blind.chips then
      beat = true
    end
    if beat then
      G.GAME.chips = 0
      if not blind.prep_next then
        blind.prep_next = true
        G.E_MANAGER:add_event(Event({
          func = function()
            maelmc_set_next_boss("bl_maelmc_cornerstone_mask",false,false,true,true)
            blind.prep_next = false
            G.P_BLINDS["bl_maelmc_wellspring_mask"].unlocked = true
            G.P_BLINDS["bl_maelmc_wellspring_mask"].discovered = true
            return true
          end
        }))
      end
    end
  end,
  defeat = function(self)
  end,
  disable = function(self)
    self.config.disabled = true
  end,
  in_pool = function(self)
    return false
  end,
}

local cornerstone_mask={
  key = "cornerstone_mask",
  dollars = 0,
  mult = 1,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("757A7A"),
  pos = { x = 0, y = 4 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.kitikami_ogre_quest_completed = "fighting cornerstone"
    ease_hands_played(1)
  end,
  calculate = function(self, blind, context)
    local beat = false
    if (SMODS.Mods["Talisman"] or {}).can_load and to_big(G.GAME.chips) >= G.GAME.blind.chips then
      beat = true
    elseif not (SMODS.Mods["Talisman"] or {}).can_load and G.GAME.chips >= G.GAME.blind.chips then
      beat = true
    end
    if beat then
      G.GAME.chips = 0
      if not blind.prep_next then
        blind.prep_next = true
        G.E_MANAGER:add_event(Event({
          func = function()
            maelmc_set_next_boss("bl_maelmc_teal_mask",false,false,true,true)
            blind.prep_next = false
            G.P_BLINDS["bl_maelmc_cornerstone_mask"].unlocked = true
            G.P_BLINDS["bl_maelmc_cornerstone_mask"].discovered = true
            return true
          end
        }))
      end
    end
  end,
  defeat = function(self)
  end,
  disable = function(self)
    self.config.disabled = true
  end,
  in_pool = function(self)
    return false
  end,
}

local teal_mask={
  key = "teal_mask",
  dollars = 10,
  mult = 1,
  boss = { showdown = false, min = 1, max = 80 },
  boss_colour = HEX("5FB727"),
  pos = { x = 0, y = 5 },
  atlas = "maelmc_boss_blinds",
  artist = "baronessfaron",
  discovered = false,
  debuff = { },
  config = {disabled = false},
  set_blind = function(self)
    G.GAME.kitikami_ogre_quest_completed = "fighting teal"
    ease_hands_played(1)
  end,
  calculate = function(self, blind, context)
  end,
  defeat = function(self)
    G.GAME.kitikami_ogre_quest_completed = true
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('timpani')
        SMODS.add_card({ set = 'Joker', key = "j_maelmc_ogerpon" })
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

local list = {
  rock_giant,
  ice_giant,
  steel_giant,
  sepia,
  electric_giant,
  draconic_giant,
  bloodmoon_beast,
  hearthflame_mask, wellspring_mask, cornerstone_mask, teal_mask
}

if next(SMODS.find_mod('Agarmons')) then
  table.insert(list,4,ramping_giant)
end

return {
  name = "Blinds",
  list = list
}