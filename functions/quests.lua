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