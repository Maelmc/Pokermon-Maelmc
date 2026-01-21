--[[local function giants_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = (G.GAME.giants_start and 5) or 4, y = 0}}
  quest.display_text = {
    localize("giants_quest_name"),
    localize("giants_chart"),
    [[localize("giants_one"),
    localize("giants_desert_ruins"),
    localize("giants_island_cave"),
    localize("giants_ancient_tomb"),
    localize("giants_split_decision_ruins"),
  }
  return quest
end]]
--table.insert(to_run_quests,giants_quest)

local function display_text()
  if (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code then
    return {localize("maelmc_quest_mp_disabled")}
  end
  local display_text = {
    localize("giants_chart")
  }
  return display_text
end

local function reward_text()
  return {localize("giants_reward")}
end

local function quest_pos()
  return {x = (G.GAME.giants_start and 5) or 4, y = 0}
end

local function reward_pos()
  return {x = 0, y = pseudorandom("quest_regi_blind",6,10)}
end

local function designer()
  return {name = "Maelmc", colour = G.C.MAELMC.ORANGE}
end

maelmc_add_quest{
  name = "giants_quest_name",
  atlas = "maelmc_quests",
  pos = quest_pos,
  display_text = display_text,
  dex = 377,
  reward_text = reward_text,
  reward_atlas = "maelmc_boss_blinds",
  reward_pos = reward_pos,
  set = "Blind",
  designer = designer,
}

local calculate_ref = SMODS.current_mod.calculate
SMODS.current_mod.calculate = function(self, context)
  if calculate_ref then
    calculate_ref(self, context)
  end
  if not ((next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code) then
    if context.card_added and context.card.ability.set == "Joker" then
      context.card.ability.regice_id = G.GAME.regice_id or 0
      G.GAME.regice_id = (G.GAME.regice_id or 0) + 1
    end
    if not G.GAME.giants_start then
      if (G.jokers.cards[1] and get_type(G.jokers.cards[1]) == "Earth") and (G.jokers.cards[#G.jokers.cards] and get_type(G.jokers.cards[#G.jokers.cards]) == "Water") then
        G.GAME.giants_start = true
        play_sound('maelmc_door', 1, 1)
        attention_text({scale = 0.6, text = localize("giants_shake"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -3.5 }, major = G.play})
      end
    end

    if G.GAME.giants_start and not G.GAME.giants_quest_completed then
      -- Regirock
      if context.remove_playing_cards then
        G.GAME.giants_destroyed = (G.GAME.giants_destroyed or 0 )
        for _, _ in ipairs(context.removed) do
          G.GAME.giants_destroyed = G.GAME.giants_destroyed + 1
        end
      end
      if context.using_consumeable and context.consumeable and context.consumeable.config.center.key == "c_strength" then
        G.GAME.giants_strength = (G.GAME.giants_strength or 0) + #G.hand.highlighted
      end
      if context.remove_playing_cards or (context.using_consumeable and context.consumeable and context.consumeable.config.center.key == "c_strength") then
        if (G.GAME.giants_destroyed or 0) >= 15 and (G.GAME.giants_strength or 0) >= 15 then
          G.GAME.giants_quest_completed = "regirock"
          G.E_MANAGER:add_event(Event({
            trigger = "condition",
            blocking = false,
            func = function()
              if G.GAME.maelmc_quest_set then return false end
              maelmc_set_next_boss("bl_maelmc_rock_giant")
              play_sound('maelmc_door', 1, 1)
              attention_text({scale = 0.8, text = localize("giants_desert_ruins_open"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
              G.GAME.maelmc_quest_set = true
              return true
            end
          }))
        end
      end

      -- Regice
      if context.setting_blind or context.end_of_round or context.ending_shop then
        local jokers = G.jokers.cards
        local prev_jokers = G.GAME.giants_jokers or {}
        if #jokers ~= #prev_jokers then
          G.GAME.giants_jokers = {}
          G.GAME.giants_initial_round = G.GAME.round
          for k, v in ipairs(jokers) do
            G.GAME.giants_jokers[k] = v.config.center.key
          end
        else
          for k, v in ipairs(jokers) do
            if not (v.config.center.key == prev_jokers[k]) then
              G.GAME.giants_jokers = {}
              G.GAME.giants_initial_round = G.GAME.round
              for l, w in ipairs(jokers) do
                G.GAME.giants_jokers[l] = w.config.center.key
              end
            end
          end
        end
        if G.GAME.round - G.GAME.giants_initial_round >= 10 then
          local blind = "bl_maelmc_ice_giant"
          local text = "giants_island_cave_open"
          G.GAME.giants_quest_completed = "regice"
          if (SMODS.Mods["Agarmons"] or {}).can_load and next(SMODS.find_card("c_poke_icestone")) then
            blind = "bl_maelmc_ramping_giant"
            text = "giants_island_cave_open_secret"
            G.GAME.giants_quest_completed = "regigigas"
          end
          G.E_MANAGER:add_event(Event({
            trigger = "condition",
            blocking = false,
            func = function()
              if G.GAME.maelmc_quest_set then return false end
              maelmc_set_next_boss(blind)
              play_sound('maelmc_door', 1, 1)
              attention_text({scale = 0.8, text = localize(text), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
              G.GAME.maelmc_quest_set = true
              return true
            end
          }))
        end
      end

      -- Registeel
      if context.setting_ability and not G.GAME.giants_quest_completed then
        local editions = 0
        if G.playing_cards then
          for _, v in pairs(G.playing_cards) do
            if v.edition then editions = editions + 1 end
          end
        end
        if editions/#G.playing_cards >= 0.4  then
          G.GAME.giants_quest_completed = "registeel"
          G.E_MANAGER:add_event(Event({
            trigger = "condition",
            blocking = false,
            func = function()
              if G.GAME.maelmc_quest_set then return false end
              maelmc_set_next_boss("bl_maelmc_steel_giant")
              play_sound('maelmc_door', 1, 1)
              attention_text({scale = 0.8, text = localize("giants_ancient_tomb_open"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
              G.GAME.maelmc_quest_set = true
              return true
            end
          }))
        end
      end

      -- Regidrago & Regieleki
      if context.setting_ability and not G.GAME.giants_quest_completed then
        local mult = 0
        local gold = 0
        if G.playing_cards then
          for _, v in pairs(G.playing_cards) do
            if v.config.center.key == "m_mult" then mult = mult + 1 end
            if v.config.center.key == "m_gold" then gold = gold + 1 end
          end
        end
        if gold == 0 and mult/#G.playing_cards >= 0.4  then
          G.GAME.giants_quest_completed = "regidrago"
          G.E_MANAGER:add_event(Event({
            trigger = "condition",
            blocking = false,
            func = function()
              if G.GAME.maelmc_quest_set then return false end
              maelmc_set_next_boss("bl_maelmc_draconic_giant")
              play_sound('maelmc_door', 1, 1)
              attention_text({scale = 0.8, text = localize("giants_split_decision_ruins_open_dragon"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
              G.GAME.maelmc_quest_set = true
              return true
            end
          }))
        elseif mult == 0 and gold/#G.playing_cards >= 0.4  then
          G.GAME.giants_quest_completed = "regieleki"
          G.E_MANAGER:add_event(Event({
            trigger = "condition",
            blocking = false,
            func = function()
              if G.GAME.maelmc_quest_set then return false end
              maelmc_set_next_boss("bl_maelmc_electric_giant")
              play_sound('maelmc_door', 1, 1)
              attention_text({scale = 0.8, text = localize("giants_split_decision_ruins_open_electric"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
              G.GAME.maelmc_quest_set = true
              return true
            end
          }))
        end
      end
    end
  end
end