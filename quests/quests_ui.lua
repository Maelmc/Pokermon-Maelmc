local displayed_quest = {
  id = 1,
  name = "PLACEHOLDER",
  req_nodes = {
    n = G.UIT.C, config = {align = "cl", padding = 0.2, r = 0.1}, nodes={}
  },
  reward_nodes = {
    n = G.UIT.C,
    config = {align = "cm", padding = 0.05, r = 0.1}, nodes={}
  },
  reward_object_node = {
    n = G.UIT.C,
    config = {align = "cm"}, nodes={}
  },
}

local req_nodes_func = function()
  return {n=G.UIT.ROOT, config={align = "cl", colour = G.C.CLEAR}, nodes={displayed_quest.req_nodes}}
end

local function reward_nodes_func()
  return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={displayed_quest.reward_nodes}}
end

local function reward_object_node_func()
  return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={displayed_quest.reward_object_node}}
end

local function update_current_quest(id)
  if not MAELMC_QUESTS[id] then return end
  displayed_quest.id = id
  local curr_quest = MAELMC_QUESTS[id]
  displayed_quest.name = localize(curr_quest.name)

  local prerequisites = type(curr_quest.display_text) == "function" and curr_quest.display_text() or curr_quest.display_text
  local nodes={}
  for _, v in ipairs(prerequisites) do
    nodes[#nodes + 1] = {
      n = G.UIT.R,
      config = { align = "cl"},
      nodes={
        {n = G.UIT.T,
        config = {
          align = "cl",
          text = v,
          scale = 0.4,
          colour = G.C.UI.TEXT_LIGHT
        }}
      }
    }
  end
  displayed_quest.req_nodes.nodes = nodes

  local rewards = type(curr_quest.reward_text) == "function" and curr_quest.reward_text() or curr_quest.reward_text
  local nodes2={}
  for _, v in ipairs(rewards) do
    nodes2[#nodes2 + 1] = {
      n = G.UIT.R,
      config = { align = "cm"},
      nodes={
        {n = G.UIT.T,
        config = {
          align = "cm",
          text = v,
          scale = 0.4,
          colour = G.C.UI.TEXT_LIGHT
        }}
      }
    }
  end
  displayed_quest.reward_nodes.nodes = nodes2

  displayed_quest.reward_object_node.nodes = {{ n = G.UIT.O, config = { align = "cm", object = G.your_collection[2] } }}
end

