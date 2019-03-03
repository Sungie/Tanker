local Bullet = {}

function Bullet:new(x,y ,angle,dammage)
  local bullet = {}
  bullet.type = type
  bullet.x = x
  bullet.y = y
  bullet.vx = 10
  bullet.vy = 10
  bullet.angle = angle
  bullet.speed = 2
  bullet.size = 10
  bullet.dammage = dammage
  function bullet:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", self.x, self.y, self.size)
  end
  function bullet:update(dt)

     bullet.x = bullet.x + bullet.vx*math.cos(bullet.angle) *bullet.speed
     bullet.y = bullet.y - bullet.vy*math.sin(bullet.angle) *bullet.speed

 end
  function bullet:touch(entity)
    if math.sqrt((math.pow((bullet.x - (entity.x + entity.w/2)), 2)) + (math.pow((bullet.y - (entity.y+entity.h/2) ), 2))) < entity.w + self.size then
      return true
    end
    return false
  end
  function bullet:removeBullet()
    for b,lBullet in pairs(bullets) do
      if lBullet == self then
       table.remove(bullets,b)
      end
    end
  end

  return bullet
end


return Bullet
