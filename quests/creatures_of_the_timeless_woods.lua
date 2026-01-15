--[[local function bloodmoon_beast_quest()
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
table.insert(to_run_quests,bloodmoon_beast_quest)]]

local function display_text()
  local in_work = G.GAME.bloodmoon_beast_quest_completed and G.GAME.bloodmoon_beast_quest_completed or false
  local has_perrin = next(SMODS.find_card("j_maelmc_photographer")) or in_work
  local display_text = {
    localize(has_perrin and "bloodmoon_beast_photo" or "bloodmoon_beast_no_photo"),
    localize(has_perrin and "bloodmoon_beast_species" or "maelmc_qm"),
    localize(in_work == true and "bloodmoon_beast_done" or in_work == "in progress" and "bloodmoon_beast_next" or "maelmc_qm")
  }
  return display_text
end

maelmc_add_quest(
  "bloodmoon_beast_quest_name",
  "maelmc_quests",
  {x = 2, y = 0},
  display_text,
  901
)