--[[local function sepia_quest()
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
table.insert(to_run_quests,sepia_quest)]]

local function display_text()
  local in_work = (G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_maelmc_sepia") or G.GAME.sepia_quest_complete or false
  local has_perrin = next(SMODS.find_card("j_maelmc_photographer")) or in_work
  local blind = has_perrin and (G.GAME and G.GAME.blind and G.GAME.blind.name == "The Mouth") or in_work
  local display_text = {
    localize(has_perrin and "sepia_photo" or "sepia_no_photo"),
    localize(has_perrin and (blind and "sepia_blind" or "sepia_no_blind") or "maelmc_qm"),
    localize(blind and "sepia_spin" or "maelmc_qm")
  }
  return display_text
end

local function reward_text()
  return {localize("sepia_reward")}
end

maelmc_add_quest{
  name = "sepia_quest_name",
  atlas = "maelmc_quests",
  pos = {x = 1, y = 0},
  display_text = display_text,
  dex = 648,
  reward_text = reward_text,
  reward_atlas = "maelmc_boss_blinds",
  reward_pos = {x = 0, y = 0},
  set = "Blind",
}