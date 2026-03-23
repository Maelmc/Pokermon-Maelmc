-- Atlases
SMODS.Atlas({
  key = "modicon",
  path = "icon.png",
  px = 32,
  py = 32
})

SMODS.Atlas({
  key = "jokers",
  path = "jokers.png",
  px = 71,
  py = 95
})

SMODS.Atlas({
  key = "shiny_jokers",
  path = "shiny_jokers.png",
  px = 71,
  py = 95
})

SMODS.Atlas({
  key = "mart",
  path = "mart.png",
  px = 71,
  py = 95
})

SMODS.Atlas({
  key = "vouchers",
  path = "vouchers.png",
  px = 71,
  py = 95
})

SMODS.Atlas({
  key = "pokedeck",
  path = "pokedeck.png",
  px = 71,
  py = 95,
})

SMODS.Atlas({
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34
})

SMODS.Atlas({
    key = "enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "quests",
    path = "quests.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "boss_blinds",
    atlas_table = "ANIMATION_ATLAS",
    path = "boss_blinds.png",
    px = 34,
    py = 34,
    frames = 21,
})

SMODS.Atlas({
    key = "boss_blinds_big",
    atlas_table = "ANIMATION_ATLAS",
    path = "boss_blinds_big.png",
    px = 49,
    py = 49,
    frames = 21,
})

-- Colors
G.C.MAELMC = {
    ORANGE = HEX("EA6F22"),
    GREY = HEX("747474"),
}

-- Sounds
SMODS.Sound({
    key = "pokerus_sound",
    path = "pokerus_sound.wav"
})

SMODS.Sound({
    key = "door",
    path = "door.wav"
})

SMODS.Sound({
  key = "relic_song_music",
  path = "relic_song_music.ogg",
	select_music_track = function()
    if maelmc_config.meloetta_sings and (next(SMODS.find_card("j_maelmc_meloetta",true)) or next(SMODS.find_card("j_maelmc_meloetta_pirouette",true))) then
      return 999999999
    end
    if G.GAME.play_sepia_song then
      return 999999999
    end
	end,
  sync = false,
  pitch = 1,
  volume = 1,
})

-- Shaders
SMODS.Shader({
  key = 'sepia',
  path = 'sepia.fs'
})

-- APRILS FOOLS
SMODS.Sound({
  key = "voltorb_flip_music",
  path = "voltorb_flip_music.ogg",
  select_music_track = function()
    if maelmc_config.voltorb_flip and next(SMODS.find_card("j_poke_voltorb",true)) then
      return 999999999
    end
  end,
  sync = false,
  pitch = 1,
  volume = 1,
})

SMODS.Sound({
  key = "mirror_b_music",
  path = "mirror_b_music.ogg",
	select_music_track = function()
    if G.hand then
      for _, v in ipairs(G.hand.cards) do
        if v.config.center.key == "m_maelmc_ludicolo" then return 9999999999 end
      end
    end

    if G.play then
      for _, v in ipairs(G.play.cards) do
        if v.config.center.key == "m_maelmc_ludicolo" then return 9999999999 end
      end
    end
	end,
  sync = false,
  pitch = 1,
  volume = 1,
})

SMODS.Sound({
    key = "ludicolo",
    path = "ludicolo.ogg"
})

SMODS.Atlas({
  key = "ludicolo",
  path = "ludicolo.png",
  px = 71,
  py = 95,
  atlas_table = "ANIMATION_ATLAS",
  frames = 4,
  fps = 8,
})

SMODS.Atlas({
  key = "shiny_ludicolo",
  path = "shiny_ludicolo.png",
  px = 71,
  py = 95,
  atlas_table = "ANIMATION_ATLAS",
  frames = 4,
  fps = 8,
})

SMODS.Atlas({
  key = "aprils_fool",
  path = "aprils_fool.png",
  px = 71,
  py = 95,
})

SMODS.Atlas({
  key = "mimic",
  path = "mimic.png",
  px = 355,
  py = 475,
})

SMODS.Sound({
  key = "cassette_beasts_face_down_music",
  path = "cassette_beasts_face_down_music.ogg",
  select_music_track = function()
    if next(SMODS.find_card("j_maelmc_fusionmimic",true)) then
      return 999999999
    end
  end,
  sync = { ["maelmc_cassette_beasts_face_down_instrumental_music"] = true },
  pitch = 1,
  volume = 0.5,
})

SMODS.Sound({
  key = "cassette_beasts_face_down_instrumental_music",
  path = "cassette_beasts_face_down_instrumental_music.ogg",
  select_music_track = function()
    if next(SMODS.find_card("j_maelmc_missmimic",true)) then
      return 999999999
    end
  end,
  sync = { ["maelmc_cassette_beasts_face_down_music"] = true },
  pitch = 1,
  volume = 0.5,
})