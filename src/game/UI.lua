class("UI").extends()

function UI:init()
    self.score = 0

    -- Star background setup
    self.stars = {}
    local numStars = 20
    local screenWidth, screenHeight = 400, 240

    for i = 1, numStars do
        table.insert(self.stars, {
            x = math.random(0, screenWidth),
            y = math.random(0, screenHeight),
            speed = math.random(1, 3),
            length = math.random(1, 3)
        })
    end
end

function UI:drawStars()
    local gfx <const> = playdate.graphics
    gfx.setColor(gfx.kColorWhite)
    for _, star in ipairs(self.stars) do
        gfx.drawLine(star.x, star.y, star.x, star.y - star.length)
    end
end

function UI:draw(player)
    local gfx <const> = playdate.graphics

    -- Draw stars behind everything
    self:drawStars()

    -- draw black background for the header
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 20)
    gfx.setColor(gfx.kColorWhite)

    -- Draw score
    gfx.drawText("SCORE: " .. self.score, 5, 0)
    gfx.drawText("SCORE: " .. self.score, 6, 0)

    -- Draw the players life
    gfx.drawText("LIFE: " .. player.life, 345, 0)
    gfx.drawText("LIFE: " .. player.life, 346, 0)

    gfx.fillRect(0, 20, 400, 2)

    -- Show the current FPS
    -- local pd <const> = playdate
    -- pd.drawFPS(380, 5)
end

function UI:updateStars()
    local screenHeight = 240
    for _, star in ipairs(self.stars) do
        star.y += star.speed
        if star.y > screenHeight then
            star.y = 0
            star.x = math.random(0, 400)
            star.speed = math.random(1, 3)
            star.length = math.random(1, 3)
        end
    end
end

function UI:update()
    self:updateStars()
end
