local SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()
local g = 500
local jumpSpeed = 165
local pipeWidth = 54
local pipeX = SCREEN_WIDTH - pipeWidth
local pipeY = 250
local pipeYmin = 30
local pipeSpace = 100
local pipe2Y 

function love.load()
    birdY = 200
    birdYSpeed = 0
    pipeY = love.math.random(pipeYmin, SCREEN_HEIGHT - pipeSpace - pipeYmin)
    pipe2Y = pipeY + pipeSpace
end

function love.update(dt)
    birdYSpeed = birdYSpeed + (g * dt)
    birdY = birdY + birdYSpeed * dt
end

function love.draw()
    love.graphics.setColor(.13, .36, .46)
    love.graphics.rectangle('fill', 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', 62, birdY, 30, 25)
    love.graphics.setColor(.37, .82, .28)
    love.graphics.rectangle('fill', pipeX , 0, pipeWidth, pipeY)
    love.graphics.rectangle('fill', pipeX, pipe2Y, pipeWidth, SCREEN_HEIGHT-pipe2Y)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if birdY > 0 then
        birdYSpeed = -jumpSpeed
    end

    love.load()
end