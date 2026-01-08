## Create shiny sprites for your cards
In Pokémon, a shiny is just a rare Pokémon with a different color that the rest of its species. So in Pokermon, one of the effects of the "Shiny" edition is to change a card's sprite to a shiny one. This requires 2 things : an image containing shiny sprites, and loading an atlas for it. (Note: if you don't define shiny sprites, the game won't crash or anything. The sprite won't change but the particles will still show and other effects will apply.)

Sprites for a specific card in the shiny image should be in the same position as in the non-shiny image. You can get an example of how Pokermon does it by checking `assets > 1x > Basic Series > AtlasJokersBasicGen01` and `AtlasJokersBasicGen01Shiny`.

The atlas' key should have the same name as the non-shiny atlas, ending with "Shiny" (ex: if your atlas for jokers has `joker` as its key, then your atlas for shiny jokers should have `jokerShiny` as its key).

## Create Pokermon content
### Create a Joker
##### Pokermon specific values
- `aux_poke`: If set to `true`, prevents Transformation from evolving a Pokémon into this Joker and `get_random_poke_key` from returning this Joker's key. Usually used on forms except Mega, such as the Rotom forms
- `item_req`: a `string` or table of `string` containing the name(s) of item(s) that can evolve this Pokémon
  - `evo_list`: a table of `itemname = joker_key`, for Pokémon that have multiple `item_req` (ex: `{waterstone = "j_poke_vaporeon", thunderstone = "j_poke_jolteon", firestone = "j_poke_flareon"}`)
- in `loc_vars(self, info_queue, card)`, include a call to `type_tooltip(self, info_queue, card)`
- `name`: The card's name, which will be used to define its key and can be used to automatically select its sprite (see the "Loading the Joker" section)
- `ptype`: Among `Grass`, `Fire`, `Water`, `Lightning`, `Psychic`, `Fighting`, `Colorless`, `Dark`, `Metal`, `Fairy`, `Dragon` and `Earth`. Leave this field empty if the `stage` is `Other`
- `rarity`: Pokermon introduces 2 new rarities:
  - `"poke_safari"` which can't appear in the shop or packs
  - `"poke_mega"` which is used for Mega Evolutions specifically
- `stage`: Among `"Baby"`, `"Basic"`, `"One"`, `"Two"`, `"Mega"` and `"Other"` for jokers that aren't Pokémon, such as Rival. Defines this Pokémon's evolutionary stage.
- `volatile`: `true` if this Joker has a Volatile effect. 

##### Loading the Joker
To load a Pokémon joker, there are some useful functions you'll want to use:
* `poke_load_atlas(joker)` and `poke_load_sprites(joker)`. The first one selects the correct atlas according to the joker's `name` field, and the second sets the `pos` and `soul_pos`. That means you don't have to manually set these fields when creating your joker. Call these functions before the next one if you want to use them.
* `pokermon.Pokermon(joker, prefix, atlas)` will load your Joker as if it was a Pokermon joker.
  - `joker`: the Joker item, the one that you'd pass to SMODS.Joker if you were loading a regular joker
  - `prefix`: your mod's prefix
  - `atlas`: true or false, whether you use an atlas of your own or a Pokermon atlas
* `pokermon.add_family(table)` will add the family in the table to the list of all Pokémon families. This is important for, among other things, Pokédex and Transformation. If a Pokémon is alone in its family, there's no need to define this table.
  - `table`: a table containing each name of the pokémon's family (ex: `{"charmander", "charmeleon", "charizard", "mega_charizard_x", "mega_charizard_y"}`).
  - If a Pokémon has different that are all defined in a single joker, you can replace the name by a table formatted as `{key = name, form = form_key}` (ex: `{"dunsparce", {key = "dudunsparce", form = 0}, {key = "dudunsparce", form = 1}}`)
  - You can also manually add entries to the `extended_family` table. This table is used by the Pokédex feature (right-clicking on a Pokémon to see its family) to show additionnal Pokémon that aren't directly part of this Pokémon's family but still have something to do with it (ex: `extended_family["tauros"] = {"miltank"}`).

