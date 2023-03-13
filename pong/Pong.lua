--[[
  Pong Remake
  -- Pong Class --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]

Class = require 'libs/class'

require 'PlayerPaddle'
require 'AIPaddle'
require 'Ball'

Pong = Class{}

LEFT_PLAYER_NAME = "Player"
RIGHT_PLAYER_NAME = "AI"
LEFT_SCORE_X = (VIRTUAL_WIDTH / 2) - 50
RIGHT_SCORE_X = (VIRTUAL_WIDTH / 2) + 30
SCORE_Y = VIRTUAL_HEIGHT / 3

GOALS_TO_WIN = 5

function Pong:init()
  self.ball = Ball()
  self.leftPaddle = PlayerPaddle('left', 'w', 's')
  self.rightPaddle = AIPaddle('right')

  self.servingPlayer = 'left'
  self.leftPlayerScore = 0
  self.rightPlayerScore = 0
  self.gameState = 'start'
  self.winningPlayer = 'none'
end

function Pong:handleEnterPressed()
  if self.gameState == 'start' then
    self.gameState = 'serve'
  elseif self.gameState == 'serve' then
    self.gameState = 'play'
  elseif self.gameState == 'done' then
    self.gameState = 'serve'
    self:newGame()
  end
end


function Pong:newGame()
  self.ball:reset(self.winningPlayer)
  self.leftPlayerScore = 0
  self.rightPlayerScore = 0
end


function Pong:update(dt)
  if self.gameState == 'play' then
    if self:ballCollidesLeftPaddle() then
      self:handleBallCollidesLeftPaddle()
    elseif self:ballCollidesRightPaddle() then
      self:handleBallCollidesRightPaddle()
    end

    if self:leftPlayerScores() then
      self:handleLeftPlayerScores()
    elseif self:rightPlayerScores() then
      self:handleRightPlayerScores()
    end
  end

  if self.gameState == 'play' then
    self.ball:update(dt)
  end

  ballY = self.ball:getY()
  self.leftPaddle:update(dt, ballY)
  self.rightPaddle:update(dt, ballY)
end


function Pong:ballCollidesLeftPaddle()
  if self.ball:collidesPaddle(self.leftPaddle) then
    return true
  end
  return false
end


function Pong:handleBallCollidesLeftPaddle()
  self.ball:setX(self.leftPaddle:x() + PADDLE_WIDTH)
  self.ball:changeHorizontalDirection()
  sounds['paddle_hit']:play()
end


function Pong:ballCollidesRightPaddle()
  if self.ball:collidesPaddle(self.rightPaddle) then
    return true
  end
  return false
end


function Pong:handleBallCollidesRightPaddle()
  self.ball:setX(self.rightPaddle:x() - BALL_WIDTH)
  self.ball:changeHorizontalDirection()
  sounds['paddle_hit']:play()
end


function Pong:leftPlayerScores()
  if self.ball:crossedRightEdge() then
    return true
  end
  return false
end

function Pong:handleLeftPlayerScores()
  self.servingPlayer = 'right'
  self.leftPlayerScore = self.leftPlayerScore + 1
  if self.leftPlayerScore == GOALS_TO_WIN then
    self.winningPlayer = 'left'
    self.gameState = 'done'
  else
    self.gameState = 'serve'
    self.ball:reset('left')
  end
  sounds['score']:play()
end


function Pong:rightPlayerScores()
  if self.ball:crossedLeftEdge() then
    return true
  end
  return false
end


function Pong:handleRightPlayerScores()
  self.servingPlayer = 'left'
  self.rightPlayerScore = self.rightPlayerScore + 1
  if self.rightPlayerScore == GOALS_TO_WIN then
    self.winningPlayer = 'right'
    self.gameState = 'done'
  else
    self.gameState = 'serve'
    self.ball:reset('right')
  end
  sounds['score']:play()
end


function Pong:render()
  love.graphics.setColor(255, 255, 255, 255)
  self:displayScore()
  self:printMessages()
  self.ball:render()
  self.leftPaddle:render()
  self.rightPaddle:render()
end


function Pong:displayScore()
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(self.leftPlayerScore), LEFT_SCORE_X, SCORE_Y)
  love.graphics.print(tostring(self.rightPlayerScore), RIGHT_SCORE_X, SCORE_Y)
end


function Pong:printMessages()
  topMessage = ''
  bottomMessage = ''
  if self.gameState == 'start' then
    topMessage = 'Welcome to Pong!'
    bottomMessage = 'Press Enter to begin!'
    love.graphics.setFont(smallTextFont)
  elseif self.gameState == 'serve' then
    topMessage = '' .. getPlayerName(self.servingPlayer) .. "'s serve!"
    bottomMessage = 'Press Enter to serve!'
    love.graphics.setFont(smallTextFont)
  elseif self.gameState == 'done' then
    topMessage = '' .. getPlayerName(self.winningPlayer) .. ' wins!'
    bottomMessage = 'Press Enter to restart!'
    love.graphics.setFont(largeTextFont)
  end
  love.graphics.printf(topMessage, 0, 10, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(smallTextFont)
  love.graphics.printf(bottomMessage, 0, 30, VIRTUAL_WIDTH, 'center')
end

function getPlayerName(side)
  if side == 'left' then
    return LEFT_PLAYER_NAME
  elseif side == 'right' then
    return RIGHT_PLAYER_NAME
  end
end
