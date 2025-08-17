class("Laser").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

local function checkCollision(a, b)
    return a.x < b.x + b.width and
        a.x + a.width > b.x and
        a.y < b.y + b.height and
        a.y + a.height > b.y
end

function Laser:init()
    self.width, self.height = 5, 10
    self.x, self.y = nil, 205
    self.radius = 1
    self.shootLaser = false
    self.laserSpeed = 6
end

function Laser:draw()
    if self.shootLaser then
        gfx.fillRoundRect(self.x, self.y, self.width, self.height, self.radius)
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

function Laser:update(player, enemyManager, ui)
    self:shoot()

    if not self.shootLaser then
        self.x = (player.x + (player.width / 2 - (self.width / 2)))
    end

    if self.shootLaser then
        for i, enemy in ipairs(enemyManager.enemies) do
            if checkCollision(self, enemy) then
                self:reset()
                ui.score += enemy.points
                table.remove(enemyManager.enemies, i)
                break
            end
        end

        if self.y <= 22 then self:reset() end

        self:move()
    end
end
