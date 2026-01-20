MAELMC_QUESTS = {}

--- Add a quest to the quest menu
---@param args {name:string, atlas:string, pos:function|table, display_text:function|table, dex:integer|nil, reward_text:function|table, reward_atlas:string|nil, reward_pos:function|table|nil, set:string|nil, designer:string|table|function}
---`name = "sepia_quest_name"` - Key for quest's name localization\
---`atlas = "maelmc_quests"` - Key for the quest's atlas, will be displayed as a PokeDisplayCard\
---`pos = {x = 0, y = 0}` - Table of {x,y} or function that returns said table\
---`display_text = {"a","b"}` - Table of strings or function that returns said table, describing the quest\
---`dex = 1` - Related Pokémon's dex number, or position in the quest's menu\
---`reward_text = {"a","b"}` - Table of strings or function that returns said table, describing rewards\
---`reward_atlas = "maelmc_boss_blinds"` - Key for the reward's atlas, or nil if none\
---`reward_pos = {x = 0, y = 0}` - Table of {x,y} or function that returns said table\
---`set = "Blind"` - The reward's set (only matters for Tag, Blind & Booster)\
---`designer = {name = "Maelmc", colour = G.C.MAELMC.ORANGE, back_colour = nil}` - A string of the designer's name, a table of {name,colour,back_colour} or a function returning either of these
function maelmc_add_quest(args)
  local new_quest = {
    name = args.name,
    atlas = args.atlas,
    pos = args.pos,
    display_text = args.display_text,
    dex = args.dex or 999999,
    reward_text = args.reward_text,
    reward_atlas = args.reward_atlas,
    reward_pos = args.reward_pos,
    set = args.set,
    designer = args.designer
  }

  local insert_at = 1
  for _, v in ipairs(MAELMC_QUESTS) do
    if v.dex > args.dex then
      break
    end
    insert_at = insert_at + 1
  end
  table.insert(MAELMC_QUESTS, insert_at, new_quest)
end

--to_run_quests = {}

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