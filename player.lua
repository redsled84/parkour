local player = {}

local bw = 36
local bh = 64

function player.initialize()
  player.dir = 'right'
  player.bufferWidth = bw
  player.bufferHeight = bh
  player.buffer = {x=0,y=0}
  player.pos = {x=0,y=0}
  player.vel = {x=0,y=0}
  player.runSpeed = 200
  player.jumpVel = -375
  player.width = 24
  player.height = 36
  player.keys = {
    w=false,
    a=false,
    s=false,
    d=false,
  }
  player.gravity = 550
  player.terminalVelocity = 450
  player.canJump = false

  world:add(player, player.pos.x, player.pos.y, player.width, player.height)
end

function player.updateVelocity(dt)
  local keys = player.keys
  if keys['d'] then
    player.vel.x = player.runSpeed
    player.dir = 'right'
  elseif keys['a'] then
    player.vel.x = -player.runSpeed
    player.dir = 'left'
  else
    player.vel.x = 0
  end
  -- if keys['w'] then
  --   player.vel.y = -player.runSpeed
  --   player.dir = 'up'
  -- elseif keys['s'] then
  --   player.vel.y = player.runSpeed
  --   player.dir = 'down'
  -- else
  --   player.vel.y = 0
  -- end
  if player.vel.y < player.terminalVelocity then
    player.vel.y = player.vel.y + player.gravity * dt
  else
    player.vel.y = player.terminalVelocity
  end
end

function player.updatePosition(dt)
  local futureX = player.pos.x + player.vel.x * dt
  local futureY = player.pos.y + player.vel.y * dt

  local goalX, goalY, cols, len = world:move(player, futureX, futureY)

  local touchedFloor = false
  for i = 1, len do
    local col = cols[i]
    -- if collided with top or bottom side of object
    if col.normal.y == 1 or col.normal.y == -1 then
      -- reset fall velocity
      player.vel.y = 0
    end

    -- if collided with right or left side of object
    if col.normal.x == 1 or col.normal.x == -1 then
      -- wall friction
    end

    -- if collided with top side of object
    if col.normal.y == -1 then
      touchedFloor = true
    end
  end
  player.canJump = touchedFloor

  player.pos.x = goalX
  player.pos.y = goalY

  -- print(player.canJump)
end

function player.draw()
  love.graphics.setColor(255,0,255)
  love.graphics.rectangle('fill', player.pos.x, player.pos.y,
    player.width, player.height)
end

function player.keypressed(key)
  for k, v in pairs(player.keys) do
    if key == k and not v then
      player.keys[k] = true
    end
  end
  if key == 'w' and player.canJump then
    player.vel.y = player.jumpVel
  end
end

function player.keyreleased(key)
  for k, v in pairs(player.keys) do
    if key == k and v then
      player.keys[k] = false
    end
  end
end

return player