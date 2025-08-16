class("SceneManager").extends()

function SceneManager:init()
    self.currentScene = nil
end

function SceneManager:switchScene(scene)
    self.currentScene = scene
end

function SceneManager:draw()
    if self.currentScene then self.currentScene:draw() end
end

function SceneManager:update()
    if self.currentScene then self.currentScene:update() end
end
