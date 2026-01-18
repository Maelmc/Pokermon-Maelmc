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