--default_poke_custom_prefix = "maelmc"

--Load Sprites file
--[[local sprite, load_error = SMODS.load_file("pokesprites.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end]]

--Required by the pokemon family function (right click on a pokemon joker)
table.insert(family, {"glimmet", "glimmora"})
table.insert(family, {"cufant","copperajah","mega_copperajah"})
table.insert(family,{"odd_keystone","spiritomb"})
table.insert(family,{
  {key = "gym_leader", form = "Grass"},
  {key = "gym_leader", form = "Fire"},
  {key = "gym_leader", form = "Water"},
  {key = "gym_leader", form = "Lightning"},
  {key = "gym_leader", form = "Psychic"},
  {key = "gym_leader", form = "Fighting"},
  {key = "gym_leader", form = "Colorless"},
  {key = "gym_leader", form = "Darkness"},
  {key = "gym_leader", form = "Metal"},
  {key = "gym_leader", form = "Fairy"},
  {key = "gym_leader", form = "Dragon"},
  {key = "gym_leader", form = "Earth"},
})
table.insert(family,{"inkay","malamar"})
table.insert(family,{"binacle","barbaracle"})
table.insert(family,{"ralts","kirlia","gardevoir","mega_gardevoir"})
table.insert(family,{"gible","gabite","garchomp","mega_garchomp"})

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
}):register()

SMODS.Atlas({
   key = "Custom-Maelmc",
   path = "Custom.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Custom-Maelmc",
   path = "ShinyCustom.png",
   px = 71,
   py = 95
 }):register()

SMODS.Atlas({
   key = "Pokedex3-Maelmc",
   path = "Pokedex3.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Pokedex3-Maelmc",
   path = "Shinydex3.png",
   px = 71,
   py = 95
 }):register()

SMODS.Atlas({
   key = "Pokedex4-Maelmc",
   path = "Pokedex4.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Pokedex4-Maelmc",
   path = "Shinydex4.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "Pokedex6-Maelmc",
   path = "Pokedex6.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Pokedex6-Maelmc",
   path = "Shinydex6.png",
   px = 71,
   py = 95
 }):register()

SMODS.Atlas({
   key = "Pokedex8-Maelmc",
   path = "Pokedex8.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Pokedex8-Maelmc",
   path = "Shinydex8.png",
   px = 71,
   py = 95
 }):register()

SMODS.Atlas({
   key = "Pokedex9-Maelmc",
   path = "Pokedex9.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Pokedex9-Maelmc",
   path = "Shinydex9.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "Gmax-Maelmc",
   path = "Gmax.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Gmax-Maelmc",
   path = "ShinyGmax.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "Megas-Maelmc",
   path = "Megas.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
   key = "shiny_Megas-Maelmc",
   path = "ShinyMegas.png",
   px = 71,
   py = 95
 }):register()

 SMODS.Atlas({
    key = "pokedeck-Maelmc",
    path = "pokedeck.png",
    px = 71,
    py = 95,
}):register()

maelmc_config = SMODS.current_mod.config
-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")

for _, file in ipairs(pfiles) do
  sendDebugMessage ("The file is: "..file)
  local pokemon, load_error = SMODS.load_file("pokemon/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_pokemon = pokemon()
    if curr_pokemon.init then curr_pokemon:init() end
    
    if curr_pokemon.list and #curr_pokemon.list > 0 then
      for i, item in ipairs(curr_pokemon.list) do
        if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only  then
          item.discovered = true
          if not item.key then
            item.key = item.name
          end
          if not pokermon_config.no_evos and not item.custom_pool_func then
            item.in_pool = function(self)
              return pokemon_in_pool(self)
            end
          end
          if not item.config then
            item.config = {}
          end
          if item.ptype then
            if item.config and item.config.extra then
              item.config.extra.ptype = item.ptype
            elseif item.config then
              item.config.extra = {ptype = item.ptype}
            end
          end
          if item.item_req then
            if item.config and item.config.extra then
              item.config.extra.item_req = item.item_req
            elseif item.config then
              item.config.extra = {item_req = item.item_req}
            end
          end
          if item.evo_list then
            if item.config and item.config.extra then
              item.config.extra.evo_list = item.evo_list
            elseif item.config then
              item.config.extra = {item_req = item.evo_list}
            end
          end
          if pokermon_config.jokers_only and item.rarity == "poke_safari" then
            item.rarity = 3
          end
          --item.poke_custom_prefix = default_poke_custom_prefix
          item.discovered = not pokermon_config.pokemon_discovery 
          SMODS.Joker(item)
        end
      end
    end
  end
end

--Load backs
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] and not pokermon_config.jokers_only then
  local backs = NFS.getDirectoryItems(mod_dir.."backs")

  for _, file in ipairs(backs) do
    sendDebugMessage ("The file is: "..file)
    local back, load_error = SMODS.load_file("backs/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_back = back()
      if curr_back.init then curr_back:init() end
      
      for i, item in ipairs(curr_back.list) do
        SMODS.Back(item)
      end
    end
  end
end

--Load challenges file
local pchallenges = NFS.getDirectoryItems(mod_dir.."challenges")

for _, file in ipairs(pchallenges) do
  local challenge, load_error = SMODS.load_file("challenges/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_challenge = challenge()
    if curr_challenge.init then curr_challenge:init() end
    
    for i, item in ipairs(curr_challenge.list) do
      SMODS.Challenge(item)
    end
  end
end 