local function create_cardareas(empty_collection,collection_pos)
  G.your_collection = (empty_collection and {}) or (G.your_collection and G.your_collection or {})
  local nodes = {n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK }, nodes = {}}

  local cardarea = CardArea(
    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
    G.ROOM.T.h,
    G.CARD_W,
    G.CARD_H * 0.95,
    {
      card_limit = 1,
      type = 'title',
      highlight_limit = 0,
      collection = true,
    }
  )
  G.your_collection[collection_pos] = cardarea

  nodes.nodes[#nodes.nodes + 1] = { n = G.UIT.O, config = { align = "cm", object = cardarea } }

  return nodes
end

local function populate_quest(options)
  local page = options.page or 1
  local create_card_func = options.create_card_func or poke_create_your_collection_card
  local offset = page - 1
  
  local cardarea = G.your_collection[1]
  local x = cardarea.T.x + cardarea.T.w / 2
  local y = cardarea.T.y

  local pos = type(MAELMC_QUESTS[1+offset].pos) == "function" and MAELMC_QUESTS[1+offset].pos() or MAELMC_QUESTS[1+offset].pos
  local key = {atlas = MAELMC_QUESTS[1+offset].atlas, pos = pos}
  local card = create_card_func(key, x, y)

  cardarea:emplace(card)
end

local function populate_reward(options)
  local page = options.page or 1
  local create_card_func = options.create_card_func or poke_create_your_collection_card
  local offset = page - 1
  
  local cardarea = G.your_collection[2]
  local x = cardarea.T.x + cardarea.T.w / 2
  local y = cardarea.T.y

  local w = nil
  local h = nil
  if MAELMC_QUESTS[1+offset].set == 'Tag' then
    w = 0.8
    h = 0.8
  elseif MAELMC_QUESTS[1+offset].set == 'Blind' then
    w = 1.3
    h = 1.3
  elseif MAELMC_QUESTS[1+offset].set == 'Booster' then
    w = G.CARD_W*1.27
    h = G.CARD_H*1.27
  end

  local pos = type(MAELMC_QUESTS[1+offset].reward_pos) == "function" and MAELMC_QUESTS[1+offset].reward_pos() or MAELMC_QUESTS[1+offset].reward_pos
  local key = {atlas = MAELMC_QUESTS[1+offset].reward_atlas, pos = pos}
  local card = create_card_func(key, x, y, w, h)

  cardarea:emplace(card)
end

function G.FUNCS.maelmc_refresh_quest(args)
  if not args or not args.cycle_config then return end

  local page = args.cycle_config.current_option
  local create_card_func = args.cycle_config.create_card_func

  for _, cardarea in ipairs(G.your_collection) do
    remove_all(cardarea.cards)
  end

  populate_quest({ page = page, create_card_func = create_card_func })
  if MAELMC_QUESTS[page].reward_atlas then
    populate_reward({ page = page, create_card_func = create_card_func})
  end

  update_current_quest(page)
  
  local req = G.OVERLAY_MENU:get_UIE_by_ID("maelmc_req_nodes")
  req.config.object:remove()
  req.config.object = UIBox {
    definition = req_nodes_func(),
    config = { parent = req, colour = G.C.CLEAR},
  }
  req.UIBox:recalculate()

  local rew = G.OVERLAY_MENU:get_UIE_by_ID("maelmc_reward_nodes")
  rew.config.object:remove()
  rew.config.object = UIBox {
    definition = reward_nodes_func(),
    config = { parent = rew, colour = G.C.CLEAR},
  }
  rew.UIBox:recalculate()

  INIT_COLLECTION_CARD_ALERTS()
end

function G.FUNCS.maelmc_quest_menu(args)
  local rows = 1
  local cols = 1
  local keys = {}
  if (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code then
    -- do things for multiplayer
    sendDebugMessage("[PokermonMaelmc] The Quests button is disabled during a Multiplayer game")
    return -- temporary solution to prevent crashes
  else
    for _, v in pairs(MAELMC_QUESTS) do
      table.insert(keys,{
        atlas = v.atlas,
        pos = type(v.pos) == "function" and v.pos() or v.pos
      })
    end
  end
  G.SETTINGS.paused = true

  local quest_cardarea = create_cardareas(true,1)
  local _ = create_cardareas(false,2)
  local _ = create_cardareas(false,3) -- this one is always empty, just to have something to give to the UIBox
  update_current_quest(1)
  populate_quest({create_card_func = PokeDisplayCard})
  if MAELMC_QUESTS[1].reward_atlas then
    populate_reward({create_card_func = PokeDisplayCard })
  end

  local page_text = localize('maelmc_quest')
  local pages = math.max(math.ceil(#keys / (rows * cols)), 1)
  local page_options = {}

  for i = 1, pages do
    page_options[#page_options + 1] = page_text .. ' ' .. i .. '/' .. pages
  end

  local req_nodes = UIBox({
    definition = req_nodes_func(),
    config = {colour = G.C.CLEAR}
  })

  local reward_nodes = UIBox({
    definition = reward_nodes_func(),
    config = {colour = G.C.CLEAR}
  })

  local reward_object_node = UIBox({
    definition = reward_object_node_func(),
    config = {colour = G.C.CLEAR}
  })

  local cycle_menu = {
    n = G.UIT.R, config = { align = "cm" }, nodes = {
      create_option_cycle {
        options = page_options,
        w = 4.5,
        cycle_shoulders = true,
        opt_callback = 'maelmc_refresh_quest',
        current_option = 1,
        keys = keys,
        rows = rows,
        cols = cols,
        create_card_func = PokeDisplayCard,
        colour = G.C.RED,
        no_pips = true,
        focus_args = {
          snap_to = true,
          nav = 'wide'
        }
      }
    }
  }

  G.FUNCS.overlay_menu {
    definition = create_UIBox_generic_options {
      back_func = nil,
      contents = {
        -- title
        {n=G.UIT.R, config={align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.ORANGE}, nodes={
           {n=G.UIT.T, config={ref_table = displayed_quest, ref_value = "name", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
        }},
        
        -- prerequisites & reward
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
          -- card
          {n = G.UIT.C, config = {align = "cm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.R, config={align = "cr", colour = G.C.CLEAR}, nodes={
              {n = G.UIT.C, config = {align = "cr", padding = 0.2, r = 0.1, colour = G.C.BLACK}, nodes={quest_cardarea}},
            }}
          }},
          
          -- req
          {n = G.UIT.C, config = {align = "cm", minw = G.CARD_W * 3, padding = 0.2, r = 0.1, colour = G.C.BLACK}, nodes={
            {n=G.UIT.R, config={align = "cm", minw = G.CARD_W * 3 - 0.2, padding = 0.1, r = 0.1, colour = G.C.ORANGE}, nodes={
              {n=G.UIT.T, config={text = "Prerequisites", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            }},
            {n=G.UIT.R, config={align = "cl", minh = G.CARD_H * 1.5, padding = 0.1, r = 0.1}, nodes={
              {n=G.UIT.O, config={align = "cl", id = "maelmc_req_nodes", object = req_nodes}},
            }}
          }},

          -- rew
          {n = G.UIT.C, config = {align = "cm", minw = G.CARD_W * 3, minh = G.CARD_H * 1.5, padding = 0.2, r = 0.1, colour = G.C.BLACK}, nodes={
            {n=G.UIT.R, config={align = "cm", minw = G.CARD_W * 3 - 0.2, padding = 0.1, r = 0.1, colour = G.C.ORANGE}, nodes={
              {n=G.UIT.T, config={text = "Reward", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            }},
            {n=G.UIT.R, config={align = "cm", minh = G.CARD_H * 1.5, padding = 0.1, r = 0.1}, nodes={
              {n=G.UIT.C, config={align = "cm", colour = G.C.CLEAR}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1}, nodes={
                  {n=G.UIT.O, config={align = "cm", id = "maelmc_reward_nodes", object = reward_nodes}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1}, nodes={
                  {n=G.UIT.O, config={align = "cm", id = "maelmc_reward_object_node", object = reward_object_node}},
                }}
              }},
            }},
          }},
        }},

        -- cycle menu
        cycle_menu
      }
    },
  }
end


-- Quest menu in page_options
--[[local cuibo = create_UIBox_options
function create_UIBox_options() 
  local base = cuibo()
  local minw = 0
  local t_node = base.nodes[1].nodes[1].nodes[1].nodes
  for _,v in pairs(t_node) do
      if v.nodes[1].nodes[1].config then
          if v.nodes[1].nodes[1].config.minw and v.nodes[1].nodes[1].config.minw > minw then
              minw = v.nodes[1].nodes[1].config.minw
          end
      end
  end
  table.insert(base.nodes[1].nodes[1].nodes[1].nodes,UIBox_button{id = 'quest_button', label = {localize('maelmc_pokemon_quest')}, button = "maelmc_quest_menu", minw = minw})
  return base
end]]

local function quest_keybind()
  G.FUNCS.maelmc_quest_menu({no_back = true})
end

-- Quest menu next to run info
local cuibhud = create_UIBox_HUD
function create_UIBox_HUD()
  local root = cuibhud()
  local quest_button = {n=G.UIT.R, config={align = "cm", minh = 1.75, minw = 1.5, padding = 0.05, r = 0.1, hover = true, colour = G.C.GREEN, button = "maelmc_quest_menu", shadow = true}, nodes={
            {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
              {n=G.UIT.T, config={text = localize('maelmc_quests'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
          }}
  local buttons = root.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1]
  local minh = 0
  for _, v in pairs(buttons.nodes) do
    minh = minh + v.config.minh
  end
  table.insert(buttons.nodes,quest_button)
  minh = minh/#buttons.nodes
  for _, v in pairs(buttons.nodes) do
    v.config.minh = minh
  end
  return root
end

SMODS.Keybind({ key = "openPokemonQuests", key_pressed = "g", action = quest_keybind })