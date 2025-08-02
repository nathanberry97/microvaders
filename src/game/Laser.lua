class("Laser").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

local function checkCollision(a, b)
    return a.x < b.x + b.width and
        a.x + b.width > b.x and
        a.y < b.y + b.height and
        a.y + a.height > b.y
end

function Laser:init()
    self.width, self.height = 10, 10
    self.x, self.y = nil, 205
    self.shootLaser = false
    self.laserSpeed = 5
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
    self.y = 205
    self.shootLaser = false
end

function Laser:update(player, enemyManager)
    if not self.shootLaser then
        self.x = (player.x + (player.width / 2 - (self.width / 2)))
    end

    for i, enemy in ipairs(enemyManager.enemies) do
        if self.y <= 0 or checkCollision(self, enemy) then
            self:reset()
            table.remove(enemyManager.enemies, i)
            break
        end
    end

    self:shoot()
    self:move()
end
