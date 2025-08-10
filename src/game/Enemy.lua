class("Enemy").extends()

local gfx <const> = playdate.graphics

function Enemy:init(x, y, targetY, points)
    self.x, self.y = x, y
    self.width, self.height = 20, 20
    self.right = true
    self.velocity = 2
    self.points = points

    self.targetY = targetY
    self.spawnSpeed = 2
    self.settled = false
end

function Enemy:draw()
    gfx.fillRect(self.x, self.y, self.width, self.height)
end

function Enemy:move(direction)
    if direction then
        self.x += self.velocity
    else
        self.x -= self.velocity
    end
end

function Enemy:update(direction)
    if not self.settled then
        self.y += self.spawnSpeed
        if self.y >= self.targetY then
            self.y = self.targetY
            self.settled = true
        end
        return
    end

    self:move(direction)
end
