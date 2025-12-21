--Required by the pokemon family function (right click on a pokemon joker)
local name_lists = {{"glimmet", "glimmora","mega_glimmora"},
  {"cufant","copperajah","mega_copperajah"},
  {"odd_keystone","spiritomb"},
  {
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
  },
  {"inkay","malamar","mega_malamar"},
  {"binacle","barbaracle","mega_barbaracle"},
  {"ralts","kirlia","gardevoir","mega_gardevoir"},
  {"gible","gabite","garchomp","mega_garchomp","mega_garchomp_z"},
  {"ogerpon","ogerpon_wellspring","ogerpon_hearthflame","ogerpon_cornerstone"},
  {"galarian_corsola","cursola"},
  {"deoxys","deoxys_attack","deoxys_defense","deoxys_speed"},
  {"woobat","swoobat"},
  {"gulpin","swalot"},
  {"wingull","pelipper"},
  {"sinistea","polteageist"},
  {"shuppet","banette","mega_banette"},
  {"meloetta","meloetta_pirouette"},
  {"poltchageist","sinistcha"}
}

extended_family["shuppet"] = {"fake_mega_banette"}
extended_family["banette"] = {"fake_mega_banette"}
extended_family["mega_banette"] = {"fake_mega_banette"}

for _, list in ipairs(name_lists) do
  pokermon.add_family(list)
end

--Load Assets file
local asset, load_error = SMODS.load_file("assets.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  asset()
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

--Load functions
local pfunc = NFS.getDirectoryItems(mod_dir.."functions")
for _, file in ipairs(pfunc) do
  sendDebugMessage ("The file is: "..file)
  local helper, load_error = SMODS.load_file("functions/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    helper()
  end
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
    
    for _, item in ipairs(curr_sticker.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Sticker(item)
    end
  end
end

--Load tags
local tags = NFS.getDirectoryItems(mod_dir.."tags")

for _, file in ipairs(tags) do
  sendDebugMessage ("The file is: "..file)
  local tag, load_error = SMODS.load_file("tags/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_tag = tag()
    if curr_tag.init then curr_tag:init() end
    
    for _, item in ipairs(curr_tag.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Tag(item)
    end
  end
end

--Load enhancements
local enhancements = NFS.getDirectoryItems(mod_dir.."enhancements")

for _, file in ipairs(enhancements) do
  sendDebugMessage ("The file is: "..file)
  local enhancement, load_error = SMODS.load_file("enhancements/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_enhance = enhancement()
    if curr_enhance.init then curr_enhance:init() end
    
    for _, item in ipairs(curr_enhance.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Enhancement(item)
    end
  end
end

--Load jokers
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
      for _, item in ipairs(curr_pokemon.list) do
        if item.atlas and string.find(item.atlas, "maelmc") then
          pokermon.Pokemon(item,"maelmc",true)
        else
          poke_load_atlas(item)
          poke_load_sprites(item)
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
    
    for _, item in ipairs(curr_consumable.list) do
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
    
    for _, item in ipairs(curr_booster.list) do
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
    
    for _, item in ipairs(curr_voucher.list) do
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
      
      for _, item in ipairs(curr_back.list) do
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
    
    for _, item in ipairs(curr_challenge.list) do
      item.button_colour = HEX('EA6F22')
      SMODS.Challenge(item)
    end
  end
end