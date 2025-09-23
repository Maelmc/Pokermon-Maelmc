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