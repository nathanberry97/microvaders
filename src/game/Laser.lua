class("Laser").extends()

local gfx <const> = playdate.graphics
local pd <const> = playdate

function Laser:init()
    self.laserWidth, self.laserHeight = 5, 10
    self.laserX, self.laserY = nil, 205
    self.radius = 1
    self.shootLaser = false
    self.laserSpeed = 6
end

function Laser:draw()
    if self.shootLaser then
        gfx.fillRoundRect(self.laserX, self.laserY, self.laserWidth, self.laserHeight, self.radius)
    end
end

function Laser:move()
    if self.shootLaser then
        self.laserY -= self.laserSpeed
    end
end

function Laser:shoot()
    if pd.buttonJustPressed(pd.kButtonA) then
        self.shootLaser = true
    end
end

function Laser:reset()
    self.laserY = 205
    self.shootLaser = false
end

function Laser:update(player, enemyManager, ui)
    self:shoot()

    if not self.shootLaser then
        self.laserX = (player.x + (player.width / 2 - (self.laserWidth / 2)))
    end

    if self.shootLaser then
        for i, enemy in ipairs(enemyManager.enemies) do
            if UTILS.CheckCollision(self, enemy) then
                self:reset()
                ui.score += enemy.points
                table.remove(enemyManager.enemies, i)
                break
            end
        end

        if self.laserY <= 22 then self:reset() end

        self:move()
    end
end
