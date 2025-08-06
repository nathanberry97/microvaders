import "../game/Player"
import "../game/Laser"
import "../game/EnemyManager"
import "../game/UI"

class("GameManager").extends()

function GameManager:init()
    self.player = Player()
    self.laser = Laser()
    self.enemyManager = EnemyManager()
    self.ui = UI()
end

function GameManager:draw()
    local gfx <const> = playdate.graphics
    gfx.clear()

    -- Set the background black
    gfx.setBackgroundColor(gfx.kColorBlack)

    -- Set text and rects to white
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.setColor(gfx.kColorWhite)

    self.player:draw()
    self.enemyManager:draw()
    self.laser:draw()
    self.ui:draw()
end

function GameManager:update()
    self.player:update()
    self.enemyManager:update()
    self.laser:update(self.player, self.enemyManager, self.ui)
end
