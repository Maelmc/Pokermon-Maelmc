local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    local ret = game_main_menu_ref(self, change_context)

    if maelmc_config.background_color then
        G.SPLASH_BACK:define_draw_steps({
            {
                shader = "splash",
                send = {
                    { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                    { name = "vort_speed", val = 0.4 },
                    { name = "colour_1",   ref_table = G.C.MAELMC,  ref_value = "ORANGE" },
                    { name = "colour_2",   ref_table = G.C.MAELMC,  ref_value = "GREY" },
                },
            },
        })
    end

    return ret
end

SMODS.current_mod.config_tab = function() 
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = {
        {
          n = G.UIT.R,
          config = {
            padding = 0.05,
            align = "cm"
          },
          nodes = {
            {
              n = G.UIT.T,
              config = {
                text = localize("poke_settings_header_norequired"),
                shadow = true,
                scale = 0.75 * 0.8,
                colour = HEX("ED533A")
              }
            }
          },
        },
        {
          n = G.UIT.R,
          config = {
              align = "cm",
              padding = 0.25,
              colour = G.C.CLEAR,
          },
          nodes = {
            create_toggle({
              label = localize("background_color"),
              ref_table = maelmc_config,
              ref_value = "background_color",
            })
          },
        },
        {
          n = G.UIT.R,
          config = {
              align = "cm",
              padding = 0.25,
              colour = G.C.CLEAR,
          },
          nodes = {
            create_toggle({
              label = localize("meloetta_sings"),
              ref_table = maelmc_config,
              ref_value = "meloetta_sings",
            })
          },
        },
        {
          n = G.UIT.R,
          config = {
            padding = 0.05,
            align = "cm"
          },
          nodes = {
            {
              n = G.UIT.T,
              config = {
                text = localize("poke_settings_header_required"),
                shadow = true,
                scale = 0.75 * 0.8,
                colour = HEX("ED533A")
              }
            }
          },
        },
        {
          n = G.UIT.R,
          config = {
              align = "cm",
              padding = 0.25,
              colour = G.C.CLEAR,
          },
          nodes = {
            create_toggle({
              label = localize("disable_spiritomb"),
              ref_table = maelmc_config,
              ref_value = "disable_spiritomb",
            }),
          },
        }
      }
    }
end


-- Quest menu
local cuibo = create_UIBox_options
function create_UIBox_options() 
  local base = cuibo()
  local minw = 0
  local t_node = base.nodes[1].nodes[1].nodes[1].nodes
  for _,v in pairs(t_node) do
      if v.nodes[1].nodes[1].config then
          if v.nodes[1].nodes[1].config.minw > minw then
              minw = v.nodes[1].nodes[1].config.minw
          end
      end
  end
  table.insert(base.nodes[1].nodes[1].nodes[1].nodes,UIBox_button{id = 'quest_button', label = {localize('maelmc_quest')}, button = "maelmc_quest", minw = minw})
  return base
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

to_run_quests = {sepia_quest}

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

local function quest_keybind()
  G.FUNCS.maelmc_quest({no_back = true})
end

SMODS.Keybind({ key = "openPokemonQuests", key_pressed = "q", action = quest_keybind })