### Create a Berry Juice
Shuckle destroys a consumable and creates a Berry Juice based on the set of the destroyed consumable (Tarot, Planet, Spectral, Item). If your mod creates a new kind of consumable and you want it to be compatible with Shuckle, create a consumable but instead of passing it to `SMODS.Consumable`, pass it to `pokermon.Juice(item, custom_prefix, set)`
* `item`: the consumable
* `custom_prefix`: your mod's prefix
* `set`: the consumable's set

## Pokermon mechanics
### Ancient
A Joker with Ancient [Rank, Suit, Enhancement, Edition...] has an effect based on how many cards matching the Ancient are in the scoring hand.

### Drain
Drain removes sell value from cards. Depending on which card "drains", it might add the sell value to itself. A card with $1 or less of sell value can't be drained.

### Energizing
Energizing a Joker increases its Chips, Mult, XMult and $ values (not sell value!). Unless unlimited energy scaling is on, a Joker can only be energized a certain amount of times, which starts at 3 but can change during a game.

### Evolution
Some Pokémon Jokers can evolve through different conditions, changing the Joker's effect. Common evolutions methods are:
- After X rounds
- By using an item
- By scaling a value
- By having a certain type

Other conditions exists. Except in certain circumstances, an evolution only happens at the end of a round, even if the condition has been fulfilled much earlier.
Some Jokers can change form, which internally is no different than evolving.
#### Stages
A Joker is partially defined by its stage: Baby, Basic, One, Two, Mega or Other (non-Pokermon jokers are treated as "Other" by default). A Stage Two Joker is the evolution of a Stage One which itself is the evolution of a Basic, which itself can be the evolution of a Baby. Mega is a special stage used by Mega Evolutions. Some cards care about a Joker's stage.

#### Baby
A Baby Joker gets debuffed when playing a hand, unless it's the rightmost Joker or it only has Baby Jokers on its right. It also usually comes with XMult < 1, and evolves quickly. A debuffed Joker doesn't progress its rounds, so you need to keep a Baby on the right for it to evolve.

### Foresight card area
Foresight is a new card area displayed above the deck. It shows the cards at the top of the deck. The amount of cards to display is defined in `G.GAME.scry_amount`. The card area itself is `G.scry_view`. You can access its cards, like any other card area, by using `G.scry_view.cards`. Some cards increase its size, and some cards use it for calculation.

### Holding
A Joker with Holding generates the Holding card when it is acquired, if there's room.

### Nature
A Nature is an element or set of elements (rank, suits, types, whatever you want really) randomly picked when the Joker is created, that'll be use to determine the Joker's behavior.

A Nature is stored under `ability.extra.targets`, with each element being a table
  - a Rank nature is defined as `{value = "Ace", id = 14}`
  - a Suit nature is defined as `{suit = Spades}`
  - a Type nature is defined as `{type = Colorless}`
  - You can define yourself other kinds of natures, though they might not be compatible with everything

A Joker with a Nature has a `set_nature(self,card)` function used to calculate its Nature.

### Type
Pokémon Jokers start with a type. Types can be used for different interactions. Through varied methods, it is possible to give a Joker a Type sticker, changing its type or giving it one if it had none.

### Volatile
A Volatile ability is an ability that triggers when the Joker is the leftmost or rightmost one, ignoring other Volatile jokers. A Volatile Joker must have `volatile = true` set.

## Utility functions
### Pokémon Type functions
##### type_sticker_applied(card)
Returns the type of the sticker applied on `card`, or `false` if `card` has no type sticker.

##### apply_type_sticker(card,type)
Applies a sticker of type `type` to `card`, changing its type.

##### find_pokemon_type(type, exclude)
Returns a table of all Jokers matching `type`, excluding `exclude` if given.

##### find_other_poke_or_energy_type(card, poke_type, count_self)
Returns the count of all Jokers and Energies matching `type`, excluding `card` if `count_self` is not `true`.

##### is_type(card, type)
Returns if the `card` is of the `type` or not.

##### get_type(card)
Returns the `card`'s type, or `nil` if it doesn't have any.

### Pokémon Evolution functions
#### Force an evolution now
##### poke_backend_evolve(card, to_key, energize_amount)
Evolves `card` into the Joker of key `to_key` and energizes it by `energize_amount`.

##### poke_evolve(card, to_key, immediate, evolve_message, transformation, energize_amount)
Calls `poke_backend_evolve(card, to_key, energize_amount)`
- `immediate`: if true, doesn't wrap the call in an event
- `evolve_message`: status text displayed on the card after evolving, defaults to `"poke_evolve_success"`
- `transformation`: `true` if this function was called by Transformation, should not be referenced otherwise

