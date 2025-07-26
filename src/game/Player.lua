class("Player").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

function Player:init()
    self.x, self.y = 175, 215
    self.width, self.height = 50, 10
end

function Player:draw()
    gfx.fillRect(self.x, self.y, self.width, self.height)
end

function Player:move()
    if pd.buttonIsPressed(pd.kButtonLeft) and self.x >= 0 then
        self.x -= 4
    elseif pd.buttonIsPressed(pd.kButtonRight) and self.x <= 400 - self.width then
        self.x += 4
    end
end

function Player:update()
    self:move()
end
