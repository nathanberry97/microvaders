class("EnemyLaser").extends()

local gfx <const> = playdate.graphics

function EnemyLaser:init()
    self.shootLaser = false
    self.laserX, self.laserY = nil, nil
    self.laserWidth, self.laserHeight = 7.5, 7.5
    self.laserSpeed = 3
    self.laserChance = 1000
end

function EnemyLaser:draw()
    if self.shootLaser then
        gfx.fillRoundRect(self.laserX, self.laserY, self.laserWidth, self.laserHeight, 10)
    end
end

function EnemyLaser:move()
    if self.laserY ~= nil then
        self.laserY += self.laserSpeed
    end
end

function EnemyLaser:shoot(enemy)
    if math.random(1, self.laserChance) == 1 then
        self.shootLaser = true
        self.laserX, self.laserY = enemy.x, enemy.y
    end
end

function EnemyLaser:resetLaser()
    self.shootLaser = false
    self.laserX, self.laserY = nil, nil
end

function EnemyLaser:update(player, enemy)
    self:move()

    if not self.shootLaser then
        self:shoot(enemy)
        return
    end

    local hitPlayer = UTILS.CheckCollision(self, player)

    if hitPlayer then
        player.life -= 1
    end

    if self.laserY >= 240 or hitPlayer then
        self:resetLaser()
    end
end
