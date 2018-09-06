local SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()
local g = 500
local jumpSpeed = 165
local pipeWidth = 54
local pipeSpaceYmin = 54
local pipeSpaceHeight = 100
local birdWidth = 30
local birdHeight = 25

local function newPipeSpaceY()
    pipeSpaceY = love.math.random(pipeSpaceYmin, SCREEN_HEIGHT - pipeSpaceHeight - pipeSpaceYmin)
    return pipeSpaceY
end

local function drawPipe(pipeX, pipeSpaceY)
    love.graphics.setColor(.37, .82, .28)
    love.graphics.rectangle('fill', pipeX , 0, pipeWidth, pipeSpaceY)
    love.graphics.rectangle('fill', pipeX, pipeSpaceY + pipeSpaceHeight, pipeWidth, SCREEN_HEIGHT - pipeSpaceY - pipeSpaceHeight)
end

function love.load()
    birdY = 200
    birdX = 62
    birdYSpeed = 0
    pipe1X = 100
    pipe1SpaceY = newPipeSpaceY()
    pipe2X = 200
    pipe2SpaceY = newPipeSpaceY()
end

function love.update(dt)
    birdYSpeed = birdYSpeed + (g * dt)
    birdY = birdY + birdYSpeed * dt 
    local function movePipe(pipeX, pipeSpaceY)
        pipeX = pipeX - (60 * dt)
        if (pipeX + pipeWidth) < 0 then
            pipeX = SCREEN_WIDTH
            pipeSpaceY = newPipeSpaceY()
        end
        return pipeX, pipeSpaceY
    end
        pipe1X, pipe1SpaceY = movePipe(pipe1X, pipe1SpaceY)
        pipe2X, pipe2SpaceY = movePipe(pipe2X, pipe2SpaceY)

        --[[if birdX < (pipe1X + pipeWidth) and 
        (birdX + birdWidth) > pipe1X and
        (
            birdY < pipe1SpaceY or
            (birdY + birdHeight) > (pipe1SpaceY + pipeSpaceHeight)
        )
        then
            love.load()
        end --]]
end

function love.draw()
    love.graphics.setColor(.13, .36, .46)
    love.graphics.rectangle('fill', 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
    drawPipe(pipe1X, pipe1SpaceY)
    drawPipe(pipe2X, pipe2SpaceY)
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