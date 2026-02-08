-- Ogerpon Cornestone "Stones have a rank"
local gid = Card.get_id
function Card:get_id()
  local ogerpons_cornerstone = find_joker('ogerpon_cornerstone')
  if #ogerpons_cornerstone > 0 and SMODS.has_enhancement(self,"m_stone") then
      return SMODS.Ranks["maelmc_Ogerpon"].id
  end
  return gid(self)
end

-- Trapped cards cannot change enhancement
-- also hazard deck effect
-- also kitikami ogre quest
local card_set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
  if self.config and self.config.center and (self.config.center.key == 'm_maelmc_trapped' ) and not initial then
    return
  end
  if G.GAME.modifiers.hazard_deck and self.config.center and self.config.center.key == "m_poke_hazard" and self.ability and self.ability.card_limit then
    self.ability.card_limit = self.ability.card_limit - 1
  end
  local ret = card_set_ability_ref(self, center, initial, delay_sprites)
  if G.GAME.modifiers.hazard_deck and self.config.center and self.config.center.key == "m_poke_hazard" then
    if not self.ability then self.ability = {} end
    self.ability.card_limit = (self.ability.card_limit or 0) + 1
  end
  SMODS.calculate_context({kitikami_ogre_check = true})
  return ret
end

-- Trapped cards cannot be destroyed
local destr = SMODS.destroy_cards
function SMODS.destroy_cards(cards, bypass_eternal, immediate, skip_anim)
  if not cards[1] then
    if Object.is(cards, Card) then
      cards = {cards}
    else
      return
    end
  end
  local cards2 = {}
  for _, v in pairs(cards) do
    if SMODS.has_enhancement(v,"m_maelmc_trapped") then
      v.getting_sliced = nil
    else
      table.insert(cards2,v)
    end
  end
  return destr(cards2, bypass_eternal, immediate, skip_anim)
end

local prc = poke_remove_card
poke_remove_card = function(target, card, trigger)
  if SMODS.has_enhancement(target,"m_maelmc_trapped") then
    target.getting_sliced = nil
    target.shattered = nil
    target.destroyed = nil
    return
  else
    return prc(target, card, trigger)
  end
end

local sht = Card.shatter
function Card:shatter()
  if SMODS.has_enhancement(self,"m_maelmc_trapped") then
    self.getting_sliced = nil
    self.shattered = nil
    self.destroyed = nil
    return
  else
    return sht(self)
  end
end

local dis = Card.start_dissolve
function Card:start_dissolve()
  if SMODS.has_enhancement(self,"m_maelmc_trapped") then
    self.getting_sliced = nil
    self.shattered = nil
    self.destroyed = nil
    return
  else
    return dis(self)
  end
end

-- Trapped cards cannot be discarded
local can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
  for _, v in pairs(G.hand.highlighted) do
    if SMODS.has_enhancement(v,"m_maelmc_trapped") then
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
      return
    end
  end
  can_discard(e)
end

local discard_cards_from_highlighted = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
  local targets = {}
  table.append(targets,G.hand.highlighted)
  for _, v in pairs(targets) do
    if SMODS.has_enhancement(v,"m_maelmc_trapped") then
      G.hand:remove_from_highlighted(v, true)
      v:highlight(false)
      G.E_MANAGER:add_event(Event({
        func = function()
          v:highlight(false)
          return true
        end
      }))
    end
  end
  discard_cards_from_highlighted(e,hook)
end

-- Spell tag dupping spectral cards
local use_consumeable = Card.use_consumeable
function Card:use_consumeable(area, copier)
	local ret = use_consumeable(self, area, copier)
  local keep = (self.config.center.keep_on_use and type(self.config.center.keep_on_use) == 'function' and self.config.center:keep_on_use(self)) or false
  if self.config.center.set == "Spectral" and not keep then
    G.E_MANAGER:add_event(Event({func = function() G.E_MANAGER:add_event(Event({func = function() G.E_MANAGER:add_event(Event({func = function()
    for i = 1, #G.GAME.tags do
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if G.GAME.tags[i].key == "tag_maelmc_spell_tag" then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          local fake_context = {spell_tag = true}
          G.E_MANAGER:add_event(Event({
            func = function()
              local _card = create_card('Spectral',G.consumeables, nil, nil, nil, nil,self.config.center.key)
              _card:add_to_deck()
              G.consumeables:emplace(_card)
              G.GAME.consumeable_buffer = 0
              G.GAME.tags[i]:apply_to_run(fake_context)
              return true
            end
          }))
        end
      else break end
    end
    return true end })) return true end })) return true end }))
  end
	return ret
