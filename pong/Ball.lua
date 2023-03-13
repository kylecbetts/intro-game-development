--[[
  Pong Remake
  -- Ball Class --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]

Ball = Class{}

BALL_WIDTH = 4
BALL_HEIGHT = 4
HORIZONTAL_MIDDLE = (VIRTUAL_WIDTH / 2) - (BALL_WIDTH / 2)
VERTICAL_MIDDLE = (VIRTUAL_HEIGHT / 2) - (BALL_HEIGHT / 2)

function Ball:init()
  self.x = HORIZONTAL_MIDDLE
  self.y = VERTICAL_MIDDLE
  self.dx = 0
  self.dy = 0
  self:reset('right')
end

function Ball:collidesPaddle(paddle)
  if self.x > paddle:x() + PADDLE_WIDTH or paddle:x() > self.x + BALL_WIDTH then
      return false
  end
  if self.y > paddle:y() + PADDLE_HEIGHT or paddle:y() > self.y + BALL_HEIGHT then
      return false
  end 
  return true
end

function Ball:setX(newX)
  self.x = newX
end

function Ball:getY()
  return self.y
end

function Ball:changeHorizontalDirection()
  self.dx = -self.dx * 1.03
  if self.dy < 0 then
    self.dy = -math.random(10, 150)
  else
    self.dy = math.random(10, 150)
  end
end

function Ball:reset(direction)
  self.x = HORIZONTAL_MIDDLE
  self.y = VERTICAL_MIDDLE
  self.dy = math.random(-50, 50)
  if direction == 'right' then
    self.dx = math.random(140, 200)
  else
    self.dx = -math.random(140, 200)
  end
end

function Ball:update(dt)
  if self:collidesTopEdge() then
    self:handleCollidesTopEdge()
  elseif self:collidesBottomEdge() then
    self:handleCollidesBottomEdge()
  end

  self:updatePosition(dt)
end

function Ball:collidesTopEdge()
  if self.y <= 0 then
    return true
  end
  return false
end

function Ball:handleCollidesTopEdge()
  self.y = 0
  self.dy = -self.dy
  sounds['wall_hit']:play()
end

function Ball:collidesBottomEdge()
  if self.y >= VIRTUAL_HEIGHT - BALL_HEIGHT then
    return true 
  end
  return false
end

function Ball:handleCollidesBottomEdge()
  self.y = VIRTUAL_HEIGHT - BALL_HEIGHT
  self.dy = -self.dy
  sounds['wall_hit']:play()
end

function Ball:updatePosition(dt)
  self.x = self.x + (self.dx * dt)
  self.y = self.y + (self.dy * dt)
end

function Ball:crossedLeftEdge()
  if self.x + BALL_WIDTH < 0 then
    return true
  end
  return false
end

function Ball:crossedRightEdge()
  if self.x > VIRTUAL_WIDTH then
    return true
  end
  return false
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, BALL_WIDTH, BALL_HEIGHT)
end
