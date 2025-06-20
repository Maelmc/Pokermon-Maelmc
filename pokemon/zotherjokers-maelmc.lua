-- Gym Leader
local gym_leader={
  name = "gym_leader",
  poke_custom_prefix = "maelmc",
  pos = {x = 1, y = 0},
  config = {extra = {boss = false, form = "Earth"}},
  loc_vars = function(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"Type"}}
    info_queue[#info_queue+1] = {set = 'Other', key = 'gym_leader_tag_pool', vars = {'Uncommon', 'Rare', 'Handy', 'Garbage', 'Investment'}}
    return {vars = {abbr.form}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Other",
  atlas = "Custom-Maelmc",
  blueprint_compat = true,
  calculate = function(self, card, context)
    
    if context.setting_blind and context.blind.boss and not context.blueprint then
      card.ability.extra.boss = true
    end

    if context.end_of_round and card.ability.extra.boss then
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

      if not context.blueprint then
        card.ability.extra.boss = false
      end

      return {
        message = localize('maelmc_gym_beaten')
      }
    end
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
  poke_custom_prefix = "maelmc",
  pos = {x = 0, y = 0},
  config = {extra = {evolve_progress = 0, evolve_after = 108, evolve_using = "The Soul"}},
  loc_vars = function(self, info_queue, card)
    -- just to shorten function
    local abbr = card.ability.extra
    info_queue[#info_queue+1] = { set = 'Spectral', key = 'c_soul'}
    return {vars = {abbr.evolve_progress, abbr.evolve_after, abbr.evolve_using}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Other",
  atlas = "Custom-Maelmc",
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

return {
  name = "Maelmc's Jokers Other",
  list = {
    gym_leader, odd_keystone
  },
}