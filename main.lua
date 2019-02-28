function love.load(arg)
  print("Hello World")
end

function love.draw()

end

function love.update(dt)

end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then love.event.quit() end
end
