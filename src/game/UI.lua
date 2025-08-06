class("UI").extends()

local pd <const> = playdate
local gfx <const> = playdate.graphics

function UI:init()
    self.score = 0
end

function UI:draw()
    -- Draw score
    gfx.drawText("SCORE:", 5, 0)
    gfx.drawText(self.score, 65, 0)

    -- Show the current FPS
    pd.drawFPS(380, 5)
end

function UI:update(points)
    self.score += points
end
