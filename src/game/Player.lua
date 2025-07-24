class("Player").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

function Player:init()
    self.x = 175
    self.y = 215
    self.playerWidth = 50
    self.playerDepth = 10
end

function Player:draw()
    gfx.fillRect(self.x, self.y, self.playerWidth, self.playerDepth)
end

function Player:move()
    if pd.buttonIsPressed(pd.kButtonLeft) and self.x >= 0 then
        self.x -= 4
    elseif pd.buttonIsPressed(pd.kButtonRight) and self.x <= 400 - self.playerWidth then
        self.x += 4
    end
end

function Player:update()
    gfx.clear()
    self:move()
end
