import "../game/Player"
import "../game/Laser"

class("GameManager").extends()

function GameManager:init()
    self.player = Player()
    self.laser = Laser()
end

function GameManager:draw()
    local gfx <const> = playdate.graphics
    gfx.clear()

    self.player:draw()
    self.laser:draw()
end

function GameManager:update()
    self.player:update()
    self.laser:update(self.player.x, self.player.width)
end