end

-- Right-click on Photographer to see all Pokémon taken in photo
local gfk = get_family_keys
get_family_keys = function(card)
  local ret = gfk(card)
  if card.config.center.name == "photographer" then
    for _, v in ipairs(timeless_woods_keys) do
        if not card.ability.extra.found[v] then
          table.insert(ret, v)
        end
    end
  end
  return ret
end

-- Photographer compatible with evolving pokemon
local pbe = poke_backend_evolve
poke_backend_evolve = function(card, to_key, energize_amount)
  local ret = pbe(card, to_key, energize_amount)
  maelmc_photographer_util(card)
  return ret
end

-- Guzzlord eats the reroll button
local cr = G.FUNCS.can_reroll
G.FUNCS.can_reroll = function(e)
  if G.GAME.modifiers.guzzlord_eat_shop_reroll then
    e.config.colour = G.C.BLACK
    e.config.button = nil
    return
  end
  return cr(e)
end

-- Guzzlord eats the shop sign
local guidef_shop_ref = G.UIDEF.shop
function G.UIDEF.shop()
  local ret = guidef_shop_ref()
  if G.GAME.modifiers.guzzlord_eat_shop_sign and G.SHOP_SIGN then G.SHOP_SIGN:remove() end
  return ret
end

-- Multiple Mega Malamar hooks
local cscui = create_shop_card_ui
create_shop_card_ui = function(card, type, area)
  local ret = cscui(card, type, area)
  if #find_joker("mega_malamar") > 0 and not (card.facing == 'back') then
    card.facing = 'back'
    card.sprite_facing = 'back'
  end
  return ret
end

