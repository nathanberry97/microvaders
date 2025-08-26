import "./EnemyLaser"

class("Enemy").extends()

local gfx <const> = playdate.graphics

function Enemy:init(x, y, targetY, points, alienPattern)
    self.frames = alienPattern
    self.currentFrame = 1
    self.animationTimer = 0

    self.x, self.y = x, y
    self.width, self.height = 20, 20

    self.right = true
    self.velocity = 3
    self.points = points

    self.targetY = targetY
    self.spawnSpeed = 2
    self.settled = false

    self.laser = EnemyLaser()
end

function Enemy:draw()
    local size = 3
    local pattern = self.frames[self.currentFrame]

    for row = 1, #pattern do
        local line = pattern[row]
        for col = 1, #line do
            if string.sub(line, col, col) == "X" then
                gfx.fillRect(
                    self.x + (col - 1) * size,
                    self.y + (row - 1) * size,
                    size, size
                )
            end
        end
    end

    self.laser:draw()
end

function Enemy:move(direction)
    if direction then
        self.x += self.velocity
    else
        self.x -= self.velocity
    end
end

function Enemy:update(direction, player)
    self.animationTimer += 1
    if self.animationTimer % 10 == 0 then
        self.currentFrame = (self.currentFrame % #self.frames) + 1
    end

    if not self.settled then
        self.y += self.spawnSpeed
        if self.y >= self.targetY then
            self.y = self.targetY
            self.settled = true
        end
        return
    end

    self:move(direction)
    self.laser:update(player, self)
end
