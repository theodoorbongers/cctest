local INSTRUMENTS = { "basedrum", "hat", "snare", "cow_bell" }
local LANE_HEIGHT = 3
local LANE_SPACING = 1
local TOTAL_LANE_HEIGHT = #INSTRUMENTS * (LANE_HEIGHT + LANE_SPACING) - LANE_SPACING
local LEFT_MARGIN = 2
local BEAT_SPACING = 1
local BEAT_WIDTH = 4
local LANE_HEADING_WIDTH = 12
local TOTAL_BEATS = 16

local monitor = peripheral.find("monitor")
local monitorWidth, monitorHeight = monitor.getSize()

local topMargin = math.floor((monitorHeight - TOTAL_LANE_HEIGHT) / 2)

local buttons = {}
for instrumentIndex, instrumentName in ipairs(INSTRUMENTS) do
  local y = topMargin + (instrumentIndex - 1) * (LANE_HEIGHT + LANE_SPACING) - LANE_SPACING
  table.insert(buttons, {
    x = LEFT_MARGIN,
    y = y,
    width = LANE_HEADING_WIDTH,
    height = LANE_HEIGHT,
    paddingTop = (LANE_HEIGHT - 1) / 2,
    paddingLeft = 1,
    backgroundColor = colors.gray,
    text = instrumentName,
  })
end

function clearSquare(x, y, width, height)
  for currentY = y, y + height - 1
  do
    monitor.setCursorPos(x, currentY)
    monitor.write(string.rep(" ", width))
  end
end

function drawGrid()
  for i,button in ipairs(buttons) do
    monitor.setBackgroundColor(button.backgroundColor)
    clearSquare(button.x, button.y, button.width, button.height)
    monitor.setCursorPos(button.x + button.paddingLeft, button.y + button.paddingTop)
    monitor.write(button.text)
  end
end

monitor.setBackgroundColor(colors.black)
monitor.clear()
drawGrid()
print(TOTAL_LANE_HEIGHT, monitorHeight, buttons[#buttons].y, buttons[#buttons].height)