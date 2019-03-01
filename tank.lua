local Tank = {}

  function Tank:new()
    local tank = {}
    tank.x = 100
    tank.couloir = 0
    tank.w = 100
    tank.h = 100
    tank.speed = 20
    tank.canon = {}
    tank.canon.img = nil
    tank.canon.w = 100
    tank.canon.h = tank.h/4
    tank.canon.angle = math.rad(0)
    tank.canon.sortie = {x,y}
    function tank:update(dt)
      tank.y = tank.couloir*height/3 + height/6 - tank.h/2
      if (love.keyboard.isDown("q") or love.keyboard.isDown("left")) and tank.x-self.w/2  > 0 then tank.x = tank.x - tank.speed end
      if (love.keyboard.isDown("d") or love.keyboard.isDown("right")) and tank.x+self.w/2 < width then tank.x = tank.x + tank.speed end

    end

    function tank:draw()
      --draw chassis
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle("fill", self.x - self.w/2,   self.y, self.w, self.h)
      --draw canon
      tank.canon.sortie = {x= (self.x + self.w/2) + tank.canon.w*math.cos(tank.canon.angle),
       y= self.y -  tank.canon.w * math.sin(tank.canon.angle)}
      love.graphics.setColor(1, 0, 1)
      local vertices = {(self.x + self.w/2),
                         self.y,

                        (self.x + self.w/2) + tank.canon.w*math.cos(tank.canon.angle),
                         self.y -  tank.canon.w * math.sin(tank.canon.angle),

                        (self.x + self.w/2) + tank.canon.h*math.sin(tank.canon.angle) + tank.canon.w*math.cos(tank.canon.angle),
                         self.y - tank.canon.w*math.sin(tank.canon.angle) + tank.canon.h*math.cos(tank.canon.angle),

                         --let the canon attached to the tank
                        (self.x + self.w/2),
                        self.y + tank.canon.h
                       }
                        --Last point of the rectangle
                        --[[
                        (self.x + self.w/2) + tank.canon.h*math.sin(tank.canon.angle),
                         self.y + tank.canon.h*math.cos(tank.canon.angle)
                       }--]]
      love.graphics.polygon('fill', vertices)

      love.graphics.circle("fill", tank.canon.sortie.x,tank.canon.sortie.y, 10)
      angleMouse()

    end

    function angleMouse()
      local mouseX = love.mouse.getX()
      local mouseY = love.mouse.getY()
      local alpha = math.atan2(height-mouseY  , mouseX)
        love.graphics.line(0, height,mouseX, mouseY)
        tank.canon.angle =alpha
    end

    function tank:keypressed(key, scancode, isrepeat)
      if (key == "z" or key == "up") and tank.couloir > 0 then tank.couloir = tank.couloir - 1 end
      if (key == "s" or key == "down") and tank.couloir < nbCouloir-1 then tank.couloir = tank.couloir + 1 end
    end

    return tank
  end

return Tank