#### Conditional evolution
Call these functions at the end of a Joker's `calculate` function.
- `self`, `card` and `context`: the same as the `calculate` function's arguments
- `forced_key`: the key of the Joker to evolve into
##### level_evo(self, card, context, forced_key)
Levels up a `card` that evolves after some rounds. If it reaches the last rounds, evolves it into `forced_key`. `card.ability.extra.rounds` must be defined, and is after how many rounds the Pokémon will evolve.

##### item_evo(self, card, context, forced_key)
The Joker must define `item_req`. Evolves if the item was used. Set `forced_key` to nil if the Joker defines `evo_list` because it has multiple `item_req`.

##### scaling_evo(self, card, context, forced_key, current, target, evo_message)
Evolves if `current` >= `target`. `evo_message` is passed to `poke_evolve`.

##### type_evo(self, card, context, forced_key, type_req)
Evolves if the Joker is of type `type_req`.

##### deck_suit_evo(self, card, context, forced_key, suit, percentage)
Evolves if `percentage` (number between 0 and 1) or more cards in deck are of `suit` suit.

##### deck_enhance_evo(self, card, context, forced_key, enhancement, percentage, flat)
Evolves if `percentage` (number between 0 and 1) or more cards in deck are of `enhancement` enhancement.
If `percentage` is not defined, evolves if `flat` or more cards in deck have the enhancement.

##### deck_seal_evo(self, card, context, forced_key, seal, percentage, flat)
Evolves if `percentage` (number between 0 and 1) or more cards in deck are of `seal` seal.
If `percentage` is not defined, evolves if `flat` or more cards in deck have the seal.

### Pokémon Stage functions
##### poke_add_stage(stage, prev_stage, next_stage)
Add a new custom `stage` to the stages list, set between `prev_stage` and `next_stage`

##### get_previous_stage(stage) and get_next_stage(stage)
Respectively return the stage preceding or following `stage`, or `nil` if the stage doesn't exist or if the previous/next stage doesn't exist.

##### get_lowest_evo(card) and get_highest_evo(card)
Returns the name of the lowest or highest stage of `card`'s family (in the case of highest, a random one if multiple highest exist).

##### get_mega(card)
Returns the name of `card`'s mega. If `card` has 2 mega, returns the first one if it's the leftmost Joker, the second one if it's the rightmost, or a random one. Returns `nil` if `card` doesn't have a mega.

##### get_previous_from_mega(name,prefix,full_key)
Given the `name` of a Mega, and the Joker's mod prefix `prefix`, returns the name of the non-Mega form, or the full key if `full_key = true`

##### get_previous_evo(card,full_key) and get_previous_evo_from_center(center,full_key)
Returns the name of `center`'s pre-evolution, or the full key if `full_key = true`. `get_previous_evo` can be called to use a `card` instead of a center, as it calls `get_previous_evo_from_center(card.config.center,full_key)`.

##### poke_get_family_list(name)
Returns `name`'s family.

##### poke_family_present(center)
`center` as in `card.config.center` for a Joker. Returns if a member of `center`'s family is possessed or not. If the player has Showman or Pokédex, returns `false`. 

### Item functions
##### set_spoon_item(card)
Sets `card` as the item created by Twisted Spoon. Must be called at the start of the `use` function of any non-reusable Item.

##### evo_item_use(self, card, area, copier), highlighted_evo_item(self, card, area, copier) and evo_item_use_total(self, card, area, copier)
- `self, card, area, copier`: the same as the item's `use`'s function arguments
The first one tries to evolve the first Joker it finds from left to right, using the item. The second one tries to evolve the highlighted Joker. The third wraps both, calling `highlighted` if 1 Joker is highlited, and the other one if not.

##### is_evo_item_for(self,card)
Returns if the `self` item can be used to evolve `card`.

##### evo_item_in_pool(self)
Returns if a possessed Joker can evolve using `self`.

### Energy functions
##### is_energizable(card)
Returns if the Joker has energizable values or not. Energizable values are defined in the global `energy_values` table.

##### can_increase_energy(card, etype)
Returns if an energy of type `etype` can energize `card`, without going over the energy limit.

