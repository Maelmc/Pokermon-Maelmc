local artists = {
  ["KingOfThe-X-Roads"] = { display_name = 'KingOfThe-X-Roads' }
}

local poke_get_artist_info_ref = poke_get_artist_info
poke_get_artist_info = function(name)
  return artists[name] or poke_get_artist_info_ref(name)
end

-- https://www.reddit.com/r/lua/comments/8t0mlf/comment/e13xk1m/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
function maelmc_weighted_random(pool,seed)
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

function maelmc_neighbor_ranks(rank)
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

function maelmc_wonder_trade_string_maker(card)
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

function maelmc_wonder_trade_joker_creation(key,ability,edition)
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

function maelmc_should_cleanse_tag()
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

function maelmc_get_atlas_and_pos(name)
  local sprite_info = PokemonSprites[name]
  if not sprite_info then return {} end
  local atlas_prefix = poke_get_atlas_prefix(name, sprite_info)
  local atlas = "poke_"..poke_get_atlas_string(atlas_prefix, sprite_info.gen_atlas, sprite_info.others_atlas)
  local pos = sprite_info.base.pos
  local soul_pos = sprite_info.base.soul_pos
  return {atlas = atlas, pos = pos, soul_pos = soul_pos}
end

function maelmc_set_next_boss(key,force_next_ante,override_showdown,allow_during_boss,reset_chips)
  if (not allow_during_boss) and G.GAME and G.GAME.blind and G.GAME.blind.boss then
    force_next_ante = true
  end

  if force_next_ante and override_showdown then
    G.GAME.perscribed_bosses[G.GAME.round_resets.ante + 1] = key
    return
  end

  if (G.GAME and G.GAME.blind and G.GAME.blind.boss) and allow_during_boss then
    G.GAME.blind:set_blind(G.P_BLINDS[key])
    ease_background_colour_blind(G.STATE)
    if reset_chips then G.GAME.chips = 0 end
    return
  end

  local ante = G.GAME.round_resets.ante
  G.E_MANAGER:add_event(Event({
    trigger = "condition",
    blocking = false,
    func = function()
      if not G.blind_select then return false end
      if force_next_ante and G.GAME.round_resets.ante < ante + 1 then return false end
      if not override_showdown and G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown then return false end
      local par = G.blind_select_opts.boss.parent
      G.GAME.round_resets.blind_choices.Boss = key
      G.blind_select_opts.boss = UIBox{
        T = {par.T.x, 0, 0, 0, },
        definition =
        {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
        }},
        config = {align="bmi",
          offset = {x=0,y=G.ROOM.T.y + 9},
          major = par,
          xy_bond = 'Weak'
        }
      }
      par.config.object = G.blind_select_opts.boss
      par.config.object:recalculate()
      G.blind_select_opts.boss.parent = par
      G.blind_select_opts.boss.alignment.offset.y = 0
      return true
    end
  }))
end

function maelmc_blind_trigger(card, context, boss_name)
  local boss_trigg = false

  -- The ones that trigger Matador: window, head, club, goad, plant, pillar, flint, eye, mouth, psychic, arm, ox, leaf, hearthflame, wellspring, cornerstone, teal, bloodmoon
  if context.debuffed_hand or context.joker_main then
    if G.GAME.blind.triggered then
      boss_trigg = true
    end

  -- Using a consumable
  elseif context.using_consumeable then
    if context.consumeable.debuff and boss_name == "bl_maelmc_bloodmoon_beast" then
      boss_trigg = true
    end

  -- First hand drawn
  elseif context.first_hand_drawn and boss_name == "The House" then
    boss_trigg = true
  
  -- Serpent setup, only triggers if Serpent is being a malus (aka more than 3 cards were play or discarded)
  elseif (context.press_play or context.pre_discard) and boss_name == "The Serpent" and #G.hand.highlighted > 3 then
    if card then card.ability.extra.boss_blind = "okserpent" end
  
  -- Before discard
  elseif context.pre_discard and boss_name == "bl_poke_gray_godfather" then
    boss_trigg = true
  
  -- Press play
  elseif context.press_play then
    local jokdebuff = false
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].debuff then
        jokdebuff = true
        break
      end
    end

    local forcedselection = false
    local enhancement = false
    local edition = false
    local seal = false

    for i = 1, #G.hand.highlighted do
      if G.hand.highlighted[i].ability.maelmc_forced_selection then
        G.hand.highlighted[i].ability.maelmc_forced_selection = nil
        forcedselection = true
      end
      if G.hand.highlighted[i].config.center ~= G.P_CENTERS.c_base then enhancement = true end
      if G.hand.highlighted[i].edition then edition = true end
      if G.hand.highlighted[i].seal then seal = true end
    end

    local steel_held = false
    for i = 1, #G.hand.cards do
      if SMODS.has_enhancement(G.hand.cards[i],"m_steel") and not table.contains(G.hand.highlighted,G.hand.cards[i]) then
        steel_held = true
        break
      end
    end
    if 
    -- no particular condition
    (boss_name == "The Tooth" or boss_name == "bl_poke_gray_godfather" or boss_name == "bl_maelmc_sepia") or
    -- more cards in (played + held) hand than played hand
    (boss_name == "The Hook" and (#G.hand.cards - #G.hand.highlighted) > 0) or
    -- a joker is debuffed
    ((boss_name == "Crimson Heart" or boss_name == "bl_poke_star" or "bl_poke_iridescent_hacker" or
    boss_name == "bl_maelmc_hearthflame_mask" or boss_name == "bl_maelmc_wellspring_mask" or
    boss_name == "bl_maelmc_cornerstone_mask" or boss_name == "bl_maelmc_teal_mask") and jokdebuff) or
    -- a played card is force selected
    (boss_name == "Cerulean Bell" and forcedselection) or 
    -- a played card has an enhancement, edition or seal
    (boss_name == "bl_sonfive_heatran_boss" and (enhancement or edition or seal)) or
    -- an held card is steel
    (boss_name == "bl_sonfive_meltan_boss" and steel_held) then
      boss_trigg = true
    end
  
  -- Drawn a hand
  elseif context.hand_drawn then
    local facedown = false
    for _, v in pairs(context.hand_drawn) do
      if v.facing == 'back' then
          facedown = true
      end
    end
    if boss_name == "okserpent" or
    ((boss_name == "The Wheel" or boss_name == "The Mark" or boss_name == "The Fish") and facedown) then
      boss_trigg = true
      -- first set the flag when hand is played or discarded, then
      -- only apply boss_trigg when the hand is drawn
      if boss_name == "okserpent" and card then card.ability.extra.boss_blind = "The Serpent" end
    end
  end

  return boss_trigg
end

poke_total_mult = poke_total_mult or function(card)
  local total_mult = (card.ability.perma_mult or 0)
  if card.config.center ~= G.P_CENTERS.m_lucky then
    total_mult = total_mult + card.ability.mult
  end
  if card.edition then
    total_mult = total_mult + (card.edition.mult or 0)
  end
  return total_mult
end