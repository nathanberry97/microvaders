import "../game/Player"
import "../game/Laser"
import "../game/EnemyManager"
import "../game/UI"

class("GameManager").extends()

UTILS = import '../game/utils'

function GameManager:init()
    self.player = Player()
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
    self.ui:draw(self.player)
end

function GameManager:update()
    self.player:update(self.enemyManager, self.ui)
    self.enemyManager:update(self.player)
    self.ui:update()

    for _, enemy in ipairs(self.enemyManager.enemies) do
        if enemy.y >= 200 then SM:switchScene(Menu()) end
    end

    if self.player.life < 0 then
        SM:switchScene(Menu())
    end
end
