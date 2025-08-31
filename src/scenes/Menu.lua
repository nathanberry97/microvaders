import "GameManager"

class("Menu").extends()

function Menu:init()
    local gfx <const> = playdate.graphics

    self.titleText = "MICROVADERS"
    self.playText = "Press Ⓐ to start"

    local screenW, screenH = 400, 240
    local titleW, titleH = gfx.getTextSize(self.titleText)
    local playW, playH = gfx.getTextSize(self.playText)

    self.titleX = (screenW - titleW) / 2
    self.playX = (screenW - playW) / 2

    self.titleY = 50
    self.playY = 120

    self.titleBgX = self.titleX - 10
    self.titleBgY = self.titleY - 6
    self.titleBgW = titleW + 20
    self.titleBgH = titleH + 10
end

function Menu:draw()
    local gfx <const> = playdate.graphics

    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    -- title background
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(self.titleBgX, self.titleBgY, self.titleBgW, self.titleBgH, 10)

    -- title text
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText(self.titleText, self.titleX, self.titleY)
    gfx.drawText(self.titleText, self.titleX + 1, self.titleY)

    -- play text
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText(self.playText, self.playX, self.playY)
end

function Menu:update()
    local pd <const> = playdate

    if pd.buttonIsPressed(pd.kButtonA) then
        SM:switchScene(GameManager())
    end
end
