import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "SceneManager"
import "scenes/GameManager"

local pd <const> = playdate

local sceneManager = SceneManager()
sceneManager:switchScene(GameManager())

function pd.update()
    sceneManager:update()
    sceneManager:draw()
end
