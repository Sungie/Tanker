local Bullet = require "bullet"

local Spells = {}
function Spells:new()
  local spells = {

    spell1 = {
      key = "1",
      name = "Canon", dammage = 2, cd = 1, size = 1, type = "line",
      handled = false,

      draw = function()
        love.graphics.print(spells.spell1.name .. " preparé", width/2 , 100)
        drawMark("line")
      end,
      update = function() end
    },
    spell2 = {
      key = "2",
      name = "Bombe", dammage = 2, cd = 5, size = 1, type = "parabola",
      handled = false,

      draw = function()
          love.graphics.print(spells.spell2.name .. " preparé", width/2 , 100)
         drawMark(spells.spell2.type)
       end,
      update = function() end
    },
    spell3 = {
      key = "3",
      name = "Air Strike", dammage = 2, cd = 10, size = 1, type = "targeted",
      handled = false,

      draw = function()
        love.graphics.print(spells.spell3.name .. " preparé", width/2 , 100)
        drawMark(spells.spell3.type)
      end,
      update = function() end
    },
    spell = {
      name = "Tir Auto", dammage = 1, cd = 0, size = 1, type = "line",

      draw = function() drawMark("line") end,
      update = function()  end,
    }

  }

  return spells
end
function fire(pSpell)
  if pSpell.type == "line" then
    local balle = Bullet:new(tank.canon.sortie.x,tank.canon.sortie.y,tank.canon.angle)
    table.insert(bullets,balle)
  end
end

function drawMark(pType)
  if pType == "line" then
    love.graphics.setColor(1, 1, 0)
    local distToBound = width - (tank.x+tank.w/2)
     love.graphics.line(tank.x+tank.w/2, tank.y, tank.x+tank.w/2 +distToBound*math.cos(tank.canon.angle), tank.y-distToBound*math.sin(tank.canon.angle))
  end
  if pType == "parabola" then
    love.graphics.setColor(0, 0, 1)
    local distToBound = width - (tank.x+tank.w/2)
    local markW = 100
    local markH = 10
    love.graphics.rectangle("fill", tank.x+tank.w/2 + (distToBound -markW/2)*math.cos(tank.canon.angle), tank.y+tank.h, markW, markH)
  end
  if pType == "targeted" then
    love.graphics.setColor(0, 1, 1)
    local markW = 100
    local markH = height/3
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    love.graphics.rectangle("fill", mouseX, yToCorridor(mouseY)*height/3 , markW, markH)
  end

end

function resetOtherSpellHandled(pSpell)
  for s,spell in pairs(spells) do
    if spell ~=pSpell then
      spell.handled = false
    end
  end
end

return Spells
