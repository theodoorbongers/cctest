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

function drawGrid()
  for instrumentIndex, instrumentName in ipairs(INSTRUMENTS) do
    local y = topMargin + instrumentIndex * LANE_HEIGHT + (instrumentIndex - 1) * LANE_SPACING
    monitor.setCursorPos(LEFT_MARGIN, y)
    monitor.write(instrumentName)
    
    for beatIndex = 1,10
    do
      monitor.setCursorPos(LEFT_MARGIN + LANE_HEADING_WIDTH + (beatIndex - 1) * (BEAT_WIDTH + BEAT_SPACING) - BEAT_SPACING, y)
      monitor.write("X")
    end
  end
end

monitor.clear()
drawGrid()