-- Competitive Deck
local gptcr = get_poke_target_card_ranks
get_poke_target_card_ranks = function(seed, num, default, use_deck)
  if G.GAME and G.GAME.modifiers.competitivedeck then
    -- thanks copilot for doing all that lol
    local id_counts = {}
  
    -- Count occurrences of each id
    for _, v in pairs(G.playing_cards) do
      local id = v.base.id
      id_counts[id] = (id_counts[id] or 0) + 1
    end
    
    -- Convert to array of {id, count} for sorting
    local sorted_ids = {}
    for id, count in pairs(id_counts) do
      table.insert(sorted_ids, {id = id, count = count})
    end
    
    -- Sort by count (descending)
    table.sort(sorted_ids, function(a, b)
      return a.count > b.count
    end)
    
    -- Shuffle within groups of equal counts
    local i = 1
    while i <= #sorted_ids do
      local current_count = sorted_ids[i].count
      local j = i
      while j < #sorted_ids and sorted_ids[j + 1].count == current_count do
        j = j + 1
      end
      -- Fisher-Yates shuffle for this group
      for k = j, i + 1, -1 do
        local swap_idx = pseudorandom(seed, i, k)
        sorted_ids[k], sorted_ids[swap_idx] = sorted_ids[swap_idx], sorted_ids[k]
      end
      i = j + 1
    end
    
    -- Helper function to convert id to value
    local function id_to_value(id)
      if id == 11 then return "Jack"
      elseif id == 12 then return "Queen"
      elseif id == 13 then return "King"
      elseif id == 14 then return "Ace"
      else return tostring(id)
      end
    end
    
    -- Pick the top num ids
    local result = {}
    for i = 1, math.min(num, #sorted_ids) do
      local id = sorted_ids[i].id
      table.insert(result, {value = id_to_value(id), id = id})
    end
    
    -- Fill remaining with default table
    if #result < num and default then
      for _, default_item in ipairs(default) do
        local already_picked = false
        local default_id = default_item.id or default_item
        for _, picked in ipairs(result) do
          if picked.id == default_id then
            already_picked = true
            break
          end
        end
        if not already_picked then
          table.insert(result, {value = id_to_value(default_id), id = default_id})
          if #result == num then break end
        end
      end
    end

    local sort_function = function(card1, card2) return card1.id < card2.id end
    table.sort(result, sort_function)
    return result

  end
  return gptcr(seed, num, default, use_deck)
end

local gptcs = get_poke_target_card_suit
get_poke_target_card_suit = function(seed, use_deck, default, limit_suits)
  if G.GAME and G.GAME.modifiers.competitivedeck then
    local suit_counts = {}
    local suit = default or 'Spades'
    local allowed_suits = limit_suits or SMODS.Suits

    for _, v in pairs(G.playing_cards) do
      if not SMODS.has_no_suit(v) and not SMODS.has_any_suit(v) then
        for x, y in pairs(allowed_suits) do
          if (y.key and v:is_suit(y.key)) or v:is_suit(y) then
            suit_counts[y.key and y.key or y] = (suit_counts[y.key and y.key or y] or 0) + 1
            break
          end
        end
      end
    end

    local sorted_suits = {}
    for suit, count in pairs(suit_counts) do
      table.insert(sorted_suits, {suit = suit, count = count})
    end

    if #sorted_suits == 0 then
      return {{suit = suit}}
    end

    table.sort(sorted_suits, function(a, b)
      return a.count > b.count
    end)

    local i = 1
    while i <= #sorted_suits do
      local current_count = sorted_suits[i].count
      local j = i
      while j < #sorted_suits and sorted_suits[j + 1].count == current_count do
        j = j + 1
      end
      -- Fisher-Yates shuffle for this group
      for k = j, i + 1, -1 do
        local swap_idx = pseudorandom(seed, i, k)
        sorted_suits[k], sorted_suits[swap_idx] = sorted_suits[swap_idx], sorted_suits[k]
      end
      i = j + 1
    end

    return {{suit = sorted_suits[1].suit}}

  end
  return gptcs(seed, use_deck, default, limit_suits)
end

local gptce = get_poke_target_card_enhancements
get_poke_target_card_enhancements = function(seed, num, options)
  if G.GAME and G.GAME.modifiers.competitivedeck then
    -- another copilot shenanigans, cant be bothered to code that
    local counts = {}
    local result = {}
    local options = options or {"m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_gold", "m_lucky"}

    -- build allowed lookup if options provided (accept strings or tables with .key)
    local allowed = nil
    if options then
      allowed = {}
      for _, v in ipairs(options) do
        local k = (type(v) == 'table' and v.key) or v
        allowed[k] = true
      end
    end

    if G.playing_cards then
      for _, card in ipairs(G.playing_cards) do
        if card and card.ability and card.ability.set == "Enhanced" and card.config and card.config.center and card.config.center.key then
          local key = card.config.center.key
          if (not allowed) or allowed[key] then
            counts[key] = (counts[key] or 0) + 1
          end
        end
      end
    end

    -- Group keys by count
    local buckets = {}
    for k, c in pairs(counts) do
      buckets[c] = buckets[c] or {}
      table.insert(buckets[c], k)
    end

    -- Get sorted counts descending
    local count_keys = {}
    for c in pairs(buckets) do table.insert(count_keys, c) end
    table.sort(count_keys, function(a,b) return a > b end)

    -- For each count bucket, pick items in pseudo-random order
    for _, c in ipairs(count_keys) do
      while #buckets[c] > 0 and #result < num do
        local pick = pseudorandom_element(buckets[c], pseudoseed((seed or "") .. "_enh_" .. c .. "_" .. #result))
        -- remove picked from bucket
        for i = 1, #buckets[c] do
          if buckets[c][i] == pick then table.remove(buckets[c], i); break end
        end
        table.insert(result, pick)
      end
      if #result >= num then break end
    end

    -- If not enough, fill from options (or any seen keys) pseudo-randomly
    if #result < num then
      local source = {}
      if options then
        for _, v in ipairs(options) do
          local k = (type(v) == 'table' and v.key) or v
          table.insert(source, k)
        end
      else
        for k in pairs(counts) do table.insert(source, k) end
      end
      -- remove already selected from source
      for i = #source, 1, -1 do
        for _, sel in ipairs(result) do
          if source[i] == sel then table.remove(source, i); break end
        end
      end
      local idx = 1
      while #result < num and #source > 0 do
        local pick = pseudorandom_element(source, pseudoseed((seed or "") .. "_fill_" .. idx))
        -- add if not present
        local present = false
        for _, v in ipairs(result) do if v == pick then present = true; break end end
        if not present then table.insert(result, pick) end
        -- remove from source
        for i = 1, #source do if source[i] == pick then table.remove(source, i); break end end
        idx = idx + 1
      end
    end

    -- trim to num
    while #result > num do table.remove(result) end
    return result
  end
  return gptce(seed, num, options)
end