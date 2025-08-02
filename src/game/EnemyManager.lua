import "./Enemy"

class('EnemyManager').extends()

function EnemyManager:init()
    self.moveRight = true
    self.enemies = {}
    self:initaliseEnemys()
end

function EnemyManager:initaliseEnemys()
    local screenWidth = 400
    local enemyWidth, enemyHeight = 20, 20
    local hGap, vGap = 10, 10
    local cols, rows = 10, 4

    local totalRowWidth = cols * enemyWidth + (cols - 1) * hGap
    local startX = (screenWidth - totalRowWidth) / 2
    local startY = 20

    for row = 0, rows - 1 do
        local y = startY + row * (enemyHeight + vGap)
        local x = startX
        for _ = 1, cols do
            table.insert(self.enemies, Enemy(x, y))
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
            break
        elseif self.enemies[i].x <= 0 then
            self.moveRight = true
            break
        end
    end
end

function EnemyManager:update()
    self:direction()

    for i = 1, #self.enemies do
        self.enemies[i]:update(self.moveRight)
    end
end
