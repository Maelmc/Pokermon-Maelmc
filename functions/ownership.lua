-- the following were taken directly from Steamodded's ownerships
local function juice_flip(used_tarot)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    for i = 1, #G.hand.cards do
        local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.cards[i]:flip(); play_sound('card1', percent); G.hand.cards[i]:juice_up(0.3, 0.3); return true
            end
        }))
    end
end

local function random_destroy(used_tarot)
    local destroyed_cards = {}
    destroyed_cards[#destroyed_cards + 1] = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            for i = #destroyed_cards, 1, -1 do
                local card = destroyed_cards[i]
                if SMODS.shatters(card) then
                    card:shatter()
                else
                    card:start_dissolve(nil, i ~= #destroyed_cards)
                end
            end
            return true
        end
    }))
    return destroyed_cards
end

SMODS.Consumable:take_ownership('ouija', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        juice_flip(used_tarot)
        local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('ouija'))
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, nil, _rank.key))
                    return true
                end
            }))
        end
        if not should_cleanse_tag() then
          G.hand:change_size(-1)
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.cards[i]:juice_up(0.3, 0.3); return true
                end
            }))
        end
        delay(0.5)
    end,
},true)

SMODS.Consumable:take_ownership('grim', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local cleanse = not should_cleanse_tag()
        local destroyed_cards = (not cleanse) and random_destroy(used_tarot) or nil
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    -- TODO preserve suit vanilla RNG
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('grim_create')).card_key, 'A'
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        if (not cleanse) then SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards }) end
    end,
}, true)

SMODS.Consumable:take_ownership('familiar', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local cleanse = not should_cleanse_tag()
        local destroyed_cards = (not cleanse) and random_destroy(used_tarot) or nil
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    -- TODO preserve suit vanilla RNG
                    local faces = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if r.face then table.insert(faces, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('familiar_create')).card_key,
                        pseudorandom_element(faces, pseudoseed('familiar_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        if (not cleanse) then SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards }) end
    end,
}, true)

SMODS.Consumable:take_ownership('incantation', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local cleanse = not should_cleanse_tag()
        local destroyed_cards = (not cleanse) and random_destroy(used_tarot) or nil
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    -- TODO preserve suit vanilla RNG
                    local numbers = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if v ~= 'Ace' and not r.face then table.insert(numbers, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('incantation_create')).card_key,
                        pseudorandom_element(numbers, pseudoseed('incantation_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        if (not cleanse) then SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards }) end

    end,
}, true)

-- the following were taken directly from VanillaRemade
SMODS.Consumable:take_ownership('hex', {
  use = function(self, card, area, copier)
      local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
      G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
              local eligible_card = pseudorandom_element(editionless_jokers, 'hex')
              eligible_card:set_edition({ polychrome = true })

              if not should_cleanse_tag() then
                local _first_dissolve = nil
                for _, joker in pairs(G.jokers.cards) do
                    if joker ~= eligible_card and not SMODS.is_eternal(joker, card) then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
              end

              card:juice_up(0.3, 0.5)
              return true
          end
      }))
  end,
}, true)

SMODS.Consumable:take_ownership('ectoplasm', {
  use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'ectoplasm')
                eligible_card:set_edition({ negative = true })

                if not should_cleanse_tag() then
                  G.GAME.ecto_minus = G.GAME.ecto_minus or 1
                  G.hand:change_size(-G.GAME.ecto_minus)
                  G.GAME.ecto_minus = G.GAME.ecto_minus + 1
                end

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
}, true)

SMODS.Consumable:take_ownership('immolate', {
  use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'immolate')

        for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        if not should_cleanse_tag() then SMODS.destroy_cards(destroyed_cards) end

        delay(0.5)
        ease_dollars(card.ability.extra.dollars)
        delay(0.3)
    end,
}, true)

SMODS.Consumable:take_ownership('ankh', {
  use = function(self, card, area, copier)
        local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(joker, card) then deletable_jokers[#deletable_jokers + 1] = joker end
        end

        local chosen_joker = pseudorandom_element(G.jokers.cards, 'ankh_choice')
        local _first_dissolve = nil
        if not should_cleanse_tag() then
          G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.75,
              func = function()
                  for _, joker in pairs(deletable_jokers) do
                      if joker ~= chosen_joker then
                          joker:start_dissolve(nil, _first_dissolve)
                          _first_dissolve = true
                      end
                  end
                  return true
              end
          }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                local copied_joker = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                copied_joker:start_materialize()
                copied_joker:add_to_deck()
                if copied_joker.edition and copied_joker.edition.negative then
                    copied_joker:set_edition(nil, true)
                end
                G.jokers:emplace(copied_joker)
                return true
            end
        }))
    end,
}, true)

SMODS.Consumable:take_ownership('wraith', {
  use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
                card:juice_up(0.3, 0.5)
                if (not should_cleanse_tag()) and G.GAME.dollars ~= 0 then
                    ease_dollars(-G.GAME.dollars, true)
                end
                return true
            end
        }))
        delay(0.6)
    end,
}, true)

-- the following are just copied from Pokermon
SMODS.Consumable:take_ownership('poke_double_rainbow_energy', {
  use = function(self, card, area, copier)
    for i = 1, 2 do
      energy_use(self, card, area, copier, true)
    end
    if (not G.GAME.modifiers.no_interest) and (not should_cleanse_tag()) then
      G.GAME.modifiers.reset_no_interest = true
      G.GAME.modifiers.no_interest = true
    end
  end,
}, true)

SMODS.Consumable:take_ownership('poke_nightmare', {
  use = function(self, card)
    local choice = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
      choice = G.jokers.highlighted[1]
    else
      choice = G.jokers.cards[1]
    end
    local energy = matching_energy(choice, true) or "c_poke_colorless_energy"
    if energy then
      local max = (energy == "c_poke_bird_energy") and 1 or 2
      local context = {}
      for i= 1, max do
        local _card = create_card("Energy", G.pack_cards, nil, nil, true, true, energy, nil)
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
      end
    end
    if not should_cleanse_tag() then remove(self, choice) end
  end,
}, true)