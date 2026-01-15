local displayed_quest = {
  name = "PLACEHOLDER",
  req_nodes = {
    n = G.UIT.C,
    config = {
      align = "cm",
      minw = G.CARD_W * 4,
      padding = 0.05,
      r = 0.1,
      colour = G.C.BLACK
    }, nodes={
      {n = G.UIT.R,
      config = { align = "cl" }, nodes={
        {n = G.UIT.T,
        config = {
          align = "cl",
          text = "PLACEHOLDER REQ_NODE",
          scale = 0.4,
          colour = G.C.UI.TEXT_LIGHT
        }}
      }},
    }
  },
  reward_nodes = {
    n = G.UIT.C,
    config = {
      align = "cm",
      minw = G.CARD_W * 2,
      padding = 0.05,
      r = 0.1,
      colour = G.C.BLACK
    }, nodes={
      {n = G.UIT.R,
      config = { align = "cl" }, nodes={
        {n = G.UIT.T,
        config = {
          text = "PLACEHOLDER REWARD_NODE",
          scale = 0.4,
          colour = G.C.UI.TEXT_LIGHT
        }}
      }},
    }
  },
}

local function update_current_quest(id)
  if not MAELMC_QUESTS[id] then return end
  local curr_quest = MAELMC_QUESTS[id]
  displayed_quest.name = localize(curr_quest.name)

  local prerequisites = type(curr_quest.display_text) == "function" and curr_quest.display_text() or curr_quest.display_text
  local nodes={}
  for _, v in ipairs(prerequisites) do
    nodes[#nodes + 1] = {
      n = G.UIT.R,
      config = { align = "cl" },
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

  displayed_quest.reward_nodes.nodes = {}
end

local function create_cardareas(cols)
  G.your_collection = {}
  local nodes = {
      n = G.UIT.C,
      config = {
        align = "cm",
        r = 0.1,
        colour = G.C.BLACK,
        emboss = 0.05
      },
      nodes = {
      }
    }

  for i = 1, cols do
    local cardarea = CardArea(
      G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
      G.ROOM.T.h,
      G.CARD_W*1.05,
      G.CARD_H * 1.025,
      {
        card_limit = 1,
        type = 'title',
        highlight_limit = 0,
        collection = true,
      }
    )
    G.your_collection[i] = cardarea

    nodes.nodes[#nodes.nodes + 1] = { n = G.UIT.O, config = { align = "cm", object = cardarea } }
  end

  return nodes
end

local function populate_quest(options)
  local page = options.page or 1
  local create_card_func = options.create_card_func or poke_create_your_collection_card
  local offset = page - 1
  
  local cardarea = G.your_collection[1]
  local x = cardarea.T.x + cardarea.T.w / 2
  local y = cardarea.T.y

  local key = {atlas = MAELMC_QUESTS[1+offset].atlas, pos = MAELMC_QUESTS[1+offset].pos}
  local card = create_card_func(key, x, y)

  cardarea:emplace(card)
end

G.FUNCS.maelmc_refresh_quest = function(args)
  if not args or not args.cycle_config then return end

  local page = args.cycle_config.current_option
  local create_card_func = args.cycle_config.create_card_func

  for _, cardarea in ipairs(G.your_collection) do
    remove_all(cardarea.cards)
  end

  populate_quest({ page = page, create_card_func = create_card_func })

  update_current_quest(page)
  --args.name_node:recalculate()
  --args.req_nodes:recalculate()
  --args.reward_nodes:recalculate()
  print(args.cycle_config)
  INIT_COLLECTION_CARD_ALERTS()
end

function G.FUNCS.maelmc_quest_menu(args)
  local rows = 1
  local cols = 1
  local keys = {}
  if (next(SMODS.find_mod('Multiplayer')) or next(SMODS.find_mod('NanoMultiplayer'))) and MP.LOBBY.code then
    -- do things for multiplayer
  else
    for _, v in pairs(MAELMC_QUESTS) do
      table.insert(keys,{
        atlas = v.atlas,
        pos = type(v.pos) == "function" and v.pos() or v.pos
      })
    end
  end
  G.SETTINGS.paused = true

  update_current_quest(1)
  local cardareas = create_cardareas(cols)
  populate_quest({create_card_func = PokeDisplayCard})

  local page_text = localize('maelmc_quest')
  local pages = math.max(math.ceil(#keys / (rows * cols)), 1)
  local page_options = {}

  for i = 1, pages do
    page_options[#page_options + 1] = page_text .. ' ' .. i .. '/' .. pages
  end

  local req_nodes_func = function()
  return {n=G.UIT.ROOT, config={align = "cm"}, nodes={displayed_quest.req_nodes}}
  end
  local req_nodes = UIBox({
      definition = req_nodes_func(),
      config = {type = "cm"}
    })

  local function reward_nodes_func()
    return {n=G.UIT.ROOT, config={align = "cm"}, nodes={displayed_quest.reward_nodes}}
  end
  local reward_nodes = UIBox({
    definition = reward_nodes_func(),
    config = {type = "cm"}
  })

  local function name_node_func()
    return {n=G.UIT.ROOT, config={align = "cm"}, nodes={
        {n=G.UIT.T, config={text = displayed_quest.name, scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
      }}
  end
  local name_node = UIBox({
    definition = name_node_func(),
    config = {type = "cm"}
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
        name_node = name_node,
        req_nodes = req_nodes,
        reward_nodes = reward_nodes,
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
          {n=G.UIT.O, config={object = name_node}},
        }},
        
        -- prerequisites & reward
        {n = G.UIT.R, config = {align = "cm", minh = G.CARD_H * 1.5, padding = 0.05}, nodes = {
          cardareas,
          {n=G.UIT.O, config={object = req_nodes}},
          {n=G.UIT.O, config={object = reward_nodes}},
        }},

        -- cycle menu
        cycle_menu
      }
    },
  }
end


-- Quest menu in page_options
local cuibo = create_UIBox_options
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
  table.insert(base.nodes[1].nodes[1].nodes[1].nodes,UIBox_button{id = 'quest_button', label = {localize('maelmc_pokemon_quest')}, button = "maelmc_pokemon_quest", minw = minw})
  return base
end

local function quest_keybind()
  G.FUNCS.maelmc_quest_menu({no_back = true})
end

SMODS.Keybind({ key = "openPokemonQuests", key_pressed = "g", action = quest_keybind })