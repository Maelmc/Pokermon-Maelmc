-- Atlases
SMODS.Atlas({
  key = "modicon",
  path = "icon.png",
  px = 32,
  py = 32
}):register()

SMODS.Atlas({
  key = "maelmc_jokers",
  path = "jokers.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "maelmc_shiny_jokers",
  path = "shiny_jokers.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "maelmc_mart",
  path = "mart.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "maelmc_vouchers",
  path = "vouchers.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "maelmc_pokedeck",
  path = "pokedeck.png",
  px = 71,
  py = 95,
}):register()

SMODS.Atlas({
    key = "maelmc_stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "maelmc_tags",
    path = "tags.png",
    px = 34,
    py = 34
}):register()

SMODS.Atlas({
    key = "maelmc_enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
}):register()

-- Colors
G.C.MAELMC = {
    ORANGE = HEX("EA6F22"),
    GREY = HEX("747474"),
}

-- Sounds
SMODS.Sound({
    key = "pokerus_sound",
    path = "pokerus_sound.wav"
}):register()

SMODS.Sound({
  key = "relic_song_music",
  path = "relic_song_music.ogg",
	select_music_track = function()
    if maelmc_config.meloetta_sings and (next(SMODS.find_card("j_maelmc_meloetta",true)) or next(SMODS.find_card("j_maelmc_meloetta_pirouette",true))) then
      return 999999999
    end
    if G.GAME.maelmc_sepia then
      return 999999999
    end
	end,
  sync = false,
  pitch = 1,
  volume = 1,
}):register()

-- Shaders
SMODS.Shader({
  key = 'sepia',
  path = 'sepia.fs'
}):register()