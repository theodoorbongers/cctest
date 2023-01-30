local INSTRUMENTS =
{
  {
    name = "basedrum",
    displayName = "Bass drum"
  },
  {
    name = "hat",
    displayName = "Hihat"
  },
  {
    name = "snare",
    displayName = "Snare drum"
  },
  {
    name = "cow_bell",
    displayName = "Cowbell"
  },
}
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

function initButtons()
  for instrumentIndex, instrument in ipairs(INSTRUMENTS) do
    local y = topMargin + (instrumentIndex - 1) * (LANE_HEIGHT + LANE_SPACING) + 1
    local paddingTop = (LANE_HEIGHT - 1) / 2
    table.insert(buttons, {
      x = LEFT_MARGIN,
      y = y,
      width = LANE_HEADING_WIDTH,
      height = LANE_HEIGHT,
      paddingTop = paddingTop,
      paddingLeft = 1,
      backgroundColor = colors.gray,
      text = instrument.displayName,
    })
    for beatIndex = 1,16 do
      table.insert(buttons, {
        x = LEFT_MARGIN + LANE_HEADING_WIDTH + (beatIndex - 1) * (BEAT_WIDTH + BEAT_SPACING),
        y = y,
        width = BEAT_WIDTH,
        height = LANE_HEIGHT,
        paddingTop = paddingTop,
        paddingLeft = 1,
        backgroundColor = colors.gray,
        text = " "
      })
    end
  end
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
initButtons()
drawGrid()
