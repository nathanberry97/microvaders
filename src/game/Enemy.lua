class("Enemy").extends()

local gfx <const> = playdate.graphics

local function checkCollision(a, b)
    return a.laserX < b.x + b.width and
        a.laserX + a.laserWidth > b.x and
        a.laserY < b.y + b.height and
        a.laserY + a.laserHeight > b.y
end

function Enemy:init(x, y, targetY, points, alienPattern)
    self.alienPattern = alienPattern

    self.x, self.y = x, y
    self.width, self.height = 20, 20

    self.right = true
    self.velocity = 3
    self.points = points

    self.targetY = targetY
    self.spawnSpeed = 2
    self.settled = false

    self.laser = false
    self.laserX, self.laserY = nil, nil
    self.laserWidth, self.laserHeight = 5, 10
end

function Enemy:draw()
    local size = 3

    for row = 1, #self.alienPattern do
        local line = self.alienPattern[row]
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

    if self.laser then
        gfx.fillRoundRect(self.laserX, self.laserY, self.laserWidth, self.laserHeight, 2)
    end
end

function Enemy:move(direction)
    if direction then
        self.x += self.velocity
    else
        self.x -= self.velocity
    end

    if self.laserY ~= nil then
        self.laserY += 3
    end
end

function Enemy:shoot()
    if math.random(1, 1250) == 1 then
        self.laser = true
        self.laserX, self.laserY = self.x, self.y
    end
end

function Enemy:resetLaser()
    self.laser = false
    self.laserX, self.laserY = nil, nil
end

function Enemy:update(direction, player)
    if not self.settled then
        self.y += self.spawnSpeed
        if self.y >= self.targetY then
            self.y = self.targetY
            self.settled = true
        end
        return
    end

    self:move(direction)

    if not self.laser then
        self:shoot()
        return
    end

    local hitPlayer = checkCollision(self, player)

    if hitPlayer then
        player.life -= 1
    end

    if self.laserY >= 240 or hitPlayer then
        self:resetLaser()
    end
end
