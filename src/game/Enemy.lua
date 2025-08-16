class("Enemy").extends()

local gfx <const> = playdate.graphics

local function checkCollision(a, b)
    return a.laserX < b.x + b.width and
        a.laserX + a.laserWidth > b.x and
        a.laserY < b.y + b.height and
        a.laserY + a.laserHeight > b.y
end

function Enemy:init(x, y, targetY, points)
    self.x, self.y = x, y
    self.width, self.height = 20, 20
    self.right = true
    self.velocity = 2
    self.points = points

    self.targetY = targetY
    self.spawnSpeed = 2
    self.settled = false

    self.laser = false
    self.laserX, self.laserY = nil, nil
    self.laserWidth, self.laserHeight = 10, 10
end

function Enemy:draw()
    gfx.fillRect(self.x, self.y, self.width, self.height)

    if self.laser then
        gfx.fillRect(self.laserX, self.laserY, self.laserWidth, self.laserHeight)
    end
end

function Enemy:move(direction)
    if direction then
        self.x += self.velocity
    else
        self.x -= self.velocity
    end

    if self.laserY ~= nil then
        self.laserY += 2
    end
end

function Enemy:shoot()
    if math.random(1, 1500) == 1 then
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
