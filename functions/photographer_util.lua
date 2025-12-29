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

          -- set bloodmoon quest
          local count = 0
          for _, _ in pairs(v.ability.extra.found) do count = count + 1 end
          if (count >= v.ability.extra.to_snap) and not G.GAME.bloodmoon_beast_quest_completed then
            G.GAME.bloodmoon_beast_quest_completed = "in progress"
            G.E_MANAGER:add_event(Event({
              trigger = "condition",
              blocking = false,
              func = function()
                if G.GAME.maelmc_quest_set then return false end
                set_next_boss("bl_maelmc_bloodmoon_beast")
                G.GAME.maelmc_quest_set = true
                v:speak("maelmc_announce_bloodmoon",4,7*G.SETTINGS.GAMESPEED)
                return true
              end
            }))
          end
        end
      end
    end
  end
end

function set_sepia_quest(self,card)
  local card_drag_orig = card.drag

  local shake_rqmt = 25

  card.drag = function(self, offset)
    card_drag_orig(self, offset)
    
    -- Set a starting point if we've just started dragging
    if not card.ability.extra.prev_drag_x or card.ability.extra.prev_drag_x == 0 then card.ability.extra.prev_drag_x = self.T.x end
    if not card.ability.extra.prev_drag_y or card.ability.extra.prev_drag_y == 0 then card.ability.extra.prev_drag_y = self.T.y end

    local x1, x2 = card.ability.extra.prev_drag_x, self.T.x
    local y1, y2 = card.ability.extra.prev_drag_y, self.T.y
    local distance = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

    card.ability.extra.prev_drag_x = self.T.x
    card.ability.extra.prev_drag_y = self.T.y
    card.ability.extra.dist_dragged = distance + (card.ability.extra.dist_dragged or 0)

    if (G.GAME and G.GAME.blind and G.GAME.blind.name == "The Mouth") and card.ability.extra.dist_dragged > shake_rqmt and not G.GAME.sepia_quest_complete then
      set_next_boss("bl_maelmc_sepia",false,false,true,true)
    end
  end

  local card_stop_drag_orig = card.stop_drag
  card.stop_drag = function(self)
    card_stop_drag_orig(self)
    card.ability.extra.prev_drag_x = 0
    card.ability.extra.prev_drag_y = 0
    card.ability.extra.dist_dragged = 0
  end
end