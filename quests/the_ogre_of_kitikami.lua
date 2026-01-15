local function display_text()
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
  local display_text = {
    localize("kitikami_ogre_enhancements"),
    localize((bonus >= 0.2 or in_work) and "kitikami_ogre_bonus" or "maelmc_qm"),
    localize((mult >= 0.2 or in_work) and "kitikami_ogre_mult" or "maelmc_qm"),
    localize((stone >= 0.2 or in_work) and "kitikami_ogre_stone" or "maelmc_qm"),
    localize((lucky >= 0.2 or in_work) and "kitikami_ogre_lucky" or "maelmc_qm"),
    localize(in_work == true and "kitikami_ogre_done" or in_work and "kitikami_ogre_next" or "maelmc_qm")
  }
  return display_text
end
--table.insert(to_run_quests,kitikami_ogre_quest)

maelmc_add_quest(
  "kitikami_ogre_quest_name",
  "maelmc_quests",
  {x = 3, y = 0},
  display_text,
  1017
)

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