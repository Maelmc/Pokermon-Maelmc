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
pokermon.add_family({"inkay","malamar","mega_malamar"})
pokermon.add_family({"binacle","barbaracle","mega_barbaracle"})
pokermon.add_family({"ralts","kirlia","gardevoir","mega_gardevoir"})
pokermon.add_family({"gible","gabite","garchomp","mega_garchomp"})
pokermon.add_family({"ogerpon","ogerpon_wellspring","ogerpon_hearthflame","ogerpon_cornerstone"})
pokermon.add_family({"galarian_corsola","cursola"})
pokermon.add_family({"deoxys","deoxys_attack","deoxys_defense","deoxys_speed"})
pokermon.add_family({"woobat","swoobat"})
pokermon.add_family({"gulpin","swalot"})

--Load Sprites file
local sprite, load_error = SMODS.load_file("sprites.lua")
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

SMODS.Rarity{
    key = "ultra_beast",
    default_weight = 0,
    badge_colour = HEX("8ED3F6"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

maelmc_config = SMODS.current_mod.config
-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
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

--Load UI stuff
local ui, load_error = SMODS.load_file("functions/ui.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  ui()
end

--Load stickers
local pseals = NFS.getDirectoryItems(mod_dir.."stickers")

for _, file in ipairs(pseals) do
  sendDebugMessage ("The file is: "..file)
  local sticker, load_error = SMODS.load_file("stickers/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_sticker = sticker()
    if curr_sticker.init then curr_sticker:init() end
    
    for i, item in ipairs(curr_sticker.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Sticker(item)
    end
  end
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