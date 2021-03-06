local SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()
local g = 500
local jumpSpeed = 190
local pipeWidth = 54
local pipeSpaceYmin = 35
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

local function isBirdCollidingWithPipe(pipeX, pipeSpaceY)
    return
    birdX < (pipeX + pipeWidth) and 
    (birdX + birdWidth) > pipeX and
    (
        birdY < pipeSpaceY or
        (birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)
    )
end

local function updateScoreAndUpcomingPipe(pipe, pipeX, otherPipe)
    if upcomingPipe == pipe and (birdX > (pipeX + pipeWidth)) then
        score = score + 1
        upcomingPipe = otherPipe
    end
end

function love.load()
    birdY = 200
    birdX = 62
    birdYSpeed = 0
    pipe1X = SCREEN_WIDTH - pipeWidth
    pipe1SpaceY = newPipeSpaceY()
    pipe2X = SCREEN_WIDTH + SCREEN_WIDTH / 2
    pipe2SpaceY = newPipeSpaceY()
    score = 0
    upcomingPipe = 1
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

    if isBirdCollidingWithPipe(pipe1X, pipe1SpaceY)
    or isBirdCollidingWithPipe(pipe2X, pipe2SpaceY)
    or birdY > SCREEN_HEIGHT then
        love.load()
    end

    updateScoreAndUpcomingPipe(1, pipe1X, 2)
    updateScoreAndUpcomingPipe(2, pipe2X, 1)
end

function love.draw()
    love.graphics.setColor(.13, .36, .46)
    love.graphics.rectangle('fill', 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
    drawPipe(pipe1X, pipe1SpaceY)
    drawPipe(pipe2X, pipe2SpaceY)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(score, 15, 15)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if birdY > 0 then
        birdYSpeed = -jumpSpeed
    end
end