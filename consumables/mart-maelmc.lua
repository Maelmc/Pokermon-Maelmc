local tealmask = {
  name = "tealmask",
  key = "tealmask",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1, enhancement = "m_lucky"},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    return {vars = {self.config.max_highlighted}}
  end,
  pos = { x = 0, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.hand.highlighted and #G.hand.highlighted >= self.config.min_highlighted and #G.hand.highlighted <= self.config.max_highlighted then
        if G.jokers.highlighted and #G.jokers.highlighted == 1 then
            if string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon") then
                return true
            else
                return false
            end
        else
            return true
        end
    end
    return false
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon")) and
       not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"ogerpon") and not (poke.config.center.name == "ogerpon") and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_maelmc_ogerpon")
    end
  end,
  in_pool = function(self)
    return next(find_joker("ogerpon_wellspring")) or next(find_joker("ogerpon_hearthflame")) or next(find_joker("ogerpon_cornerstone"))
  end
}

local wellspringmask = {
  name = "wellspringmask",
  key = "wellspringmask",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1, enhancement = "m_bonus"},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    return {vars = {self.config.max_highlighted}}
  end,
  pos = { x = 1, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.hand.highlighted and #G.hand.highlighted >= self.config.min_highlighted and #G.hand.highlighted <= self.config.max_highlighted then
        if G.jokers.highlighted and #G.jokers.highlighted == 1 then
            if string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_wellspring") then
                return true
            else
                return false
            end
        else
            return true
        end
    end
    return false
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_wellspring")) and
       not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"ogerpon") and not (poke.config.center.name == "ogerpon_wellspring") and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_maelmc_ogerpon_wellspring")
    end
  end,
  in_pool = function(self)
    return next(find_joker("ogerpon")) or next(find_joker("ogerpon_hearthflame")) or next(find_joker("ogerpon_cornerstone"))
  end
}

local hearthflamemask = {
  name = "hearthflamemask",
  key = "hearthflamemask",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1, enhancement = "m_mult"},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_mult
    return {vars = {self.config.max_highlighted}}
  end,
  pos = { x = 2, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.hand.highlighted and #G.hand.highlighted >= self.config.min_highlighted and #G.hand.highlighted <= self.config.max_highlighted then
        if G.jokers.highlighted and #G.jokers.highlighted == 1 then
            if string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_hearthflame") then
                return true
            else
                return false
            end
        else
            return true
        end
    end
    return false
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_hearthflame")) and
       not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"ogerpon") and not (poke.config.center.name == "ogerpon_hearthflame") and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_maelmc_ogerpon_hearthflame")
    end
  end,
  in_pool = function(self)
    return next(find_joker("ogerpon")) or next(find_joker("ogerpon_wellspring")) or next(find_joker("ogerpon_cornerstone"))
  end
}

local cornerstonemask = {
  name = "cornerstonemask",
  key = "cornerstonemask",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1, enhancement = "m_stone"},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    return {vars = {self.config.max_highlighted}}
  end,
  pos = { x = 3, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if G.hand.highlighted and #G.hand.highlighted >= self.config.min_highlighted and #G.hand.highlighted <= self.config.max_highlighted then
        if G.jokers.highlighted and #G.jokers.highlighted == 1 then
            if string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_cornerstone") then
                return true
            else
                return false
            end
        else
            return true
        end
    end
    return false
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if #G.hand.highlighted >= self.config.min_highlighted then
      juice_flip(card)
      local enhance = self.config.enhancement
      for i = 1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(enhance, nil, true)
      end
      juice_flip(card, true)
      poke_unhighlight_cards()
      evo_item_use_total(self, card, area, copier)
    else
      highlighted_evo_item(self, card, area, copier)
    end

    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and 
        (string.find(G.jokers.highlighted[1].config.center.name,"ogerpon") and not (G.jokers.highlighted[1].config.center.name == "ogerpon_cornerstone")) and
       not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"ogerpon") and not (poke.config.center.name == "ogerpon_cornerstone") and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
        poke_evolve(target, "j_maelmc_ogerpon_cornerstone")
    end
  end,
  in_pool = function(self)
    return next(find_joker("ogerpon")) or next(find_joker("ogerpon_hearthflame")) or next(find_joker("ogerpon_wellspring"))
  end
}

