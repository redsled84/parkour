local levels = {grid={}}

function levels.one()
  -- local width, height = 20, 10
  levels.grid = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  }
end

function levels.loopGrid(f)
  for y = 1, #levels.grid do
    for x = 1, #levels.grid[y] do
      local n = levels.grid[y][x]
      f(y, x, n)
    end
  end
end

function levels.deconstructGrid()
  levels.loopGrid(function(y, x)
    levels.grid[y][x] = 0
  end)
  levels.loopGrid(function(y, x)
    levels.grid[y] = nil
  end)
end

function levels.draw()
  levels.loopGrid(function(y, x, n)
    love.graphics.setColor(255,255,255)
    local fillType = n == 1 and 'fill' or 'line'
    love.graphics.rectangle(fillType, x * tileSize, y * tileSize, tileSize, tileSize)
  end)
end

return levels