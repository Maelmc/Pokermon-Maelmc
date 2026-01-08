to_run_quests = {}

function G.FUNCS.maelmc_quest(args)
  local quest_keys = {}
  for _, v in pairs(to_run_quests) do
    table.insert(quest_keys,v())
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

local function sepia_quest()
  local quest = {atlas = "maelmc_quests", pos = {x = 0, y = 0}}
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
  local quest = {atlas = "maelmc_quests", pos = {x = 1, y = 0}}
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
  local quest = {atlas = "maelmc_quests", pos = {x = 2, y = 0}}
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
          G.GAME.maelmc_quest_set = true
          return true
        end
      }))
    end
  end
end