-- Stolen from the Partner mod
-- though tbh most if not all of this is just taken from Card_Character

function Card:add_speech_bubble(text_key, align, loc_vars, quip_args)
    if quip_args and quip_args.text_key then text_key = quip_args.text_key end
    if self.children.speech_bubble then self.children.speech_bubble:remove() end
    self.config.speech_bubble_align = {align=align or 'bm', offset = {x=0,y=0},parent = self}
    self.children.speech_bubble = 
    UIBox{
        definition = G.UIDEF.speech_bubble(text_key, loc_vars),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{
        role_type = 'Minor',
        xy_bond = 'Weak',
        r_bond = 'Strong',
        major = self,
    }
    self.children.speech_bubble.states.visible = false
end

function Card:say_stuff(n, not_first)
    if self.speech_bubble_continued then return end
    if not not_first then 
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
            if self.children.speech_bubble then self.children.speech_bubble.states.visible = true end
            self:say_stuff(n, true)
        return true end}))
    else
        if n <= 0 then return end
        play_sound("voice"..math.random(1, 11), G.SPEEDFACTOR*(math.random()*0.2+1), 0.5)
        self:juice_up()
        G.E_MANAGER:add_event(Event({trigger = "after", blockable = false, blocking = false, delay = 0.13, func = function()
            self:say_stuff(n-1, true)
        return true end}))
    end
end

function Card:remove_speech_bubble(manual)
  if self.speech_bubble_removed then self.speech_bubble_removed = nil return end
  if self.children.speech_bubble then self.children.speech_bubble:remove(); self.children.speech_bubble = nil; self.speech_bubble_continued = nil end
  if manual then self.speech_bubble_removed = true end
end

--[[local Card_draw_ref = Card.draw
function Card:draw(layer)
  Card_draw_ref(self, layer)
  if self.children.speech_bubble then
    self.children.speech_bubble:draw()
  end
end]]

SMODS.DrawStep({
  key = "card_speech_bubble",
  order = -1001,
  layers = { card = true, both = true },
  func = function(self)
    if self.children.speech_bubble then
      self.children.speech_bubble:draw()
    end
  end
})

local Card_move_ref = Card.move
function Card:move(dt)
    Card_move_ref(self, dt)
    if self.children.speech_bubble then
        local align = nil
        if self.T.x+self.T.w/2 > G.ROOM.T.w/2 then align = "cl" end
        self.children.speech_bubble:set_alignment({type = align or "cr", offset = {x=align and -0.1 or 0.1,y=0}, parent = self})
    end
end

function Card:speak(key,voice_amount,duration)
  self:add_speech_bubble(key,nil,{quip = true})
  self:say_stuff(voice_amount)
  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = duration or 1,
    blockable = false,
    blocking = false,
    func = function()
      self:remove_speech_bubble()
      return true
    end
  }))
end