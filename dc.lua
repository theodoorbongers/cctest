local INSTRUMENTS = { "basedrum", "hat", "snare", "cow_bell" }
local LANE_HEIGHT = 3
local LANE_SPACING = 1
local TOTAL_LANE_HEIGHT = #INSTRUMENTS * (LANE_HEIGHT + LANE_SPACING) - LANE_SPACING
local LEFT_MARGIN = 2
local BEAT_SPACING = 1
local BEAT_WIDTH = 4
local LANE_HEADING_WIDTH = 20
local TOTAL_BEATS = 16

local monitor = peripheral.find("monitor")
local monitorWidth, monitorHeight = monitor.getSize()

local topMargin = (monitorHeight - TOTAL_LANE_HEIGHT) / 2

local buttons = {}
for instrumentIndex, instrumentName in ipairs(INSTRUMENTS) do
  local y = topMargin + instrumentIndex * LANE_HEIGHT + (instrumentIndex - 1) * LANE_SPACING
  table.insert(buttons, {
    x = LEFT_MARGIN,
    y = y,
    width = LANE_HEADING_WIDTH,
    height = LANE_HEIGHT,
    paddingTop = (LANE_HEIGHT - 1) / 2,
    paddingLeft = 1,
    backgroundColor = 1,
    text = instrumentName,
  })
end

function clearSquare(x, y, width, height)
  for currentY = y, y+height - 1
  do
    window.setCursorPos(x, currentY)
    window.write(string.rep(" ", width))
  end
end

function drawGrid()
  for button in ipairs(buttons) do
    window.setBackgroundColor(button.backgroundColor)
    clearSquare(button.x, button.y, width, height)
    window.setCursorPos(button.x + paddingLeft, button.y + paddingTop)
    window.write(button.text)
  end
end

monitor.clear()
drawGrid()
