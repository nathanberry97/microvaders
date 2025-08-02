import "../game/Player"
import "../game/Laser"
import "../game/EnemyManager"

class("GameManager").extends()

function GameManager:init()
    self.player = Player()
    self.laser = Laser()
    self.enemyManager = EnemyManager()
end

function GameManager:draw()
    local gfx <const> = playdate.graphics
    gfx.clear()

    self.player:draw()
    self.enemyManager:draw()
    self.laser:draw()
end

function GameManager:update()
    self.player:update()
    self.enemyManager:update()
    self.laser:update(self.player, self.enemyManager)
end
