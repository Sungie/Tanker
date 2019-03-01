local Bullet = {}

function Bullet:new()
  local bullet = {}
  bullet.x = 0
  bullet.y = 0
  bullet.vx = 0
  bullet.vy = 0
  bullet.speed = 0

  function bullet:draw()
    love.graphics.circle("fill", self.x, self.y, 10)
  end
end

return Bullet
