class("UI").extends()

function UI:init()
    self.score = 0
end

function UI:draw(player)
    local gfx <const> = playdate.graphics

    -- Draw score
    gfx.drawText("SCORE:", 5, 0)
    gfx.drawText(self.score, 65, 0)

    -- Draw the players life
    gfx.drawText("LIFE: " .. player.life, 345, 0)

    -- Show the current FPS
    -- local pd <const> = playdate
    -- pd.drawFPS(380, 5)
end

function UI:update(points)
    self.score += points
end
