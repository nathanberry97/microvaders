import "./Enemy"

class('EnemyManager').extends()

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
        local y = startY + row * (enemyHeight + vGap)
        local x = startX

        -- Points which enemies will give once killed
        local points
        if row == 0 then
            points = 30
        elseif row == 1 then
            points = 20
        else
            points = 10
        end

        for _ = 1, cols do
            table.insert(self.enemies, Enemy(x, y, points))
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
        if self.enemies[i].x >= 380 then
            self.moveRight = false
            return true
        elseif self.enemies[i].x <= 0 then
            self.moveRight = true
            return true
        end
    end
    return false
end

function EnemyManager:update()
    local hitwall = self:direction()

    for i = 1, #self.enemies do
        local enemy = self.enemies[i]
        enemy:update(self.moveRight)

        if hitwall then
            enemy.y += 2
        end
    end

    if #self.enemies == 0 then self:initaliseEnemies() end
end
