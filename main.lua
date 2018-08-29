function love.draw()
    love.graphics.setColor(.13, .36, .46)
    love.graphics.rectangle('fill', 0, 0, 300, 388)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', 62, birdY, 30, 25)
end

function love.load()
    birdY = 200
    birdYSpeed = 0
end

function love.update(dt)
    birdYSpeed = birdYSpeed + (516 * dt)
    birdY = birdY + (30 * dt)
end

function love.keyPressed(key)
    if birdY > 0 then
        birdYSpeed = -165 
    end
end