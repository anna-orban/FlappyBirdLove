local SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()
local g = 500
local jumpSpeed = 165

function love.load()
    birdY = 200
    birdYSpeed = 0
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
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if birdY > 0 then
        birdYSpeed = -jumpSpeed
    end
end