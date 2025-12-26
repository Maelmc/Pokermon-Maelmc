local artists = {
  ["KingOfThe-X-Roads"] = { display_name = 'KingOfThe-X-Roads' }
}

local poke_get_artist_info_ref = poke_get_artist_info
poke_get_artist_info = function(name)
  return artists[name] or poke_get_artist_info_ref(name)
end

-- https://www.reddit.com/r/lua/comments/8t0mlf/comment/e13xk1m/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
function weighted_random(pool,seed)
   local poolsize = 0
   for k,v in pairs(pool) do
      poolsize = poolsize + v["weight"]
   end
   if seed then 
    if type(seed) == 'string' then seed = pseudoseed(seed) end
    math.randomseed(seed)
  end
   local selection = math.random(1,poolsize)
   for k,v in pairs(pool) do
      selection = selection - v["weight"] 
      if (selection <= 0) then
         return v
      end
   end
end

function neighbor_ranks(rank)
  local t = {rank}
  if rank == 2 then
    table.insert(t,14)
    table.insert(t,3)
  elseif rank == 14 then
    table.insert(t,2)
    table.insert(t,13)
  else
    table.insert(t,rank-1)
    table.insert(t,rank+1)
  end
  return t
end

function wonder_trade_string_maker(card)
  local key = card.config.center.key
  local msg = "key;" .. key
  if card.edition then
    msg = msg .. "/edition;" .. card.edition.type
  end
  if card.ability and card.ability and key ~= "j_poke_smeargle" and key ~= "j_nacho_passimian" then
    local ability = DataDumper(card.ability)
    ability = string.gsub(ability,"{","§") --maybe mandatory depending on how messages are actually passed by multiplayer mod, need to test
    ability = string.gsub(ability,"}","¤")
    ability = string.gsub(ability,":","|")
    ability = string.gsub(ability,",","ç")
    ability = string.gsub(ability,'\n',"")
    ability = string.gsub(ability,'\r',"")
    msg = msg .. "/extra;" .. ability
  end
  return msg
end

function wonder_trade_joker_creation(key,ability,edition)
  G.E_MANAGER:add_event(Event({
    func = function()
      local card = create_card("Joker", G.jokers, false, nil, nil, nil, key)
      if ability then
        ability = string.gsub(ability,"§","{")
        ability = string.gsub(ability,"¤","}")
        ability = string.gsub(ability,"|",":")
        ability = string.gsub(ability,"ç",",")
        card.ability = load(ability)()
      end
      if edition then
        card:set_edition("e_"..edition)
      else
        card:set_edition()
      end
      card:add_to_deck()
      G.jokers:emplace(card)
      return true
    end
  }))  
end

function should_cleanse_tag()
  for i = 1, #G.GAME.tags do
    if G.GAME.tags[i].key == "tag_maelmc_cleanse_tag" then
      local fake_context = {cleanse_tag = true}
      G.E_MANAGER:add_event(Event({
        func = function()
          G.GAME.tags[i]:apply_to_run(fake_context)
          return true
        end
      }))
      return true
    end
  end
  return false
end

function get_atlas_and_pos(name)
  local sprite_info = PokemonSprites[name]
  if not sprite_info then return {} end
  local atlas_prefix = poke_get_atlas_prefix(name, sprite_info)
  local atlas = "poke_"..poke_get_atlas_string(atlas_prefix, sprite_info.gen_atlas, sprite_info.others_atlas)
  local pos = sprite_info.base.pos
  local soul_pos = sprite_info.base.soul_pos
  return {atlas = atlas, pos = pos, soul_pos = soul_pos}
end