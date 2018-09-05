local SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()
local g = 500
local jumpSpeed = 165
local pipeWidth = 54
local pipeX 
local pipeSpaceY = 250
local pipeSpaceYmin = 54
local pipeSpaceHeight = 100
local birdWidth = 30
local birdHeight = 25

function resetPipe()
    pipeSpaceY = love.math.random(pipeSpaceYmin, SCREEN_HEIGHT - pipeSpaceHeight - pipeSpaceYmin)
    pipeX = SCREEN_WIDTH
end

function love.load()
    birdY = 200
    birdX = 62
    birdYSpeed = 0
    bottomPipeY = pipeSpaceY + pipeSpaceHeight
    pipeX = SCREEN_WIDTH - pipeWidth 
    resetPipe()
end

function love.update(dt)
    birdYSpeed = birdYSpeed + (g * dt)
    birdY = birdY + birdYSpeed * dt 
    pipeX = pipeX - (60 * dt)
    if (pipeX + pipeWidth) < 0 then
        resetPipe()
    end
    if birdX < (pipeX + pipeWidth) and 
       (birdX + birdWidth) > pipeX and
       (
          birdY < pipeSpaceY or
         (birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)
       )
    then
        love.load()
    end
end

function love.draw()
    love.graphics.setColor(.13, .36, .46)
    love.graphics.rectangle('fill', 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
    love.graphics.setColor(.37, .82, .28)
    love.graphics.rectangle('fill', pipeX , 0, pipeWidth, pipeSpaceY)
    love.graphics.rectangle('fill', pipeX, bottomPipeY, pipeWidth, SCREEN_HEIGHT - bottomPipeY)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if birdY > 0 then
        birdYSpeed = -jumpSpeed
    end

   -- love.load()
end