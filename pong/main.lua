--[[
  Pong Remake
  -- Main Program --

  Author: Kyle Betts
  kyle.c.betts@gmail.com
]]
push = require 'libs/push'
Class = require 'libs/class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

require 'Pong'

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Pong')

  math.randomseed(os.time())

  smallTextFont = love.graphics.newFont('fonts/retro.ttf', 8)
  largeTextFont = love.graphics.newFont('fonts/retro.ttf', 16)
  scoreFont = love.graphics.newFont('fonts/retro.ttf', 32)

  sounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
  }

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })

  pong = Pong()
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  pong:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    pong:handleEnterPressed()
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  displayFPS()
  pong:render()

  push:apply('end')
end

function displayFPS()
  love.graphics.setFont(smallTextFont)
  love.graphics.setColor(0, 255/255, 0, 255/255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end