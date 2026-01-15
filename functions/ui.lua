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
            padding = 0.25,
            align = "cm"
          },
          nodes = {
            {
              n = G.UIT.T,
              config = {
                text = localize("maelmc_quest_keybind"),
                shadow = true,
                scale = 0.4,
                colour = G.C.WHITE
              }
            }
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
              label = localize("maelmc_background_color"),
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
              label = localize("maelmc_meloetta_sings"),
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
              label = localize("maelmc_disable_spiritomb"),
              ref_table = maelmc_config,
              ref_value = "disable_spiritomb",
            }),
          },
        }
      }
    }
end