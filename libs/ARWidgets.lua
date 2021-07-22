--ARWidgets.lua

Component = require("component")
Computer = require("computer")
Event = require("event")
ARG = require("ARGraphics")
Colors = require("colors")
local ARWidgets = {}

local minimapAlpha = 0.78
 
function ARWidgets.minimapOverlay(glasses)
    --Minimap Borders
    ARG.hudRectangle(glasses, 800, 15, 153, 4, Colors.notBlack) -- top
    ARG.hudRectangle(glasses, 800, 170, 153, 4, Colors.notBlack) -- bottom
    ARG.hudRectangle(glasses, 793, 15, 7, 159, Colors.notBlack)
    ARG.hudRectangle(glasses, 795, 15, 1, 159, Colors.workingColor)
    ARG.hudRectangle(glasses, 952, 15, 4, 159, Colors.notBlack)
    --Coordinate Borders
    ARG.hudTriangle (glasses, {812, 175}, {793, 174}, {812, 193}, Colors.notBlack)
    ARG.hudTriangle (glasses, {812, 174}, {795, 174}, {812, 191}, Colors.workingColor)
    ARG.hudTriangle (glasses, {813, 174}, {796, 174}, {813, 191}, Colors.notBlack) --triangle 
    ARG.hudRectangle(glasses, 812, 186, 150, 4, Colors.notBlack) -- нижняя полоска
    ARG.hudRectangle(glasses, 939, 174, 30, 12, 0, 0.78)
    --Biome Borders
    ARG.hudRectangle(glasses, 812, 190, 45, 1, Colors.workingColor)
    ARG.hudRectangle(glasses, 812, 191, 45, 2, Colors.notBlack)
    ARG.hudTriangle (glasses, {860, 190}, {847, 190}, {860, 203}, Colors.notBlack)
    ARG.hudRectangle(glasses, 860, 199, 95, 4, Colors.notBlack)
    
    --ARG.hudRectangle(glasses, 811, 143, 50, 7, 0x000000, minimapAlpha)
    ----FPS Borders
    --ARG.hudRectangle(glasses, 728, 0, 150, 2, Colors.notBlack)
    --ARG.hudRectangle(glasses, 728, 0, 22, 12, Colors.notBlack)
    --ARG.hudRectangle(glasses, 750, 2, 28, 8, 0x000000, minimapAlpha)
    --ARG.hudTriangle (glasses, {758, 2}, {750, 2}, {750, 10}, Colors.notBlack)
    --ARG.hudRectangle(glasses, 801, 2, 70, 8, 0x000000, minimapAlpha)
    --ARG.hudRectangle(glasses, 851, 10, 5, 123, 0x000000, minimapAlpha)
end

 
function ARWidgets.popupText(glasses, text, x, y, color)
    local text = text .. " "
    local substringLength = 1
    local width = #text * 5
    local steps = math.ceil(#text / substringLength)
    local stepLength = substringLength * 5
    local i = 1
    local background =
        ARG.hudQuad(
        glasses,
        {x - 5, y},
        {x - 5, y + 9},
        {x - 5 + 1, y + 9},
        {x - 5 + 1, y},
        Colors.machineBackground,
        0.5
    )
    local top =
        ARG.hudQuad(glasses, {x - 5, y - 1}, {x - 5, y}, {x - 5 + 1, y}, {x - 5 + 1, y - 1}, Colors.machineBackground)
    local bottom =
        ARG.hudQuad(
        glasses,
        {x - 5, y + 9},
        {x - 5, y + 10},
        {x - 5 + 1, y + 10},
        {x - 5 + 1, y + 9},
        Colors.machineBackground
    )
    local hudText = ARG.hudText(glasses, "", x + 1, y + 1, color)
    local wedge =
        ARG.hudQuad(
        glasses,
        {x - 5 - 10, y - 1},
        {x - 5, y - 1},
        {x - 5, y + 10},
        {x - 5 + 11, y + 10},
        Colors.machineBackground
    )
    local direction = 1
    local function advance()
        background.setVertex(3, math.min(width + 10, x + stepLength * i + 10), y + 9)
        background.setVertex(4, math.min(width, x + stepLength * i), y)
        top.setVertex(3, math.min(width, x + stepLength * i), y)
        top.setVertex(4, math.min(width, x + stepLength * i), y - 1)
        bottom.setVertex(3, math.min(width + 10, x + stepLength * i + 10), y + 10)
        bottom.setVertex(4, math.min(width + 10, x + stepLength * i + 10), y + 9)
        wedge.setVertex(1, math.min(width - 1, x + stepLength * i - 1), y - 1)
        wedge.setVertex(2, math.min(width + 10, x + stepLength * i + 10), y + 10)
        wedge.setVertex(3, math.min(width + 11, x + stepLength * i + 11), y + 10)
        wedge.setVertex(4, math.min(width + 1, x + stepLength * i + 1), y - 1)
        hudText.setText(string.sub(text, 1, substringLength * i))
        i = i + direction
        if i < 0 then
            glasses.removeObject(background.getID())
            glasses.removeObject(top.getID())
            glasses.removeObject(bottom.getID())
            glasses.removeObject(hudText.getID())
            glasses.removeObject(wedge.getID())
        end
    end
    local function retract()
        direction = -1
        Event.timer(0.03, advance, steps + 2)
    end
    Event.timer(0.03, advance, steps)
    return retract
end
 
return ARWidgets