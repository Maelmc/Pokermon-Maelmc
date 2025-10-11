-- Woobat
local woobat = {
  name = "woobat",
  pos = {x = 2, y = 35},
  config = {extra = {num = 1, dem = 2, heart_stamped_count = 0}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'woobat')
    return {vars = {num, dem, self.config.evo_rqmt}}
  end,
  rarity = 2,
  cost = 6,
  stage = "Basic",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.before and context.cardarea == G.jokers and SMODS.pseudorandom_probability(card, 'woobat', card.ability.extra.num, card.ability.extra.dem, 'woobat') then
      local all_heart = true
      for _, v in pairs(context.scoring_hand) do
        if not v:is_suit("Hearts") then
          all_heart = false
          break
        end
      end
      if all_heart then
        local compatible = {}
        for _, v in pairs(G.hand.cards) do
          if v:is_suit("Hearts") then
            compatible[#compatible+1] = v
          end
        end
        local to_stamp = pseudorandom_element(compatible, 'maelmc_woobat')
        if to_stamp then
          to_stamp:set_seal("Red",true)
          return {
            message = localize("maelmc_hearthstamp_ex")
          }
        end
      end
    end

    return scaling_evo(self, card, context, "j_maelmc_swoobat", card.ability.extra.heart_stamped_count, self.config.evo_rqmt)
  end,
  update = function(self, card, dt)
    if not poke_is_in_collection(card) and G.playing_cards then
      local heart_stamped_count = 0
      for _, v in pairs(G.playing_cards) do
        if v:is_suit("Hearts") and v:get_seal() == "Red" then
          heart_stamped_count = heart_stamped_count + 1
        end
      end
      card.ability.extra.heart_stamped_count = heart_stamped_count
    end
  end
}

local swoobat = {
  name = "swoobat",
  pos = {x = 4, y = 35},
  config = {extra = {num = 1, dem = 2}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'swoobat')
    return {vars = {num, dem}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "One",
  ptype = "Psychic",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.before and context.cardarea == G.jokers then
      local all_heart = true
      for _, v in pairs(context.scoring_hand) do
        if not v:is_suit("Hearts") then
          all_heart = false
          break
        end
      end
      if all_heart then
        local stamp_set = false
        for _, v in pairs(G.hand.cards) do
          if v:is_suit("Hearts") and SMODS.pseudorandom_probability(card, 'swoobat', card.ability.extra.num, card.ability.extra.dem, 'swoobat') then
            v:set_seal("Red",true)
            stamp_set = true
          end
        end
        if stamp_set then
          return {
            message = localize("maelmc_hearthstamp_ex")
          }
        end
      end
    end
  end,
}

local bouffalant = {
  name = "bouffalant",
  pos = PokemonSprites["bouffalant"].base.pos,
  config = {extra = {money = 10, boss_trigger = 0, blind_buff = 1.5, boss_blind = nil}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.blind_buff, card.ability.extra.money, card.ability.extra.boss_trigger}}
  end,
  rarity = 2,
  cost = 7,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "AtlasJokersBasicNatdex",
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.setting_blind and context.blind and context.blind.boss and not context.blueprint then
      card.ability.extra.boss_blind = context.blind.name
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_buff
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
      
      local boss_name = card.ability.extra.boss_blind
      if (boss_name == "The Wall" or boss_name == "The Water" or boss_name == "The Manacle" or boss_name == "The Needle" or boss_name == "Amber Acorn" or boss_name == "Violet Vessel") and not G.GAME.blind.disabled then
        card.ability.extra.boss_trigger = card.ability.extra.boss_trigger + 1
      end

      return {
        message = localize('maelmc_reckless_ex')
      }
    end
      
    if card.ability.extra.boss_blind then
      local boss_name = card.ability.extra.boss_blind
      local boss_trigg = false

      -- window, head, club, goad, plant, pillar, flint, eye, mouth, psychic, arm, ox, leaf
      if context.debuffed_hand or context.joker_main then
        if G.GAME.blind.triggered then
          boss_trigg = true
        end

      elseif context.first_hand_drawn and boss_name == "The House" then
        boss_trigg = true
      
      elseif (context.press_play or context.pre_discard) and boss_name == "The Serpent" and #G.hand.highlighted > 3 then
        card.ability.extra.boss_blind = "okserpent"
      
      elseif context.press_play then
        local jokdebuff = false
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].debuff then
            jokdebuff = true
            break
          end
        end
        local forcedselection = false
        for i = 1, #G.hand.highlighted do
          if G.hand.highlighted[i].ability.bouffalant_forced_selection then
            G.hand.highlighted[i].ability.bouffalant_forced_selection = nil
            forcedselection = true
          end
        end
        if (boss_name == "The Hook" and (#G.hand.cards - #G.hand.highlighted) > 0) or
        boss_name == "The Tooth" or
        ((boss_name == "Crimson Heart" or boss_name == "bl_poke_cgoose") and jokdebuff) or
        (boss_name == "Cerulean Bell" and forcedselection) then
          boss_trigg = true
        end
      
      elseif context.hand_drawn then
        local facedown = false
        for _, v in pairs(context.hand_drawn) do
          if v.facing == 'back' then
              facedown = true
          end
        end
        if boss_name == "okserpent" or
        ((boss_name == "The Wheel" or boss_name == "The Mark" or boss_name == "The Fish") and facedown) then
          boss_trigg = true
          -- first set the flag when hand is played or discarded, then
          -- only apply boss_trigg when the hand is drawn
          if boss_name == "okserpent" then card.ability.extra.boss_blind = "The Serpent" end
        end
      end

      if boss_trigg and not G.GAME.blind.disabled then
        card.ability.extra.boss_trigger = card.ability.extra.boss_trigger + 1
        return {
          message = localize('maelmc_reckless_ex')
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.boss_blind = (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.name) or nil
  end,
  calc_dollar_bonus = function(self, card)
    local trigger = card.ability.extra.boss_trigger
    card.ability.extra.boss_trigger = 0
    card.ability.extra.boss_blind = nil
    return G.GAME.blind.boss and ease_poke_dollars(card, "bouffalant", (trigger + 1) * card.ability.extra.money, true) or nil
  end
}

return {
  name = "Maelmc's Jokers Gen 5",
  list = {
    woobat, swoobat,
    bouffalant,
  },
}