local meteorite = {
  name = "meteorite",
  key = "meteorite",
  set = "Item",
  config = {extra = {usable = true}},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  pos = { x = 4, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  evo_item = true,
  unlocked = true,
  discovered = true,
  can_use = function(self, card, context)
    if G.jokers.highlighted and #G.jokers.highlighted == 1 then
      if string.find(G.jokers.highlighted[1].config.center.name,"deoxys") then
        return true
      else
        return false
      end
    end
    for _, poke in pairs(G.jokers.cards) do
      if (string.find(poke.config.center.name,"deoxys") and not (poke.debuff)) then
        return true
      end
    end
    return false
  end,
  use = function(self, card, area, copier)
    local target = nil
    if G.jokers.highlighted and #G.jokers.highlighted == 1 and string.find(G.jokers.highlighted[1].config.center.name,"deoxys") and not (G.jokers.highlighted[1].debuff) then
      target = G.jokers.highlighted[1]
    else
      for _, poke in pairs(G.jokers.cards) do
        if (string.find(poke.config.center.name,"deoxys") and not (poke.debuff)) then
          target = poke
          break
        end
      end
    end
    if target then
      if target.config.center.name == "deoxys" then
        poke_evolve(target, "j_maelmc_deoxys_attack")
        return
      end
      if target.config.center.name == "deoxys_attack" then
        poke_evolve(target, "j_maelmc_deoxys_defense")
        return
      end
      if target.config.center.name == "deoxys_defense" then
        poke_evolve(target, "j_maelmc_deoxys_speed")
        return
      end
      if target.config.center.name == "deoxys_speed" then
        poke_evolve(target, "j_maelmc_deoxys")
        return
      end
    end
  end,
  keep_on_use = function(self, card)
    return true
  end,
  in_pool = function(self)
    return false
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      local edition = {negative = true}
      card:set_edition(edition, true, true)
    end
  end
}

local beastball = {
  name = "beastball",
  key = "beastball",
  set = "Spectral",
  pos = { x = 4, y = 0 },
  soul_pos = { x = 5, y = 0},
  atlas = "maelmc_mart",
  cost = 4,
  pokeball = true,
  hidden = true,
  soul_set = "Planet",
  soul_rate = .0046,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
        return true
    else
        return false
    end
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local _card = create_random_poke_joker("beastball", "Ultra Beast")
        _card:add_to_deck()
        G.jokers:emplace(_card)
        return true end }))
    delay(0.6)
  end
}

local metronome = {
  name = "metronome",
  key = "metronome",
  set = "Item",
  config = {hand_played = nil, hand_times = 0, use_at = 5, level_by = 3},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.use_at, card.ability.level_by, (card.ability.hand_played and localize(card.ability.hand_played, 'poker_hands') or localize('poke_none')), card.ability.hand_times}}
  end,
  pos = { x = 6, y = 0 },
  atlas = "maelmc_mart",
  cost = 4,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if card.ability.hand_times >= card.ability.use_at then return true end
    return false
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
    SMODS.smart_level_up_hand(card, card.ability.hand_played, false, 3)
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      if (card.ability.hand_played and card.ability.hand_played ~= context.scoring_name) then
        card.ability.hand_times = 1
        card.ability.hand_played = context.scoring_name
        return {
          message = localize("maelmc_outoftune_dot")
        }
      end
      card.ability.hand_times = card.ability.hand_times + 1
      card.ability.hand_played = context.scoring_name
      local eval = function(c) return c.ability.hand_times >= c.ability.use_at and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
      if card.ability.hand_times % 2 == 1 then
        return {
          message = localize("maelmc_tic")
        }
      else
        return {
          message = localize("maelmc_tac")
        }
      end
    end
  end,
  in_pool = function(self)
    return true
  end
}

return {name = "Maelmc's Items",
  list = {
    tealmask, wellspringmask, hearthflamemask, cornerstonemask,
    --meteorite,
    beastball,
    metronome,
  }
}