##### energy_matches(card, etype, include_colorless)
Returns if `card`'s type matches `etype`'s type. If `include_colorless = true`, return `true` if `card` has any type and `etype` is `"Colorless"`.

##### can_apply_energy(card, etype)
Wrap for `energy_matches(card, etype, true) and is_energizable(card) and can_increase_energy(card, etype)`: returns if an energy of `etype` can be used on the highlighted Joker, or leftmost compatible Joker, and if it can increase its energy

##### energy_can_use(self,card)
Used by Energy cards in their `can_use` function, returns if the energy can currently be used or not.

##### energy_use(self, card, area, copier, exclude_spoon)
Used by Energy cards in their `use` function. Uses the energy on the highlighted or leftmost compatible Joker. If `exclude_spoon ~= true`, calls `set_spoon_item(card)`.

##### energy_increase(card, etype, amount, silent)
Energize `card` by `amount` if it wouldn't bypass the energy limit. If `amount` is `nil`, sets it to 1. `amount` can be negative. Calls `increment_energy(card, etype, amount, silent)`.

##### increment_energy(card, etype, amount, silent)
Energize `card` by `amount`, regardless of the energy limit. Increases `card`'s energy count. Increases the colorless count instead if `etype = "Colorless"`, `card` isn't Colorless and `G.GAME.modifiers.disable_colorless_penalty` is `false` or `nil` (it's `true` if playing on the Amped Deck with the Amped Sleeve). If `amount` is `nil`, sets it to 1. `amount` can be negative. Calls `energize(card, etype, nil, silent, amount, nil)`

##### energize(card, etype, evolving, silent, amount, center)
Energize `card` by `amount`, regardless of the energy limit. Does not increase the energy count. Increases values by half as much if `etype = "Colorless"`, `card` isn't Colorless and `G.GAME.modifiers.disable_colorless_penalty` is `false` or `nil`. If `amount` is `nil`, sets it to 1. `amount` can be negative. If `silent ~= true`, displays a status text on `card`. If `center` is `nil`, sets it to `card.config.center`.

##### get_total_energy(card, get_counts)
Returns the amount of energies used on `card`. If `get_counts = true`, returns 2 values: the regular energy count and the colorless count.

##### matching_energy(card, allow_bird)
Returns the key of the energy matching `card`'s type. If `card` is Bird-type, `allow_bird` must be `true` to return the Bird energy, otherwise it returns `nil`. Also returns `nil` if `card` has no type.

### Other Pokermon mechanics
##### volatile_active(self,card,direction)
Returns if `card`'s Volatile effect should be active or not. `card` is a Joker.

##### faint_baby_poke(self,card,context)
Debuffs `card` depending on `context` and its position among Jokers, following Baby rules. Does not actually check if `card` is a Baby.

##### poke_drain(card, target, amount, one_way)
Removes $`amount` of sell value from `target`. `card` called this function. If `one_way ~= true`, adds the sell value removed to `card`.

##### fossil_generate_ui
Should be given to the `generate_ui` value of a Joker if this Joker uses the "Ancient" mechanic

##### create_holding_item(key,edition,has_evolved)
If there's room, creates the Item with key `key` and edition `edition` (or `nil`). If `has_evolved = true`, prevents creation.

##### get_ancient_amount(hand,id,card)
Returns the count of cards of id `id` in `hand`. If `card` is given, also sets `card.ability.extra.ancient_count` to the count.

### Pokémon specific functions
##### poke_change_poli_suit()
Cycles `G.GAME.poke_poli_suit` to the next suit, in `"Spades"`, `"Hearts"`, `"Clubs"`, `"Diamonds"` order. Used to determine Poliwag's family's current suit.

##### generate_pickup_item_key(seed)
Returns the key of a random Pickup item, using `seed` for the randomization. Used by Zigzagoon and Linoon.

##### poke_create_treasure(card,seed,megastone)
Creates a treasure using `seed` for randomization. Used by Drilbur and Excadrill. If `megastone = true`, can generate a Mega Stone. 

#### reset_game_globals
The following 3 functions are called by Pokermon's `SMODS.current_mod.reset_game_globals` function
##### poke_rank_reset(name)
Picks a random rank in deck, gives its rank to `G.GAME.current_round[name].rank` and its id to `G.GAME.current_round[name].id`. Used by Bulbasaur's, Sneasel's and Bramblin's families to determine their target rank.

##### reset_espeon_card()
Picks a random target card for Espeon, among cards in the deck.

##### reset_gligar_suit()
Similar to how Ancient Joker works, picks a random suit among `"Spades"`, `"Hearts"`, `"Clubs"`, `"Diamonds"` for Gligar and Gliscor to use. Cannot pick the same suit twice in a row.

### Card selection
##### poke_unhighlight_cards()
Unhighlights all selected cards in hand.

##### pseudorandom_multi(args)
Args: array(table), amt(num), seed(string), add_con(function), mod_func(function)
Returns `amt` random elements from `array` satisfying `add_con`, using `seed` if not `nil`. `mod_func` will be called with each returned element if not `nil`.

### Card flips
Usually used by Items affecting ranks or suits (ex: Fire Stone, Leaf Stone, Prism Scale...). The functions are to be called with `second = true` when flipping the cards back, aka the 2nd time they're called.
##### juice_flip(card, second) and juice_flip_hand(card, second)
Juice the given `card` and respectively flip selected or all cards in hand.

##### juice_flip_table(card, targets, second, limit)
Does the same except flips the `limit` first cards in the `targets` table.

##### juice_flip_single(card, index)
Juices and flips the given `card`. `index` is its index in its area, used to modify the sound played.

### Card creation and destruction
##### poke_add_card(add_card, card, area)
Adds `add_card` to `area`. `card` is the card calling this function. Used by Metal Coat.

##### poke_add_playing_card(t, no_joker_effect)
Calls `SMODS.add_card(t)`, then if `no_joker_effect = true` calculates Jokers with the `{playing_card_added = true, cards = t}` context. Returns the card added.

##### poke_add_shop_card(add_card, card)
Adds `add_card` to shop cards, then calculates status text with `card`.

##### remove(self, card, context, check_shiny)
Destroys `card`. If `check_shiny = true`, reduces the booster pack limit if the card was shiny. `self` and `context` are unused.

##### poke_remove_card(target, card, trigger)
Destroys `target` and juices `card` with `trigger` as the event's trigger. If `trigger = nil`, `after` is used by default.

##### poke_add_hazards(ratio, flat)
If `ratio` is defined, adds an amount of "Hazard" cards in the deck equal to floor((cards that are not Hazard in deck)/`ratio`). Otherwise, adds `flat` "Hazard" cards to the deck.

### Card manipulation
##### poke_vary_rank(card, decrease, seed, immediate)
- `card`: the card to change the rank of
- `decrease`: if `true`, decrease the rank ; if `false`, increases it ; if `nil`, picks any random rank
- `seed`: seed used to randomly pick a rank. If `nil`, a default one is used. Is used even if `decrease ~= nil`, as a rank can have multiple next or previous ranks defined and one of them is picked at random.
- `immediate`: if `true`, applies the new rank immediately. Otherwise, delays it in an event.

##### poke_convert_cards_to(cards, t, noflip, immediate)
- `cards`: the card or a table of cards to convert
- `t`: table of args: `{seal, mod_conv, edition, suit_conv, random, up, down, bonus_chips}`
  - `seal`: seal's key
  - `mod_conv`: enhancement's key
  - `edition`: edition's key
  - `suit_conv`: suit's key
  - `random`, `up` and `down`: +1, -1 or randomly change the rank
  - `bonus_chips`: permanent chips to add to the card
- `noflip`: if `true`, don't flip the card
- `immediate`: if `true`, applies the changes immediately.

##### poke_set_hazards(amount)
Enhance `amount` unenhanced cards in deck to "Hazard".

##### copy_scaled_values(card)
Returns a table of the value of all energizable values of the Joker `card`.

##### poke_total_chips(card)
Returns the total chips of the playing card `card`, including its base value, permanent bonus (such as Hiker buff), and its edition's chips (Foil).

### Finding cards and card identification
##### poke_find_card(key_or_function, use_highlighted)
`key_or_function` is either a Joker's key, or a function taking a Joker card as an argument and returning a boolean.

Finds the first Joker matching `key_or_function`, then returns it (or `nil` if you don't have any). If `use_highlighted = true`, only checks the highlighted Joker.

##### poke_find_leftmost_or_highlighted(key_or_function)
If a Joker is selected, returns it if it matches `key_or_function`. Otherwise, returns the leftmost Joker matching it.

##### poke_get_adjacent_jokers(card)
Returns the Jokers to the left and right of the given one.

##### poke_next_highest_rank(id, rank)
Looks for the next rank above `rank` present in the deck, using "Strength" logic, and returns its `id` and `rank`. If it eventually loops to the given `rank`, it returns it.

##### poke_lowest_rank(id, rank)
Returns the lowest `id` and `rank` in the deck. If the deck has no card with a rank, returns the given `id` and `rank` instead.

##### poke_is_in_collection(card)
Returns `true` if the card currently is in the collection (as in, if the collection is opened and this card is currently on screen)

##### poke_same_suit(table)
Returns if all cards in the table are of the same suit or not.

##### poke_get_rank(card)
Returns the card's rank.

##### poke_is_even(card) and poke_is_odd(card)
Respectively return if the given card is even or odd.

##### poke_suit_check(table, num)
Returns if the table contains `num` or more cards of different suits.

### Randomness
#### Random Joker key
##### get_random_poke_key(pseed, stage, pokerarity, _area, poketype, exclude_keys)
Returns the key of a random Pokémon matching the arguments
- `pseed`: the seed for the randomization
- `stage`: `nil`, a stage or a table of stages
- `pokerarity`: `nil`, a rarity or a table of rarities
- `_area`: unused, set it to `nil`
- `poketype`: `nil` or a type
- `exclude_keys`: `nil` or a set of Joker keys to exclude

##### get_random_poke_key_options(options)
Wrapper for `get_random_poke_key`. The arguments are as follow:
- `pseed`: `options.seed` or `options.pseed` or `options.key_append`
- `stage`: `options.stage` or `options.pokestage`
- `pokerarity`: `options.rarity` or `options.pokerarity`
- `poketype`: `options.type` or `options.poketype`
- `exclude_keys`: `options.exclude_keys`

#### Nature definition
##### get_poke_target_card_ranks(seed, num, default, use_deck)
Returns a table containing `num` card ranks, using `seed` as the randomization seed. If no table can be generated, returns `default` instead. If `use_deck = true`, picks from ranks in the deck.

##### get_poke_target_card_suit(seed, use_deck, default, limit_suits)
Returns a table containing 1 suit, using `seed` as the randomization seed. If no table can be generated, returns `default` instead, or `{suit = "Spades"}` if not defined. If `use_deck = true`, picks from suits in the deck. If `limit_suits` is defined, restricts possible suits to the suits in `limit_suits`.

##### add_target_cards_to_vars(vars,targets)
Adds `targets` to `vars`. Only properly works for Rank natures.

### General utility
##### ease_poke_dollars(card, seed, amt, calc_only)
If `precise_energy` is disabled and `card` has money values, has a probability (displayed on screen) to add up to $3 to the amount, using `seed` for randomization. If `calc_only ~= true`, earns the player the new amount. Returns the new amount. Should be called every time you manipulate money.

##### poke_conversion_event_helper(func, delay, immediate)
Helper function to wrap a function in an event
- `func`: the function to call in the event
- `delay`: the event's delay. Defaults to 0.1
- `immediate`: if `true`, calls `func` right away instead of in an event

##### pokermon.get_dex_number(name)
Returns the dex number of the given Pokémon.

##### poke_convert_to_set(element_or_list)
Returns a set of all the values in the given list, or a set of 1 element. Returns `nil` instead of an empty set if `element_or_list` is nil.

##### poke_draw_one()
Draws 1 card from deck to hand. Functions similarly to `G.FUNCS.draw_from_deck_to_hand`.

##### table.contains(table, element)
Returns if `table` contains `element` or not.

##### table.append(t1, t2)
Adds all elements of `t2` in `t1`. Neither table must be using keys.

## UI functions
I'm not doing it :) have fun looking through uifunctions.lua

## Debug functions
##### poke_debug(message, verbose, depth)
If `verbose = true`, print `message`'s type. If `message` is a string, prints `message`. If it's a table, if `depth = true`, print the table in depth, otherwise prints the table's first layer.

##### tdmsg(table)
If the argument is in fact a table, prints the table's first layer. Otherwise, prints an error message.