import "GameManager"

class("Menu").extends()

function Menu:init()
    self.titleX = 145
    self.titleBgX = 135
    self.playX = 165

    self.titleY = 30
    self.titleBgY = 25
    self.playY = 100

    self.titleText = "MICROVADERS"
    self.playText = "Start Ⓐ "
end

function Menu:draw()
    local gfx <const> = playdate.graphics
    local pd <const> = playdate

    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(self.titleBgX, self.titleBgY, 125, 25, 10)

    -- Set text white
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText(self.titleText, self.titleX, self.titleY)
    gfx.drawText(self.titleText, self.titleX + 1, self.titleY)

    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText(self.playText, self.playX, self.playY)
end

function Menu:update()
    local pd <const> = playdate

    if pd.buttonIsPressed(pd.kButtonA) then
        SM:switchScene(GameManager())
    end
end
