-- Woobat
local woobat = {
  name = "woobat",
  gen = 5,
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
  gen = 5,
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
  gen = 5,
  pos = PokemonSprites["bouffalant"].base.pos,
  config = {extra = {money = 8, boss_trigger = 0, blind_buff = 1.5, boss_blind = nil}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'bouffalant_compat'}
    if (SMODS.Mods["Multiplayer"] or {}).can_load and MP.LOBBY and MP.LOBBY.code and MP.LOBBY.enemy_id then
      info_queue[#info_queue+1] = {set = 'Other', key = 'bouffalant_mp'}
    end
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
  update = function(self, card, dt)
    if (SMODS.Mods["Multiplayer"] or {}).can_load and MP.LOBBY and MP.LOBBY.code and MP.LOBBY.enemy_id and MP.is_pvp_boss() then
      if card.ability.extra.mp_hands == nil then
        card.ability.extra.mp_hands = MP.GAME.enemies[MP.LOBBY.enemy_id].hands
      elseif card.ability.extra.mp_hands ~= MP.GAME.enemies[MP.LOBBY.enemy_id].hands then
        card.ability.extra.mp_hands = MP.GAME.enemies[MP.LOBBY.enemy_id].hands
        card.ability.extra.boss_trigger = card.ability.extra.boss_trigger + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("maelmc_reckless_ex"),})
      end
    end
  end,
  calculate = function(self, card, context)

    if context.setting_blind and context.blind and context.blind.boss and not context.blueprint then
      card.ability.extra.boss_blind = context.blind.name
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_buff
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
      
      -- Setting blind
      local boss_name = card.ability.extra.boss_blind
      if (boss_name == "The Wall" or boss_name == "The Water" or boss_name == "The Manacle" or
          boss_name == "The Needle" or boss_name == "Amber Acorn" or boss_name == "Violet Vessel" or
          boss_name == "bl_poke_mirror" or boss_name == "bl_poke_white_executive" or boss_name == "bl_sonfive_darkrai_boss") and not G.GAME.blind.disabled then
        card.ability.extra.boss_trigger = card.ability.extra.boss_trigger + 1
      end

      return {
        message = localize('maelmc_reckless_ex')
      }
    end
      
    if card.ability.extra.boss_blind and not G.GAME.blind.disabled then
      local boss_name = card.ability.extra.boss_blind
      local boss_trigg = maelmc_blind_trigger(card,context,boss_name)

      if boss_trigg then
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

-- Meloetta
local meloetta = {
  name = "meloetta",
  gen = 5,
  atlas = "AtlasJokersBasicGen05",
  pos = { x = 4, y = 6 },
  soul_pos = { x = 5, y = 6 },
  stage = "Legendary",
  ptype = "Psychic",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  rarity = 4,
  cost = 20,
  config = { extra = {money_mod = 3} },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = {card.ability.extra.money_mod} }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_mod
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.dollar_buffer = 0
                return true
            end
        }))
        local earned = ease_poke_dollars(card, "meloetta", card.ability.extra.money_mod, true)
        return {
          mult = card.ability.extra.mult,
          dollars = earned,
          card = card
        }
      end
    end

    if context.post_discard and not context.recursive and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function()
          poke_evolve(card, "j_maelmc_meloetta_pirouette")
          return true
        end
      }))
    end
  end
}

local meloetta_pirouette = {
  name = "meloetta_pirouette",
  gen = 5,
  atlas = "AtlasJokersBasicGen05",
  pos = { x = 6, y = 6 },
  soul_pos = { x = 7, y = 6 },
  stage = "Legendary",
  ptype = "Fighting",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  rarity = 4,
  cost = 20,
  aux_poke = true,
  custom_pool_func = true,
  no_collection = true,
  config = { extra = {Xmult_multi = 1.5} },
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return { vars = {card.ability.extra.Xmult_multi} }
  end,
  calculate = function(self, card, context)

    if context.individual and context.cardarea == G.play then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        return {
          Xmult = card.ability.extra.Xmult_multi,
          card = context.blueprint_card or card
        }
      end
    end

    if context.post_discard and not context.recursive and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function()
          poke_evolve(card, "j_maelmc_meloetta")
          return true
        end
      }))
    end
  end,
  in_pool = function(self)
    return false
  end,
}

return {
  name = "Maelmc's Jokers Gen 5",
  list = {
    woobat, swoobat,
    bouffalant,
    meloetta, meloetta_pirouette,
  },
}
