local function display_text()
  if (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code then
    return {localize("maelmc_quest_mp_disabled")}
  end
  local in_work = G.GAME.bloodmoon_beast_quest_completed and G.GAME.bloodmoon_beast_quest_completed or false
  local has_perrin = next(SMODS.find_card("j_maelmc_photographer")) or in_work
  local display_text = {
    localize(has_perrin and "bloodmoon_beast_photo" or "bloodmoon_beast_no_photo"),
    localize(has_perrin and "bloodmoon_beast_species" or "maelmc_qm"),
    localize(in_work == true and "bloodmoon_beast_done" or in_work == "in progress" and "bloodmoon_beast_next" or "maelmc_qm")
  }
  return display_text
end

local function reward_text()
  return {localize("bloodmoon_beast_reward")}
end

local function designer()
  return {name = "Maelmc", colour = G.C.MAELMC.ORANGE}
end

maelmc_add_quest{
  name = "bloodmoon_beast_quest_name",
  atlas = "maelmc_quests",
  pos = {x = 2, y = 0},
  display_text = display_text,
  dex = 901,
  reward_text = reward_text,
  reward_atlas = "maelmc_boss_blinds",
  reward_pos = {x = 0, y = 1},
  set = "Blind",
  designer = designer,
}