local cell = {cells={}}

function cell.new(x, y, tileSize)
  local c = {x = x, y = y, tileSize = tileSize}
  world:add(c, x, y, tileSize, tileSize)
  cell.cells[#cell.cells+1] = c 
end

function cell.destroy(i)
  world:remove(cell.cells[i])
  table.remove(cell.cells, i)
end

return cell