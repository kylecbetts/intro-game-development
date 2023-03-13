--[[
  Pong Remake
  -- Player Paddle Class --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]
Class = require 'libs/class'

require 'Paddle'

PlayerPaddle = Class{}

function PlayerPaddle:init(side, upKey, downKey)
  self.paddle = Paddle(side)
  self.upKey = upKey
  self.downKey = downKey
end

function PlayerPaddle:x()
  return self.paddle.x
end

function PlayerPaddle:y()
  return self.paddle.y
end

function PlayerPaddle:update(dt, ballY)
  self:handleKeyControls()
  self.paddle:update(dt)
end

function PlayerPaddle:render()
  self.paddle:render()
end

function PlayerPaddle:handleKeyControls()
  if love.keyboard.isDown(self.upKey) then
    self.paddle:setMovingDirection('up')
  elseif love.keyboard.isDown(self.downKey) then
    self.paddle:setMovingDirection('down')
  else
    self.paddle:setMovingDirection('none')
  end
end