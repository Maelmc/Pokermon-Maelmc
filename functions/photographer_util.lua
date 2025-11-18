local ts = {
  --"bloodmoon_ursaluna",
  "pikachu","vulpix","mankey","primeape","growlithe","geodude","graveler","snorlax",
  "hoothoot","noctowl","spinarak","ariados","sudowoodo","aipom","yanma","wooper","quagsire","dunsparce","gligar","sneasel","stantler",
  "poochyena","mightyena","lotad","lombre","seedot","nuzleaf","ralts","kirlia","gardevoir","surskit","volbeat","illumise","duskull","dusclops",
  "shinx","luxio","luxray","pachirisu","munchlax","riolu","lucario","gallade",
  "hisuian_basculin","tynamo","eelektrik","litwick","lampent","pawniard","bisharp",
  "goomy","sliggoo","phantump","trevenant",
  "grubbin","charjabug","vikavolt","fomantis","lurantis","salandit","mimikyu",
  "skowvet","greedent","chewtle","drednaw","cramorant","hatenna","hattrem","hatterene","impidimp","morgrem","grimmsnarl","indeedee","indeedee_f","indeedee_m",
  "toedscool","toedscruel","bombirdier","annihilape","dudunsparce","kingambit"
}

timeless_woods_available = {}
for _, v in ipairs(ts) do
  timeless_woods_available[v] = true
end

timeless_woods_keys = {}
G.E_MANAGER:add_event(Event({
  func = function()
    local tmp = {}
    for k, v in pairs(G.P_CENTERS) do
      if timeless_woods_available[v.original_key] then
        tmp[v.original_key] = k
      end
    end
    for _, v in ipairs(ts) do
      if tmp[v] then table.insert(timeless_woods_keys,tmp[v]) end
    end
    return true
  end,
}))

function photographer_util(card)
  local photographers = find_joker("photographer")
  if #photographers > 0 then
    if timeless_woods_available[card.config.center.name] then
      for _, v in ipairs(photographers) do
        if not table.contains(v.ability.extra.found, card.config.center_key) then
          v.ability.extra.found[card.config.center_key] = true
          v:juice_up()
          card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize("maelmc_photo_ex")})
        end
      end
    end
  end
end