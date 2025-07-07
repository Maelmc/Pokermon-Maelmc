local tealmask = {
  name = "tealmask",
  key = "tealmask",
  set = "Item",
  config = {max_highlighted = 3, min_highlighted = 1, enhancement = "m_lucky"},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'fitem'}
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
    info_queue[#info_queue+1] = {set = 'Other', key = 'fitem'}
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
    info_queue[#info_queue+1] = {set = 'Other', key = 'fitem'}
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
    info_queue[#info_queue+1] = {set = 'Other', key = 'fitem'}
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
    info_queue[#info_queue+1] = {set = 'Other', key = 'fitem'}
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

local fake_deoxys = {
  name = "fake_deoxys",
  key = "fake_deoxys",
  set = "Spectral",
  pos = {x = 6, y = 14},
  soul_pos = { x = 0, y = 15},
  config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  atlas = "Pokedex3",
  unlocked = true,
  discovered = true,
  no_collection = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    for _,poke in pairs(G.jokers.cards) do
      if string.find(poke.config.center.name,"deoxys") then
        poke_evolve(poke, "j_maelmc_deoxys")
        return
      end
    end
  end,
  in_pool = function(self)
    return false
  end
}

local fake_deoxys_attack = {
  name = "fake_deoxys_attack",
  key = "fake_deoxys_attack",
  set = "Spectral",
  pos = {x = 6, y = 14},
  soul_pos = { x = 1, y = 15},
  config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  atlas = "Pokedex3",
  unlocked = true,
  discovered = true,
  no_collection = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    for _,poke in pairs(G.jokers.cards) do
      if string.find(poke.config.center.name,"deoxys") then
        poke_evolve(poke, "j_maelmc_deoxys_attack")
        return
      end
    end
  end,
  in_pool = function(self)
    return false
  end
}

local fake_deoxys_defense = {
  name = "fake_deoxys_defense",
  key = "fake_deoxys_defense",
  set = "Spectral",
  pos = {x = 6, y = 14},
  soul_pos = { x = 2, y = 15},
  config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  atlas = "Pokedex3",
  unlocked = true,
  discovered = true,
  no_collection = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    for _,poke in pairs(G.jokers.cards) do
      if string.find(poke.config.center.name,"deoxys") then
        poke_evolve(poke, "j_maelmc_deoxys_defense")
        return
      end
    end
  end,
  in_pool = function(self)
    return false
  end
}

local fake_deoxys_speed = {
  name = "fake_deoxys_speed",
  key = "fake_deoxys_speed",
  set = "Spectral",
  pos = {x = 6, y = 14},
  soul_pos = { x = 3, y = 15},
  config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  atlas = "Pokedex3",
  unlocked = true,
  discovered = true,
  no_collection = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    for _,poke in pairs(G.jokers.cards) do
      if string.find(poke.config.center.name,"deoxys") then
        poke_evolve(poke, "j_maelmc_deoxys_speed")
        return
      end
    end
  end,
  in_pool = function(self)
    return false
  end
}

return {name = "Maelmc's Items",
  list = {
    tealmask, wellspringmask, hearthflamemask, cornerstonemask,
    meteorite, --fake_deoxys, fake_deoxys_attack, fake_deoxys_defense, fake_deoxys_speed,
  }
}