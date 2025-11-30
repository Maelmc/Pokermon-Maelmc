-- Stolen from Emma hehe
-- Changing the hand text for 5oak/f5 with mega barbaracle
SMODS.PokerHand:take_ownership("Five of a Kind", {
  modify_display_text = function(self, cards, scoring_hand)
    if #scoring_hand == 6 then
      return "Six of a Kind"
    elseif #scoring_hand == 7 then
      if cards[1]:get_id() == 7 then
        return "Barbarakind"
      end
      return "Seven of a Kind"
    elseif #scoring_hand == 8 then
      return "Eight of a Kind"
    elseif #scoring_hand == 9 then
      return "Nine of a Kind"
    elseif #scoring_hand == 10 then
      return "Ten of a Kind"
    elseif #scoring_hand == 11 then
      if cards[1]:get_id() == 7 then
        return "Mega Barbarakind"
      end
      return "Eleven of a Kind"
    -- with emma's gmax snorlax
    elseif #scoring_hand == 12 then
      return "Twelve of a Kind"
    elseif #scoring_hand == 13 then
      if cards[1]:get_id() == 7 then
        return "Laxing Mega Barbarakind"
      end
      return "Thirteen of a Kind"
    end
  end
}, true)

SMODS.PokerHand:take_ownership("Flush Five", {
  modify_display_text = function(self, cards, scoring_hand)
    if #scoring_hand == 6 then
      return "Flush Six"
    elseif #scoring_hand == 7 then
      if cards[1]:get_id() == 7 then
        return "Barbaraflush"
      end
      return "Flush Seven"
    elseif #scoring_hand == 8 then
      return "Flush Eight"
    elseif #scoring_hand == 9 then
      return "Flush Nine"
    elseif #scoring_hand == 10 then
      return "Flush Ten"
    elseif #scoring_hand == 11 then
      if cards[1]:get_id() == 7 then
        return "Mega Barbaraflush"
      end
      return "Eleven of a Kind"
    -- with emma's gmax snorlax
    elseif #scoring_hand == 12 then
      return "Flush Twelve"
    elseif #scoring_hand == 13 then
      if cards[1]:get_id() == 7 then
        return "Laxing Mega Barbaraflush"
      end
      return "Flush Thirteen"
    end
  end
}, true)

-- Wingull & Pelipper functions to determine their card
local function reset_maelmc_wingull_card()
  G.GAME.current_round.maelmc_wingull_card = { rank = 'Ace' }
  local valid_mail_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(playing_card) then
        valid_mail_cards[#valid_mail_cards + 1] = playing_card
    end
  end
  local mail_card = pseudorandom_element(valid_mail_cards, 'maelmc_wingull' .. G.GAME.round_resets.ante)
  if mail_card then
    G.GAME.current_round.maelmc_wingull_card.rank = mail_card.base.value
    G.GAME.current_round.maelmc_wingull_card.id = mail_card.base.id
  end
end

local function reset_maelmc_pelipper_card()
  G.GAME.current_round.maelmc_pelipper_card = { rank = 'Ace' }
  local valid_mail_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(playing_card) then
      valid_mail_cards[#valid_mail_cards + 1] = playing_card
    end
  end
  local mail_card = pseudorandom_element(valid_mail_cards, 'maelmc_pelipper' .. G.GAME.round_resets.ante)
  if mail_card then
    G.GAME.current_round.maelmc_pelipper_card.rank = mail_card.base.value
    G.GAME.current_round.maelmc_pelipper_card.id = mail_card.base.id
  end
end

-- function that determines what card ogerpon hearthflame uses for the round, copied from The Idol
local function reset_maelmc_hearthflame_card()
    -- multiplayer crash fix
    if SMODS.Mods["Multiplayer"] and SMODS.Mods["Multiplayer"].can_load and MP.should_use_the_order() then
      G.GAME.current_round.maelmc_hearthflame_card = { rank = 'Ace', suit = 'Spades' }

      local count_map = {}
      local valid_hearthflame_cards = {}

      for _, v in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(v,"m_mult") then
          local key = v.base.value .. "_" .. v.base.suit
          if not count_map[key] then
            count_map[key] = { count = 0, card = v }
            table.insert(valid_hearthflame_cards, count_map[key])
          end
          count_map[key].count = count_map[key].count + 1
        end
      end
      --failsafe in case no cards are mult or no cards in deck. Defaults to Ace of Spades
      if #valid_hearthflame_cards == 0 then return end

      local value_order = {}
      for i, rank in ipairs(SMODS.Rank.obj_buffer) do
        value_order[rank] = i
      end

      local suit_order = {}
      for i, suit in ipairs(SMODS.Suit.obj_buffer) do
        suit_order[suit] = i
      end

      table.sort(valid_hearthflame_cards, function(a, b)
        -- Sort by count descending first
        if a.count ~= b.count then return a.count > b.count end

        local a_suit = a.card.base.suit
        local b_suit = b.card.base.suit
        if suit_order[a_suit] ~= suit_order[b_suit] then return suit_order[a_suit] < suit_order[b_suit] end

        local a_value = a.card.base.value
        local b_value = b.card.base.value
        return value_order[a_value] < value_order[b_value]
      end)

      -- Weighted random selection based on count
      local total_weight = 0
      for _, entry in ipairs(valid_hearthflame_cards) do
        total_weight = total_weight + entry.count
      end

      local raw_random = pseudorandom("idol" .. G.GAME.round_resets.ante)

      local threshold = 0
      for _, entry in ipairs(valid_hearthflame_cards) do
        threshold = threshold + (entry.count / total_weight)
        if raw_random < threshold then
          local hearthflame_card = entry.card
          G.GAME.current_round.maelmc_hearthflame_card.rank = hearthflame_card.base.value
          G.GAME.current_round.maelmc_hearthflame_card.suit = hearthflame_card.base.suit
          G.GAME.current_round.maelmc_hearthflame_card.id = hearthflame_card.base.id
          break
        end
      end
      return
    end

    G.GAME.current_round.maelmc_hearthflame_card = { rank = 'Ace', suit = 'Spades' }
    local valid_hearthflame_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card,"m_mult") then
            valid_hearthflame_cards[#valid_hearthflame_cards + 1] = playing_card
        end
    end
    local hearthflame_card = pseudorandom_element(valid_hearthflame_cards, 'maelmc_ogerpon_hearthflame' .. G.GAME.round_resets.ante)
    if hearthflame_card then
        G.GAME.current_round.maelmc_hearthflame_card.rank = hearthflame_card.base.value
        G.GAME.current_round.maelmc_hearthflame_card.suit = hearthflame_card.base.suit
        G.GAME.current_round.maelmc_hearthflame_card.id = hearthflame_card.base.id
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
  reset_maelmc_hearthflame_card()
  reset_maelmc_wingull_card()
  reset_maelmc_pelipper_card()
end

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
local card_set_ability_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
  if self.config and self.config.center and (self.config.center.key == 'm_maelmc_trapped' ) and not initial then
    return
  end
  if G.GAME.modifiers.hazard_deck and self.config.center_key == "m_poke_hazard" and self.ability.card_limit then
    self.ability.card_limit = 0
  end
  return card_set_ability_ref(self, center, initial, delay_sprites)
end

-- Trapped cards cannot be destroyed
local destr = SMODS.destroy_cards
function SMODS.destroy_cards(cards, bypass_eternal, immediate, skip_anim)
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