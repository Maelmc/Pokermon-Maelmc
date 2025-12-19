-- Gym Leader
local gym_leader={
  name = "gym_leader",
  pos = {x = 1, y = 0},
  config = {extra = {form = "Earth"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"Type"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'gym_leader_tag_pool', vars = {'Uncommon', 'Rare', 'Buffoon', 'Handy', 'Garbage', 'Investment'}}
    local cname = localize('maelmc_gym_leader_name')
    if card.ability.extra.form == "Fairy" then
      cname = localize('maelmc_trial_captain_name')
    end
    return {vars = {abbr.form, cname}}
  end,
  rarity = 1,
  cost = 5,
  stage = "Other",
  atlas = "maelmc_jokers",
  blueprint_compat = true,
  calculate = function(self, card, context)
    
    -- Gym Challenge challenge management
    -- Applying perish to cards in shop and boosters is definied in the lovely patch, the rest is here
    if G.GAME.modifiers.maelmc_gym_challenge and not G.GAME.maelmc_gym_leader_type then
      if card.ability.extra.form == "Darkness" then
        G.GAME.maelmc_gym_leader_type = "Dark"
      else
        G.GAME.maelmc_gym_leader_type = card.ability.extra.form
      end
      G.GAME.perishable_rounds = 3
    end

    if G.GAME.modifiers.maelmc_gym_challenge then
      for _, v in ipairs(G.jokers.cards) do
        if not (v == card) then 
          if not (v.ability.perishable) and not (get_type(v) == G.GAME.maelmc_gym_leader_type) then
            v:set_perishable(true) -- give perishable if not the type of the gym leader
          end
          if (v.ability.perishable) and (get_type(v) == G.GAME.maelmc_gym_leader_type) then
            v.ability.perishable = nil -- remove perishable if it became the type of the gym leader
          end
        end
      end
    end

    -- Regular actions
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and context.beat_boss then
      local tag = ''
      local tag_choice = pseudorandom('gymleader')
      if tag_choice < 1/6 then
        tag = 'tag_handy'
      elseif tag_choice < 2/6 then
        tag = 'tag_garbage'
      elseif tag_choice < 3/6 then
        tag = 'tag_investment'
      elseif tag_choice < 4/6 then
        tag = 'tag_buffoon'
      elseif tag_choice < 5/6 then
        tag = 'tag_uncommon'
      else
        tag = 'tag_rare'
      end
      add_tag(Tag(tag))
      play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
      play_sound('holo1', 1.2 + math.random()*0.1, 0.4)

      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local energy_name = string.lower("c_poke_"..card.ability.extra.form.."_energy")
        local energy = create_card("Energy", G.pack_cards, nil, nil, nil, nil, energy_name, nil)
        energy:add_to_deck()
        G.consumeables:emplace(energy)
        card_eval_status_text(energy, 'extra', nil, nil, nil, {message = localize("poke_plus_energy"), colour = G.ARGS.LOC_COLOURS["pink"]})
      end

      return {
        message = localize('maelmc_gym_beaten')
      }
    end
  end,
  add_to_deck = function(self,card,from_debuff)
    self:set_sprites(card)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial and G.playing_cards then
      local poketype_list = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Darkness", "Metal", "Fairy", "Dragon", "Earth"}
      card.ability.extra.form = pseudorandom_element(poketype_list, pseudoseed("gym_leader"))
      self:set_sprites(card)
    end
  end,
  set_sprites = function(self, card, front)
    local leader_table = {
      Grass = {x = 1, y = 0},
      Fire = {x = 2, y = 0},
      Water = {x = 3, y = 0},
      Lightning = {x = 4, y = 0},
      Psychic = {x = 5, y = 0},
      Fighting = {x = 6, y = 0},
      Colorless = {x = 7, y = 0},
      Darkness = {x = 8, y = 0},
      Metal = {x = 9, y = 0},
      Fairy = {x = 10, y = 0},
      Dragon = {x = 11, y = 0},
      Earth = {x = 12, y = 0},
    }
    if card.ability and card.ability.extra and leader_table[card.ability.extra.form] then
      card.children.center:set_sprite_pos(leader_table[card.ability.extra.form])
    else
      card.children.center:set_sprite_pos(leader_table["Earth"])
    end 
  end,
}

-- Odd Keystone
local odd_keystone={
  name = "odd_keystone",
  --poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 0},
  config = {extra = {evolve_progress = 0, evolve_after = 108, evolve_using = "The Soul"}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    return {vars = {abbr.evolve_progress, abbr.evolve_after, abbr.evolve_using}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  atlas = "maelmc_jokers",
  blueprint_compat = true,
  calculate = function(self, card, context)
    -- if using The Soul, evolve
    --[[if context.using_consumeable and context.consumeable and context.consumeable.ability.name == card.ability.extra.evolve_using then
      
      local nb_joker_pre_soul = #G.jokers.cards
      local nb_consumables_pre_soul = #G.consumeables.cards

      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0, func = function()
        local legendary_to_delete = G.jokers.cards[#G.jokers.cards]

        -- if MissingNo, remove all the created items
        if legendary_to_delete.ability.name == "missingno" then
          local nb_jokers = #G.jokers.cards
          while nb_joker_pre_soul < nb_jokers do
            G.jokers.cards[#G.jokers.cards]:remove()
            nb_jokers = #G.jokers.cards
          end
          local nb_consumables = #G.consumeables.cards
          while nb_consumables_pre_soul < nb_consumables do
            G.consumeables.cards[#G.consumeables.cards]:remove()
            nb_consumables = #G.consumeables.cards
          end
        else
          -- remove the legendary that is not missingno
          legendary_to_delete:remove()
        end

        attention_text({
          text = localize('maelmc_consume'),
          scale = 1.3, 
          hold = 1.4,
          major = card,
          backdrop_colour = G.C.SECONDARY_SET.Tarot,
          align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
          offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
          silent = true
        })
        return true end})
      )
      return {
        message = poke_evolve(card, "j_maelmc_spiritombl"),
      }
    end]]

    if context.remove_playing_cards and not context.blueprint then
      for _, _ in ipairs(context.removed) do
        card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
        G.E_MANAGER:add_event(Event({
          func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_soul_collected')}); return true
          end
        }))
      end
    end

    if context.selling_card and not context.selling_self and not context.blueprint then
      if context.card.config.center.rarity then -- if it's a joker, and thus has a rarity
        if context.card.config.center.rarity == 1 or context.card.config.center.rarity == 2 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + context.card.config.center.rarity

        elseif context.card.config.center.rarity == "poke_safari" or context.card.config.center.rarity == "poke_mega" or context.card.config.center.rarity == 3 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 5

        elseif context.card.config.center.rarity == 4 then
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 10

        else -- if somehow the joker isn't common, uncommon, rare, safari, legendary or mega??
          card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
        end

      else -- if it's a consumeable
        card.ability.extra.evolve_progress = card.ability.extra.evolve_progress + 1
      end
      G.E_MANAGER:add_event(Event({
        func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('maelmc_soul_collected')}); return true
        end
      }))
    end

    return scaling_evo(self, card, context, "j_maelmc_spiritomb", card.ability.extra.evolve_progress, card.ability.extra.evolve_after)
  end,
}

