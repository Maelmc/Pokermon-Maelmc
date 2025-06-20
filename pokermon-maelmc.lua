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
table.insert(family,{"ogerpon","ogerpon_wellspring","ogerpon_hearthflame","ogerpon_cornerstone"})

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
   key = "Mart-Maelmc",
   path = "Mart.png",
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

--[[SMODS.Rank {
    key = 'Ogerpon',
    card_key = 'O',
    pos = { x = 0 },
    nominal = 0,
    in_pool = function(self)
      return false
    end,
}]]

maelmc_config = SMODS.current_mod.config
-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load helper function files
local helper, load_error = SMODS.load_file("functions/maelmc-utils.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
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
        item.discovered = true
        if not item.key then
          item.key = item.name
        end
        if not item.custom_pool_func then
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
        item.set_badges = poke_set_type_badge
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
        item.discovered = not pokermon_config.pokemon_discovery
        if item.name == "wobbuffet" then item.discovered = true end
        local prev_load = item.load
        item.load = function(self, card, card_table, other_card)
          card_table.ability.extra.juiced = nil
          if type(self.calculate) == "function" then
            G.E_MANAGER:add_event(Event({
              func = function()
                self.calculate(self, card, {poke_load = true})
                return true
              end
            }))
          end
          if prev_load then
            prev_load(self, card, card_table, other_card)
          end
        end
        SMODS.Joker(item)
      end
    end
  end
end

--Load consumables
local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

for _, file in ipairs(pconsumables) do
  sendDebugMessage ("The file is: "..file)
  local consumable, load_error = SMODS.load_file("consumables/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_consumable = consumable()
    if curr_consumable.init then curr_consumable:init() end
    
    for i, item in ipairs(curr_consumable.list) do
      if not (item.pokeball and not pokermon_config.pokeballs) then
        item.discovered = not pokermon_config.pokemon_discovery
        SMODS.Consumable(item)
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