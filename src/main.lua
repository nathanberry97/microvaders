import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "scenes/Menu"
import "SceneManager"

local pd <const> = playdate

SM = SceneManager()
SM:switchScene(Menu())

function pd.update()
    SM:update()
    SM:draw()
end
