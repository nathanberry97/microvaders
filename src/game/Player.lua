class("Player").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

function Player:init()
    self.x, self.y = 175, 215
    self.width, self.height = 50, 10

    self.topX, self.topY = self.x + 15, self.y - 8
    self.topWidth = self.width - 30

    self.radius = 2
    self.life = 3

    self.shooting = false
    self.targetTopY = nil
end

function Player:draw()
    gfx.fillRoundRect(self.x, self.y, self.width, self.height, self.radius)
    gfx.fillRoundRect(self.topX, self.topY, self.topWidth, self.height, self.radius)

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(self.topX, self.topY, self.topWidth, self.height, self.radius)
    gfx.setColor(gfx.kColorWhite)
end

function Player:move()
    if pd.buttonIsPressed(pd.kButtonLeft) and self.x >= 0 then
        self.x -= 4
        self.topX -= 4
    elseif pd.buttonIsPressed(pd.kButtonRight) and self.x <= 400 - self.width then
        self.x += 4
        self.topX += 4
    end
end

function Player:shootAnimation(laserShooting)
    if pd.buttonJustPressed(pd.kButtonA) and not self.shooting and not laserShooting then
        self.shooting = true
        self.targetTopY = self.topY + 3
    elseif pd.buttonJustReleased(pd.kButtonA) and self.shooting then
        self.shooting = false
        self.targetTopY = self.topY - 3
    end

    if self.targetTopY then
        if self.shooting and self.topY < self.targetTopY then
            self.topY += 1
        elseif not self.shooting and self.topY > self.targetTopY then
            self.topY -= 1
        end
    end
end

function Player:update(laserShooting)
    self:move()
    -- self:shootAnimation(laserShooting)
end
