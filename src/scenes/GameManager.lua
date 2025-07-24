import "../game/Player"

class("GameManager").extends()

function GameManager:init()
    self.player = Player()
end

function GameManager:update()
    self.player:update()
end

function GameManager:draw()
    self.player:draw()
end
