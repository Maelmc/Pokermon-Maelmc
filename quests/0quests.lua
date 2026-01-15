--to_run_quests = {}

MAELMC_QUESTS = {}

---@param name string localization key
---@param atlas string atlas key
---@param pos table|function a table of {x,y}, or a function returning a table of {x,y}
---@param display_text table|function a table of strings, or a function returning a table of strings
---@param dex integer the pokemon's dex number, used to order quests
function maelmc_add_quest(name,atlas,pos,display_text,dex)
  local new_quest = {
    name = name,
    atlas = atlas,
    pos = pos,
    display_text = display_text,
    dex = dex
  }

  local insert_at = 1
  for _, v in ipairs(MAELMC_QUESTS) do
    if v.dex > dex then
      break
    end
    insert_at = insert_at + 1
  end
  table.insert(MAELMC_QUESTS, insert_at, new_quest)
end

--[[function G.FUNCS.maelmc_quest(args)
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
        cols = 1,
        rows = 1,
        dynamic_sizing = false
      }
    },
  }
end]]