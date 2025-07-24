--default_poke_custom_prefix = "maelmc"

--Load Sprites file
--[[local sprite, load_error = SMODS.load_file("pokesprites.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end]]

--Required by the pokemon family function (right click on a pokemon joker)
pokermon.add_family({"glimmet", "glimmora"})
pokermon.add_family({"cufant","copperajah","mega_copperajah"})
pokermon.add_family({"odd_keystone","spiritomb"})
pokermon.add_family({
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
pokermon.add_family({"inkay","malamar"})
pokermon.add_family({"binacle","barbaracle"})
pokermon.add_family({"ralts","kirlia","gardevoir","mega_gardevoir"})
pokermon.add_family({"gible","gabite","garchomp","mega_garchomp"})
pokermon.add_family({"ogerpon","ogerpon_wellspring","ogerpon_hearthflame","ogerpon_cornerstone"})
pokermon.add_family({"g_corsola","cursola"})
pokermon.add_family({"deoxys","deoxys_attack","deoxys_defense","deoxys_speed"})
pokermon.add_family({"woobat","swoobat"})

--Load Sprites file
local sprite, load_error = SMODS.load_file("maelmcsprites.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end

SMODS.Rank {
  key = 'Ogerpon',
  card_key = 'O',
  pos = { x = 0 },
  nominal = 0,
  weight = 0,
  in_pool = function(self)
    return false
  end,
}

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

--Load Debuff logic
local debuff, load_error = SMODS.load_file("functions/debuffs.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  debuff()
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
        if string.find(item.atlas, "maelmc") then
          pokermon.Pokemon(item,"maelmc",true)
        else
          pokermon.Pokemon(item,"maelmc",false)
        end
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

--Load boosters
local pboosters = NFS.getDirectoryItems(mod_dir.."boosters")

for _, file in ipairs(pboosters) do
  sendDebugMessage ("The file is: "..file)
  local booster, load_error = SMODS.load_file("boosters/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_booster = booster()
    if curr_booster.init then curr_booster:init() end
    
    for i, item in ipairs(curr_booster.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Booster(item)
    end
  end
end

--Load vouchers
local vouchers = NFS.getDirectoryItems(mod_dir.."vouchers")

for _, file in ipairs(vouchers) do
  sendDebugMessage ("The file is: "..file)
  local voucher, load_error = SMODS.load_file("vouchers/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_voucher = voucher()
    if curr_voucher.init then curr_voucher:init() end
    
    for i, item in ipairs(curr_voucher.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Voucher(item)
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
      item.button_colour = HEX('EA6F22')
      SMODS.Challenge(item)
    end
  end
end