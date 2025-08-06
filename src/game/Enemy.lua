class("Enemy").extends()

local gfx <const> = playdate.graphics

function Enemy:init(x, y, points)
    self.x, self.y = x, y
    self.width, self.height = 20, 20
    self.right = true
    self.velocity = 2
    self.points = points
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
    self:move(direction)
end
