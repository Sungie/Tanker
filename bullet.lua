local Bullet = {}

function Bullet:new(x,y ,angle)
  local bullet = {}
  bullet.x = x
  bullet.y = y
  bullet.vx = 5
  bullet.vy = 10
  bullet.angle = angle
  bullet.speed = 2

  function bullet:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", self.x, self.y, 10)
  end
  function bullet:update(dt)
    bullet.x = bullet.x + bullet.vx*math.cos(bullet.angle) *bullet.speed
    bullet.y = bullet.y - bullet.vy*math.sin(bullet.angle) *bullet.speed
  end
  return bullet
end


return Bullet
