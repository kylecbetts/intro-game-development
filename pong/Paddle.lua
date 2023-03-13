--[[
  Pong Remake
  -- Paddle Class --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20

PADDLE_SPEED = 200
GOAL_PADDING = 10

START_VERTICAL_PADDING = 30
START_HORIZONTAL_PADDING = 10

Paddle = Class{}

function Paddle:init(side)
  self.y = (VIRTUAL_HEIGHT / 2) - (PADDLE_HEIGHT / 2)
  if side == 'left' then
    self.x = GOAL_PADDING
  elseif side == 'right' then
    self.x = VIRTUAL_WIDTH - GOAL_PADDING - PADDLE_WIDTH
  end
  self.dy = 0
end

function Paddle:update(dt)
  nextPosition = self.y + (self.dy * dt)
  if self.dy < 0 then
    self.y = math.max(0, nextPosition)
  else
    self.y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, nextPosition)
  end
end

function Paddle:setMovingDirection(direction)
  if direction == 'up' then
    self.dy = -PADDLE_SPEED
  elseif direction == 'down' then
    self.dy = PADDLE_SPEED
  elseif direction == 'none' then
    self.dy = 0
  end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end