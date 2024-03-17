io.stdout:setvbuf("no") -- for console messages

local lander = {}
lander.x = 0
lander.y = 0
lander.angle = -90
lander.speed = 3 -- speed of the ship
lander.vx = 0 -- velocity x
lander.vy = 0 -- velocity y
lander.img = love.graphics.newImage("src/ship.png")
lander.engine = love.graphics.newImage("src/engine.png")

local showEngine = false

function love.load()
    screenW = love.graphics.getWidth()
    screenH = love.graphics.getHeight()

    lander.x = screenW / 2
    lander.y = screenH / 2
end

function love.update(dt)

    -- gravity
    lander.vy = lander.vy + (0.6*dt) -- gravity force | increase velocity y by 0.01 each frame
    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy

    -- keyboard input
    if love.keyboard.isDown("right") then
        lander.angle = lander.angle + (90*dt)
    end
    if love.keyboard.isDown("left") then
        lander.angle = lander.angle - (90*dt)
    end
    if love.keyboard.isDown("up") then
        showEngine = true

        local angle_radians = math.rad(lander.angle)
        local force_x = math.cos(angle_radians) * (lander.speed * dt)
        local force_y = math.sin(angle_radians) * (lander.speed * dt)
        lander.vx = lander.vx + force_x
        lander.vy = lander.vy + force_y

    else 
        showEngine = false
    end

end

function love.draw()

    love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth() / 2, lander.img:getHeight() / 2)
    if showEngine then 
        love.graphics.draw(lander.engine, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.engine:getWidth() / 2, lander.engine:getHeight() / 2)
    end
end