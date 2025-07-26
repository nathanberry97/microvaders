class("Laser").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

function Laser:init()
    self.width, self.height = 10, 10
    self.x, self.y = nil, 205
    self.shootLaser = false
    self.laserSpeed = 3
end

function Laser:draw()
    if self.shootLaser then
        gfx.fillRect(self.x, self.y, self.width, self.height)
    end
end

function Laser:move()
    if self.shootLaser then
        self.y -= self.laserSpeed
    end
end

function Laser:shoot()
    if pd.buttonJustPressed(pd.kButtonA) then
        self.shootLaser = true
    end
end

function Laser:reset()
    if self.y <= 0 then
        self.y = 205
        self.shootLaser = false
    end
end

function Laser:update(x, playerWidth)
    if not self.shootLaser then
        self.x = (x + (playerWidth / 2 - (self.width / 2)))
    end

    self:shoot()
    self:move()
    self:reset()
end
