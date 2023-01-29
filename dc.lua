local INSTRUMENTS = { "basedrum", "hat", "snare", "cow_bell" }
local LANE_HEIGHT = 3
local LANE_SPACING = 1
local TOTAL_LANE_HEIGHT = #INSTRUMENTS * (LANE_HEIGHT + LANE_SPACING) - LANE_SPACING
local MARGIN_LEFT = 2

local monitor = peripheral.find("monitor")
local monitorWidth, monitorHeight = monitor.getSize()

local topMargin = (monitorHeight - TOTAL_LANE_HEIGHT) / 2

function drawGrid()
  for index, name in ipairs(INSTRUMENTS) do
    monitor.setCursorPos(MARGIN_LEFT + 1, topMargin + index * LANE_HEIGHT + (index - 1) * LANE_SPACING)
    monitor.write(name)
  end
end

monitor.clear()
drawGrid()
