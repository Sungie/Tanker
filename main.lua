local Tank = require "tank"
local Spells = require "spells"
local Bullet = require "bullet"

function love.load(arg)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  nbCouloir = 3

  tank = Tank:new()
  spells = Spells:new()

  spellSelected = nil
end

function love.draw()
  for i=0, 2 do
    love.graphics.setColor(0,i/4,0)
    love.graphics.rectangle("fill", 0, i*height/nbCouloir, width, height)
  end

  tank:draw()
  for s,spell in pairs(spells) do
    if spell.handled then
      spell.draw()
    end
  end

end

function love.update(dt)
  tank:update(dt)
  for s,spell in pairs(spells) do
    spell.update()
  end
end
function isInCorridor(pY,corrID)
  local ymin = corrID*height/nbCouloir
  local ymax = (corrID+1) * height/nbCouloir
  --print(pY,ymin,ymax,corrID)
  if pY >= ymin and pY <= ymax then  return true end
  return false
end

function yToCorridor(pY)
  for i = 0, nbCouloir-1 do
    local ymin = i*height/nbCouloir
    local ymax = (i+1) * height/nbCouloir
    if pY >= ymin and pY < ymax then return i end
  end
  return -1
end
function  love.mousepressed(x, y, button, isTouch)
  for s,spell in pairs(spells) do
    if spell.handled and button == 1 then
      print("FIRE: ".. spell.name.." launched")
      spell.handled = false
    end
  end
end
function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then love.event.quit() end
  tank:keypressed(key, scancode, isrepeat)
  for s,spell in pairs(spells) do
      if key == spell.key  then
        resetOtherSpellHandled(spell)
        spell.handled = not spell.handled
      end

  end
end
