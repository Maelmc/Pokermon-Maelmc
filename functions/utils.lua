-- https://stackoverflow.com/questions/2282444/how-to-check-if-a-table-contains-an-element-in-lua
-- function to check if the table contains an element, used by cufant's and gible's family
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
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

local ts = {
  "bloodmoon_ursaluna",
  "pikachu","vulpix","mankey","primeape","growlithe","geodude","graveler","snorlax",
  "hoothoot","noctowl","spinarak","ariados","sudowoodo","aipom","yanma","wooper","quagsire","dunsparce","gligar","sneasel","stantler",
  "poochyena","mightyena","lotad","lombre","seedot","nuzleaf","ralts","kirlia","gardevoir","surskit","volbeat","illumise","duskull","dusclops",
  "shinx","luxio","luxray","pachirisu","munchlax","riolu","lucario","gallade",
  "h_basculin","tynamo","eelektrik","litwick","lampent","pawniard","bisharp",
  "goomy","sliggoo","phantump","trevenant",
  "grubbin","charjabug","vikavolt","fomantis","lurantis","salandit","mimikyu",
  "skowvet","greedent","chewtle","drednaw","cramorant","hatenna","hattrem","hatterene","impidimp","morgrem","grimmsnarl","indeedee","indeedee_f","indeedee_m",
  "toedscool","toedscruel","bombirdier","annihilape","dudunsparce","kingambit"
}

timeless_woods_available = {}

for _, v in ipairs(ts) do
  timeless_woods_available[v] = true
end

function photographer_util(card)
  local photographers = find_joker("photographer")
  if #photographers > 0 then
    if timeless_woods_available[card.config.center.name] then
      for _, v in ipairs(photographers) do
        if not table.contains(v.ability.extra.timeless_woods_found, card.config.center_key) then
          v.ability.extra.timeless_woods_found[#v.ability.extra.timeless_woods_found+1] = card.config.center_key
          v:juice_up()
          card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize("maelmc_photo_ex")})
        end
      end
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