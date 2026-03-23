local ludicolo = {
  name = "ludicolo",
  gen = 3,
  pos = {x = 0, y = 0},
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 1,
  cost = 1,
  stage = "Basic",
  ptype = "Water",
  atlas = "maelmc_ludicolo",
  perishable_compat = false,
  blueprint_compat = false,
  eternal_compat = false,
  rental_compat = false,
  calculate = function(self, card, context)
  end,
  add_to_deck = function(self, card, from_debuff)
    local _card = SMODS.create_card { set = "Base", enhancement = "m_maelmc_ludicolo", area = card.area }
    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
    _card.playing_card = G.playing_card
    table.insert(G.playing_cards, _card)
    SMODS.destroy_cards(card,true,true,true)

    G.E_MANAGER:add_event(Event({
      func = function()
        G.deck:emplace(_card)
        _card:start_materialize()
        if G.GAME.blind then G.GAME.blind:debuff_card(_card) end
        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
        save_run()
        return true
      end
    }))
  end,
}

function capture_disc_load(self,card)
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
    if card.ability.extra.dist_dragged > shake_rqmt*card.ability.extra.mult then
      card.ability.extra.dist_dragged = 0
      SMODS.scale_card(card, {
        ref_value = 'mult',
        scalar_value = 'mult_mod',
      })
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

local capture_disc = {
  name = "capture_disc",
  pos = {x = 0, y = 0},
  config = {extra = {mult_mod = 1, mult = 0}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Other",
  atlas = "maelmc_aprils_fool",
  perishable_compat = false,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end

    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.mult > 0 then
      card.ability.extra.mult = 0
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end

  end,
  set_ability = function(self, card, initial, delay_sprites)
    capture_disc_load(self, card)
  end,
}

local missmimic = {
  name = "missmimic",
  pos = {x = 1, y = 0},
  config = {extra = {Xmult = 4}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Metal",
  atlas = "maelmc_aprils_fool",
  perishable_compat = false,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before_but_not_as_much then
      mult = mod_mult(mult * card.ability.extra.Xmult)
      update_hand_text({delay = 0}, {mult = mult})
      card_eval_status_text(card, 'jokers', nil, percent, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}, mult_mod = card.ability.extra.Xmult})
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    for _, v in ipairs(G.jokers.cards) do
      if v.config.center.key == card.config.center.key and v ~= card then
        poke_evolve(v, "j_maelmc_fusionmimic")
        card.mimic_target = true
      end
    end
  end,
}

local fusionmimic = {
  name = "fusionmimic",
  pos = {x = 0, y = 0},
  soul_pos = {x = 1, y = 0},
  display_size = { w = 71, h = 95 },
  config = {extra = {Xmult = 16}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult}}
  end,
  rarity = 4,
  cost = 20,
  stage = "Legendary",
  ptype = "Metal",
  atlas = "maelmc_mimic",
  perishable_compat = false,
  eternal_compat = true,
  blueprint_compat = true,
  aux_poke = true,
  calculate = function(self, card, context)
    if context.before_but_not_as_much then
      mult = mod_mult(mult * card.ability.extra.Xmult)
      update_hand_text({delay = 0}, {mult = mult})
      card_eval_status_text(card, 'jokers', nil, percent, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}, mult_mod = card.ability.extra.Xmult})
    end
  end,
  in_pool = function(self,args)
    return false
  end,
  add_to_deck = function(self, card, from_debuff)
    for _, v in ipairs(G.jokers.cards) do
      if v.mimic_target then
        SMODS.destroy_cards(v,true)
      end
    end
  end,
}

pokermon.add_family({"missmimic","fusionmimic"})

local nibblegar = {
  name = "nibblegar",
  pos = {x = 0, y = 2},
  config = {extra = {hands = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Water",
  starter = true,
  atlas = "maelmc_aprils_fool",
  perishable_compat = true,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

local sheartooth = {
  name = "sheartooth",
  pos = {x = 1, y = 2},
  config = {extra = {hands = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "Basic",
  ptype = "Water",
  atlas = "maelmc_aprils_fool",
  perishable_compat = true,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

local megalobite = {
  name = "megalobite",
  pos = {x = 2, y = 2},
  config = {extra = {hands = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = "poke_safari",
  cost = 10,
  stage = "Two",
  ptype = "Water",
  atlas = "maelmc_aprils_fool",
  perishable_compat = true,
  eternal_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

pokermon.add_family({"nibblegar","sheartooth","megalobite"})

return {
  name = "Maelmc's April's Fools",
  list = {
    ludicolo,
    capture_disc,
    missmimic, fusionmimic,
    nibblegar, sheartooth, megalobite,
  },
}