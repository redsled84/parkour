local bump = require 'bump'
world = bump.newWorld()

tileSize = 32
local cell = require 'cell'
local levels = require 'levels'
local player = require 'player'

function love.load()
  levels.one()
	player.initialize()
  levels.loopGrid(function(y, x, n)
    if n == 1 then
      local worldY, worldX = y * tileSize, x * tileSize
      cell.new(worldX, worldY, tileSize)
    end
  end)
end

function love.update(dt)
	player.updateVelocity(dt)
	player.updatePosition(dt)
end

function love.draw()
  levels.draw()
  player.draw()
end

function love.keypressed(key)
  player.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyreleased(key)
	player.keyreleased(key)
end