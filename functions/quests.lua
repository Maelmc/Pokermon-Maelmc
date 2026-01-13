to_run_quests = {}

function G.FUNCS.maelmc_quest(args)
  local quest_keys = {}
  if (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code then
    table.insert(quest_keys,{atlas = "maelmc_quests", pos = {x = 0, y = 0}, display_text = localize("maelmc_quest_mp_disabled")})
  else
    for _, v in pairs(to_run_quests) do
      table.insert(quest_keys,v())
    end
  end
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_UIBox_generic_options {
      back_func = not (args and args.no_back) and 'options' or nil,
      contents = poke_create_UIBox_your_collection {
        keys = quest_keys,
        create_card_func = PokeDisplayCard,
        cols = 4,
        dynamic_sizing = true
      }
    },
  }
end

local function giants_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = (G.GAME.giants_start and 5) or 4, y = 0}}
  quest.display_text = {
    localize("giants_quest_name"),
    localize("giants_chart"),
    --[[localize("giants_one"),
    localize("giants_desert_ruins"),
    localize("giants_island_cave"),
    localize("giants_ancient_tomb"),
    localize("giants_split_decision_ruins"),]]
  }
  return quest
end
table.insert(to_run_quests,giants_quest)

local calculate_ref = SMODS.current_mod.calculate
SMODS.current_mod.calculate = function(self, context)
  if calculate_ref then
    calculate_ref(self, context)
  end
  if not ((next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code) then
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

local function sepia_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = 1, y = 0}}
  local in_work = (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_sepia") or G.GAME.sepia_quest_complete or false
  local has_perrin = next(SMODS.find_card("j_maelmc_photographer")) or in_work
  local blind = has_perrin and (G.GAME and G.GAME.blind and G.GAME.blind.name == "The Mouth") or in_work
  quest.display_text = {
    localize("sepia_quest_name"),
    localize(has_perrin and "sepia_photo" or "sepia_no_photo"),
    localize(has_perrin and (blind and "sepia_blind" or "sepia_no_blind") or "maelmc_qm"),
    localize(blind and "sepia_spin" or "maelmc_qm")
  }
  return quest
end
table.insert(to_run_quests,sepia_quest)

local function bloodmoon_beast_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = 2, y = 0}}
  local in_work = G.GAME.bloodmoon_beast_quest_completed and G.GAME.bloodmoon_beast_quest_completed or false
  local has_perrin = next(SMODS.find_card("j_maelmc_photographer")) or in_work
  quest.display_text = {
    localize("bloodmoon_beast_quest_name"),
    localize(has_perrin and "bloodmoon_beast_photo" or "bloodmoon_beast_no_photo"),
    localize(has_perrin and "bloodmoon_beast_species" or "maelmc_qm"),
    localize(in_work == true and "bloodmoon_beast_done" or in_work == "in progress" and "bloodmoon_beast_next" or "maelmc_qm")
  }
  return quest
end
table.insert(to_run_quests,bloodmoon_beast_quest)

local function kitikami_ogre_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = 3, y = 0}}
  local bonus = 0
  local mult = 0
  local stone = 0
  local lucky = 0
  if G.playing_cards then
    for _, v in pairs(G.playing_cards) do
      if v.config.center.key == "m_bonus" then bonus = bonus + 1 end
      if v.config.center.key == "m_mult" then mult = mult + 1 end
      if v.config.center.key == "m_stone" then stone = stone + 1 end
      if v.config.center.key == "m_lucky" then lucky = lucky + 1 end
    end
    bonus = bonus/#G.playing_cards
    mult = mult/#G.playing_cards
    stone = stone/#G.playing_cards
    lucky = lucky/#G.playing_cards
  end
  local in_work = G.GAME.kitikami_ogre_quest_completed and G.GAME.kitikami_ogre_quest_completed or false
  quest.display_text = {
    localize("kitikami_ogre_quest_name"),
    localize("kitikami_ogre_enhancements"),
    localize((bonus >= 0.2 or in_work) and "kitikami_ogre_bonus" or "maelmc_qm"),
    localize((mult >= 0.2 or in_work) and "kitikami_ogre_mult" or "maelmc_qm"),
    localize((stone >= 0.2 or in_work) and "kitikami_ogre_stone" or "maelmc_qm"),
    localize((lucky >= 0.2 or in_work) and "kitikami_ogre_lucky" or "maelmc_qm"),
    localize(in_work == true and "kitikami_ogre_done" or in_work and "kitikami_ogre_next" or "maelmc_qm")
  }
  return quest
end
table.insert(to_run_quests,kitikami_ogre_quest)

local calculate_ref = SMODS.current_mod.calculate
SMODS.current_mod.calculate = function(self, context)
  if calculate_ref then
    calculate_ref(self, context)
  end
  if not ((next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code) then
    if context.kitikami_ogre_check and not G.GAME.kitikami_ogre_quest_completed then
      local bonus = 0
      local mult = 0
      local stone = 0
      local lucky = 0
      if G.playing_cards then
        for _, v in pairs(G.playing_cards) do
          if v.config.center.key == "m_bonus" then bonus = bonus + 1 end
          if v.config.center.key == "m_mult" then mult = mult + 1 end
          if v.config.center.key == "m_stone" then stone = stone + 1 end
          if v.config.center.key == "m_lucky" then lucky = lucky + 1 end
        end
      end
      if (bonus/#G.playing_cards >= 0.2) and (mult/#G.playing_cards >= 0.2) and (stone/#G.playing_cards >= 0.2) and (lucky/#G.playing_cards >= 0.2) then
        G.GAME.kitikami_ogre_quest_completed = "set"
        G.E_MANAGER:add_event(Event({
          trigger = "condition",
          blocking = false,
          func = function()
            if G.GAME.maelmc_quest_set then return false end
            maelmc_set_next_boss("bl_maelmc_hearthflame_mask")
            attention_text({scale = 0.8, text = localize("kitikami_ogre_next"), hold = 5*G.SETTINGS.GAMESPEED, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play})
            G.GAME.maelmc_quest_set = true
            return true
          end
        }))
      end
    end
  end
end