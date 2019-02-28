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
    tank.canon.angle = 0

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
      angleMouse()
      drawMark()
    end

    function angleMouse()
      local mouseX = love.mouse.getX()
      local mouseY = love.mouse.getY()
      local alpha = math.atan2(mouseY-tank.y , mouseX- (tank.x + tank.w/2))
      if mouseX > tank.x + tank.w/2 and mouseX < width and alpha <= 0 and alpha >= -math.pi/2
       then
        love.graphics.line(tank.x+tank.w/2, tank.y,mouseX, mouseY)
        print(alpha)
        tank.canon.angle = -alpha

      end
    end
    function drawMark()
      love.graphics.setColor(0, 0, 1)
      local distToBound = width - (tank.x+tank.w/2)
      local markW = 100
      local markH = 10
      print(distToBound)
      love.graphics.rectangle("fill", tank.x+tank.w/2 + (distToBound -markW)*math.cos(tank.canon.angle), tank.y+tank.h, markW, markH)
    end

    function tank:keypressed(key, scancode, isrepeat)
      if (key == "z" or key == "up") and tank.couloir > 0 then tank.couloir = tank.couloir - 1 end
      if (key == "s" or key == "down") and tank.couloir < nbCouloir-1 then tank.couloir = tank.couloir + 1 end
    end

    return tank
  end

return Tank
