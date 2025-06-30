local pokemart = {
	key = "pokemart",
	atlas = "maelmc_vouchers",
    order = 37,
    set = "Voucher",
    pos = { x = 0, y = 0 },
    config = {extra = {rate = 2}},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rate } }
	end,
  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.item_rate = G.GAME.item_rate * card.ability.extra.rate
        return true
      end
    }))
  end,
  unredeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.item_rate = G.GAME.item_rate / card.ability.extra.rate
        return true
      end
    }))
  end,
}

local departmentstore = {
	key = "departmentstore",
	atlas = "maelmc_vouchers",
    order = 38,
    set = "Voucher",
    pos = { x = 1, y = 0 },
    config = {extra = {rate = 4}},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    requires = {"v_maelmc_pokemart"},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rate } }
	end,
  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.item_rate = G.GAME.item_rate * card.ability.extra.rate
        return true
      end
    }))
  end,
  unredeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.item_rate = G.GAME.item_rate / card.ability.extra.rate
        return true
      end
    }))
  end,
}


return {name = "Maelmc's Vouchers",
        list = {pokemart, departmentstore}
}