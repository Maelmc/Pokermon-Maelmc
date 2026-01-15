local displayed_quest = {
  name = "",
  req_nodes = {},
  reward_nodes = {}
}

local function update_current_quest(id)
  if not MAELMC_QUESTS[id] then return end
  local curr_quest = MAELMC_QUESTS[id]
  displayed_quest.name = curr_quest.name
  displayed_quest.req_nodes = curr_quest.display_text()
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
      G.CARD_W,
      G.CARD_H * 0.95,
      {
        card_limit = 1,
        type = 'title',
        highlight_limit = 0,
        collection = true,
      }
    )
    G.your_collection[i] = cardarea

    nodes.nodes[#nodes.nodes + 1] = { n = G.UIT.O, config = { object = cardarea } }
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
      print(v)
      table.insert(keys,{atlas = v.atlas, pos = v.pos})
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
          {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
            {n=G.UIT.T, config={text = displayed_quest.name, scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
          }}
        }},
        
        -- prerequisites & reward
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
          cardareas,
          {n = G.UIT.C, config = {align = "cm", padding = 0.05, r = 0.1, colour = G.C.BLACK}, nodes={
            {n=G.UIT.T, config={text = "A", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
          }},
          {n = G.UIT.C, config = {align = "cm", padding = 0.05, r = 0.1, colour = G.C.BLACK}, nodes={
            {n=G.UIT.T, config={text = "B", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
          }}
        }},

        -- cycle menu
        cycle_menu
      }
    },
  }
end