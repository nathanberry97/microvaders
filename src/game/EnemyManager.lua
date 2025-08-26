import "./Enemy"

class('EnemyManager').extends()

ALIENS = import "../art/aliens"

function EnemyManager:init()
    self.moveRight = true
    self.enemies = {}
    self:initaliseEnemies()
end

function EnemyManager:initaliseEnemies()
    local screenWidth = 400
    local enemyWidth, enemyHeight = 20, 20
    local hGap, vGap = 10, 10
    local cols, rows = 10, 4

    local totalRowWidth = cols * enemyWidth + (cols - 1) * hGap
    local startX = (screenWidth - totalRowWidth) / 2
    local startY = 30

    for row = 0, rows - 1 do
        local targetY = startY + row * (enemyHeight + vGap)
        local spawnY = targetY - 150

        local points, pattern
        if row == 0 then
            points = 30
            pattern = ALIENS.squidFrames
        elseif row == 1 then
            points = 20
            pattern = ALIENS.crabFrames
        else
            points = 10
            pattern = ALIENS.octopusFrames
        end

        local x = startX
        for _ = 1, cols do
            table.insert(self.enemies, Enemy(x, spawnY, targetY, points, pattern))
            x += enemyWidth + hGap
        end
    end
end

function EnemyManager:draw()
    for i = 1, #self.enemies do
        self.enemies[i]:draw()
    end
end

function EnemyManager:direction()
    for i = 1, #self.enemies do
        if self.enemies[i].settled then
            if self.enemies[i].x >= 380 then
                self.moveRight = false
                return true
            elseif self.enemies[i].x <= 0 then
                self.moveRight = true
                return true
            end
        end
    end
    return false
end

function EnemyManager:update(player)
    local hitwall = self:direction()

    for _, enemy in ipairs(self.enemies) do
        enemy:update(self.moveRight, player)

        if hitwall and enemy.settled then
            enemy.y += 2
        end
    end

    if #self.enemies == 0 then self:initaliseEnemies() end
end
