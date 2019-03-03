local Ennemy = {}

function Ennemy:new()
  local ennemy = {}
  ennemy.w = 100
  ennemy.h = 100
  ennemy.x = width-ennemy.w
  ennemy.couloir = 0
  ennemy.pv = 2
  ennemy.speed = 1
  ennemy.move = false
  local timer = 0

  function ennemy:update(dt)
    ennemy.y = ennemy.couloir*height/3 + height/6 - ennemy.h/2

    if ennemy.pv <= 0 then ennemy:die() end

    timer = timer + dt
    if timer > 3 then
      --ennemy.move = true
    end

    if ennemy.move then
      ennemy.x = ennemy.x - ennemy.speed
    end

  end
  function ennemy:draw()
    love.graphics.setColor(1, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill",(self.x + self.w/2), self.y+self.h/2, 50)
  end

  function ennemy:hit(amount)
    ennemy.pv = ennemy.pv - amount
  end
  function ennemy:die()
    for e,ennemy in pairs(ennemies) do
      if ennemy == self then
       table.remove(ennemies,e)
      end
    end
  end
  return ennemy
end
return Ennemy
