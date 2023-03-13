--[[
  Pong Remake
  -- AI Paddle Class --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]
Class = require 'libs/class'

require 'Paddle'

AIPaddle = Class{}

function AIPaddle:init(side)
  self.paddle = Paddle(side)
end

function AIPaddle:x()
  return self.paddle.x
end

function AIPaddle:y()
  return self.paddle.y
end

function AIPaddle:update(dt, ballY)
  self:setMovingDirection(ballY)
  self.paddle:update(dt)
end

function AIPaddle:setMovingDirection(ballY)
  ballCenter = ballY + (BALL_HEIGHT / 2)
  paddleCenter = self:y() + (PADDLE_HEIGHT / 2)
  if ballY + BALL_HEIGHT > self:y() + PADDLE_HEIGHT then 
    self.paddle:setMovingDirection('down')
  elseif ballY < self:y() then
    self.paddle:setMovingDirection('up')
  else 
    self.paddle:setMovingDirection('none')
  end
end

function AIPaddle:render()
  self.paddle:render()
end