-- Pokéwalker
local pokewalker = {
  name = "pokewalker",
  --poke_custom_prefix = "maelmc",
  pos = {x = 8, y = 2},
  config = {extra = {walk_info = {name = nil, key = nil, edition = nil, seal = nil, type_sticker = nil, ability = {}}, walked_for = -2}}, -- -2 = free to walk smth, -1 = just took the joker sold, 0+ = walking
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    info_queue[#info_queue+1] = {set = 'Other', key = 'energize'}
    if card.ability.extra.walk_info["name"] then
      local wfor = card.ability.extra.walked_for
      if wfor < 0 then wfor = 0 end
      return {vars = {card.ability.extra.walk_info["name"], wfor}}
    else
      return {vars = {localize("maelmc_none"), 0}}
    end
  end,
  rarity = 2,
  cost = 8,
  stage = "Other",
  atlas = "AtlasJokersBasicOthers",
  blueprint_compat = false,
  eternal_compat = false,
  calculate = function(self, card, context)

    -- getting the 1st joker sold when this is possessed
    if context.selling_card and not context.selling_self and not context.blueprint then
      if card.ability.extra.walked_for == -1 then
        card.ability.extra.walked_for = 0
        return
      end
      if context.card.config.center.rarity then --if it's a joker
        if not card.ability.extra.walk_info["name"] then

          -- check position in jokers, only the leftmost pokewalker can get the pokemon
          local pokewalkers = SMODS.find_card("j_maelmc_pokewalker")
          for _, v in pairs(pokewalkers) do
            if v == card then
              break
            end
            if v.ability.extra.walked_for == -1 then -- if another pokewalker already took this joker, end
              return
            end
          end

          local walking = context.card

          -- if it's a mega, devolve it
          if walking.config.center.rarity == "poke_mega" then
            local forced_key = get_previous_evo(walking, true)
            poke_backend_evolve(walking, forced_key)
          end

          -- get joker infos
          card.ability.extra.walk_info["key"] = walking.config.center_key
          card.ability.extra.walk_info["name"] = G.localization.descriptions["Joker"][walking.config.center_key]["name"]
          card.ability.extra.walk_info["edition"] = walking.edition
          card.ability.extra.walk_info["seal"] = walking.seal
          card.ability.extra.walk_info["type_sticker"] = type_sticker_applied(walking)
          for k, v in pairs(walking.ability) do
            card.ability.extra.walk_info["ability"][k] = v
          end
          card.ability.extra.walked_for = -1
          return {
            message = localize("maelmc_pokewalker_taken")
          }
        end
      end
    end

    -- when selling this, recreate the original joker and energize it
    if card.ability.extra.walk_info["name"] and context.selling_self and not context.blueprint then
      local walked = card.ability.extra.walk_info
      local temp_card = {set = "Joker", area = G.jokers, key = walked["key"]}
      local reward_card = SMODS.create_card(temp_card)

      if walked["edition"] then
        reward_card:set_edition(walked["edition"],true)
      end
      if walked["seal"] then
        reward_card:set_seal(walked["seal"],true)
      end
      if walked["type_sticker"] then
        apply_type_sticker(reward_card,walked["type_sticker"])
      end
      for k, v in pairs(walked["ability"]) do
        reward_card.ability[k] = v
      end

      if not get_type(reward_card) and card.ability.extra.walked_for >= 1 then
        apply_type_sticker(reward_card,"Colorless")
      end

      reward_card:add_to_deck()
      G.jokers:emplace(reward_card)
      reward_card:start_materialize()

      for _ = 1, card.ability.extra.walked_for do
        if can_increase_energy(reward_card) then
          increment_energy(reward_card,get_type(reward_card))
        end
      end
    end

    -- increasing walked rounds
    if card.ability.extra.walk_info["name"] and context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
      if card.ability.extra.walked_for == -1 then
        card.ability.extra.walked_for = 0
      end
      card.ability.extra.walked_for = card.ability.extra.walked_for + 1
      return {
        message = localize("maelmc_pokewalker_walking")
      }
    end

  end,
}

-- PC
local pc = {
  name = "pc",
  --poke_custom_prefix = "maelmc",
  pos = {x = 3, y = 1},
  config = {extra = {joker_one_info = {name = nil, card = nil},
                    joker_two_info = {name = nil, card = nil},
                    joker_three_info = {name = nil, card = nil},
                    just_stored = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local jname_one = card.ability.extra.joker_one_info.name or localize("maelmc_none")
    local jname_two = card.ability.extra.joker_two_info.name or localize("maelmc_none")
    local jname_three = card.ability.extra.joker_three_info.name or localize("maelmc_none")
    info_queue[#info_queue+1] = {set = 'Other', key = 'pc_bug'}
    return {vars = {jname_one, jname_two, jname_three}}
  end,
  rarity = 3,
  cost = 10,
  stage = "Other",
  atlas = "maelmc_jokers",
  blueprint_compat = false,
  calculate = function(self, card, context)

    -- getting the 1st 3 joker sold when this is possessed
    if context.setting_blind and not context.blueprint then
      local stored = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then stored = G.jokers.cards[i+1] end
      end
      if stored and not (stored.config.center_key == "j_maelmc_pc") then
        local slot = nil -- find which pc slot to store the joker in
        if not card.ability.extra.joker_one_info.name then slot = "joker_one_info"
        elseif not card.ability.extra.joker_two_info.name then slot = "joker_two_info"
        elseif not card.ability.extra.joker_three_info.name then slot = "joker_three_info" end
        if slot then
          remove(self,stored,context)

          -- if it's a mega, devolve it
          if stored.config.center.rarity == "poke_mega" then
            local forced_key = get_previous_evo(stored, true)
            poke_backend_evolve(stored, forced_key)
          end

          card.ability.extra[slot].name = G.localization.descriptions["Joker"][stored.config.center_key]["name"]
          card.ability.extra[slot].card = stored

          card.ability.extra.just_stored = true
          SMODS.calculate_effect({ message = localize("maelmc_stored") }, card)
        end
      end
    end

    -- calculating stored jokers
    if not context.blueprint then

      local rets = {}
      table.insert(rets, card.ability.extra.joker_one_info.card and card.ability.extra.joker_one_info.card.config and Card.calculate_joker(card.ability.extra.joker_one_info.card, context) or false)
      table.insert(rets, card.ability.extra.joker_two_info.card and card.ability.extra.joker_two_info.card.config and Card.calculate_joker(card.ability.extra.joker_two_info.card, context) or false)
      table.insert(rets, card.ability.extra.joker_three_info.card and card.ability.extra.joker_three_info.card.config and Card.calculate_joker(card.ability.extra.joker_three_info.card, context) or false)
      if not (rets[1]) and not (rets[2]) and not (rets[3]) then return end -- if no joker triggered, do nothing

      -- sum everything but the chips, mult and xmult of all jokers that triggered
      local final_ret = {}
      local scoring = {
        'chips', 'h_chips', 'chip_mod',
        'mult', 'h_mult', 'mult_mod',
        'x_chips', 'xchips', 'Xchip_mod',
        'x_mult', 'Xmult', 'xmult', 'x_mult_mod', 'Xmult_mod',
        'e_mult', 'e_chips', 'ee_mult', 'ee_chips', 'eee_mult', 'eee_chips', 'hyper_mult', 'hyper_chips',
        'emult', 'echips', 'eemult', 'eechips', 'eeemult', 'eeechips', 'hypermult', 'hyperchips',
        'Emult_mod', 'Echip_mod', 'EEmult_mod', 'EEchip_mod', 'EEEmult_mod', 'EEEchip_mod', 'hypermult_mod', 'hyperchip_mod'
      }
      for _, v in ipairs(rets) do
        if v then
          for k, w in pairs(v) do
            if final_ret[k] then
              final_ret[k] = final_ret[k] + w
            elseif not (table.contains(scoring,k)) and k ~= "extra" and k ~= "message" and k ~= "colour" and k ~= "card" then
              final_ret[k] = w
            end
          end
        end
      end

      if not next(final_ret) then return end

      final_ret.colour = G.C.GREY
      final_ret.card = card
      final_ret.message = localize("maelmc_pc")

      return final_ret

    end

  end,
  calc_dollar_bonus = function(self, card)
    local money = 0
    money = money + ((card.ability.extra.joker_one_info.card and card.ability.extra.joker_one_info.card.config and card.ability.extra.joker_one_info.card:calculate_dollar_bonus()) or 0)
    money = money + ((card.ability.extra.joker_two_info.card and card.ability.extra.joker_two_info.card.config and card.ability.extra.joker_two_info.card:calculate_dollar_bonus()) or 0)
    money = money + ((card.ability.extra.joker_three_info.card and card.ability.extra.joker_three_info.card.config and card.ability.extra.joker_three_info.card:calculate_dollar_bonus()) or 0)
    return (money ~= 0 and ease_poke_dollars(card, "pc", money, true)) or nil
  end
}

local photographer = {
  name = "photographer",
  pos = {x = 4, y = 1},
  config = {extra = {found = {}, to_snap = 10, generated_bloodmoon = 0, joker = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    local count = 0
    for _ in pairs(card.ability.extra.found) do count = count + 1 end
    return {vars = {card.ability.extra.joker, card.ability.extra.to_snap, count}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  atlas = "maelmc_jokers",
  blueprint_compat = true,
  calculate = function(self, card, context)

    -- generating bloodmoon ursaluna in the next shop when you reach 10 photos
    if context.reroll_shop or context.starting_shop and (not context.blueprint) then
      local temp_card = nil
      local count = 0
      for _ in pairs(card.ability.extra.found) do count = count + 1 end

      if (count >= card.ability.extra.to_snap) and (card.ability.extra.generated_bloodmoon < 2) then
        if context.starting_shop or (card.ability.extra.generated_bloodmoon == 0 and context.reroll_shop) then
          card.ability.extra.generated_bloodmoon = (context.starting_shop and 2) or 1
          temp_card = {set = "Joker", area = G.shop_jokers}
        else 
          card.ability.extra.generated_bloodmoon = 2
          temp_card = {set = "Joker", area = G.shop_jokers, key = "j_maelmc_bloodmoon_ursaluna"}
        end
      else
        temp_card = {set = "Joker", area = G.shop_jokers}
      end

      local add_card = SMODS.create_card(temp_card)
      if card.ability.extra.generated_bloodmoon == 2 then
        add_card.ability.couponed = true
        card.ability.extra.generated_bloodmoon = 3
      end
      poke_add_shop_card(add_card, card)
    end

    if context.setting_blind and context.blind and context.blind.boss and not context.blueprint then
      if context.blind.name == "The Mouth" and not card.ability.extra.meloetta_generated then
        G.GAME.maelmc_sepia = true
      end
    end

    if context.end_of_round then
      G.GAME.maelmc_sepia = false
    end

  end,
  add_to_deck = function(self, card, from_debuff)
    for _, v in pairs(G.jokers.cards) do
      if table.contains(timeless_woods_available, v.config.center.name) then
        v.ability.extra.found[v.config.center_key] = true
        card:juice_up()
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("maelmc_photo_ex")})
      end
    end
    if G.shop_jokers then
      local temp_card = {set = "Joker", area = G.shop_jokers}
      local add_card = SMODS.create_card(temp_card)
      poke_add_shop_card(add_card, card)
    end
    set_sepia_quest(self, card)
    if G.GAME and G.GAME.blind and G.GAME.blind.name == "The Mouth" then
      G.GAME.maelmc_sepia = true
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    for _, v in pairs(SMODS.find_card("j_maelmc_photographer",true)) do
      if not v.ability.extra.meloetta_generated then
        return
      end
    end
    G.GAME.maelmc_sepia = false
  end,
  load = function(self, card, from_debuff)
    set_sepia_quest(self, card)
  end,
}

local pokemoncenter = {
  name = "pokemoncenter",
  poke_custom_prefix = "maelmc",
  designer = "Gem",
  pos = {x = 10, y = 1},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  atlas = "maelmc_jokers",
  blueprint_compat = true,
  eternal_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability and G.jokers.cards[i].ability.set == "Joker" then
          local ab = G.jokers.cards[i].ability
          if ab.perishable or ab.rental or ab.eternal or ab.sonfive_weakened or G.jokers.cards[i].debuff then
            G.E_MANAGER:add_event(Event({
              func = (function()
                ab.perishable = false
                ab.perish_tally = nil
                ab.eternal = false
                ab.rental = false
                ab.sonfive_weakened = false
                ab.fainted = nil
                if G.jokers.cards[i].config.center_key == "j_agar_regigigas" then
                  ab.extra.rounds = ab.slow_start_rounds
                end
                G.jokers.cards[i]:set_debuff(false)
                card_eval_status_text(G.jokers.cards[i], 'extra', nil, nil, nil, {message = localize("maelmc_healed_ex")})
                return true
              end)
            }))
          end
        end
      end
    end
  end,
  in_pool = function(self)
    local ok = false
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].ability and G.jokers.cards[i].ability.set == "Joker" then
        local ab = G.jokers.cards[i].ability
        if ab.perishable or ab.rental or ab.eternal or ab.sonfive_weakened then
          ok = true
          break
        end
      end
    end
    return ok and pokemon_in_pool(self)
  end
}

--[[

local name = {
  name = "name",
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 0},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  ptype = "Earth",
  atlas = "maelmc_jokers",
  perishable_compat = true,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
}

]]

local list = {
  gym_leader,
  pokewalker,
  --pc,
  photographer,
  pokemoncenter,
}

if not maelmc_config.disable_spiritomb then table.insert(list,2,odd_keystone) end

return {
  name = "Maelmc's Jokers Other",
  list = list,
}