-- Ogerpon Cornestone "Stones have a rank"
local gid = Card.get_id
function Card:get_id()
  local ogerpons_cornerstone = find_joker('ogerpon_cornerstone')
  if #ogerpons_cornerstone > 0 and self.ability.effect == 'Stone Card' then
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
  if G.GAME.modifiers.hazard_deck and self.config.center_key == "m_poke_hazard" and self.ability.card_limit then
    self.ability.card_limit = 0
  end
  local ret = card_set_ability_ref(self, center, initial, delay_sprites)
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
  end
	return ret
end