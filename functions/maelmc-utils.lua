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

function get_timeless_woods_pokemon()
  local timeless_woods_available = {
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
  return timeless_woods_available
end

function photographer_util(card)
  local photographers = find_joker("photographer")
  if #photographers > 0 then
    local timeless_woods_available = get_timeless_woods_pokemon()
    if table.contains(timeless_woods_available, card.config.center.name) then
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