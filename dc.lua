local monitor = peripheral.find("monitor")
local speaker = peripheral.find("speaker")
monitor.setTextScale(0.5)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local monitorWidth, monitorHeight = monitor.getSize()

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
local LANE_HEIGHT = 5
local LANE_SPACING = 1
local TOTAL_LANE_HEIGHT = #INSTRUMENTS * (LANE_HEIGHT + LANE_SPACING) - LANE_SPACING
local LEFT_MARGIN = 2
local BEAT_SPACING = 1
local BEAT_GROUP_SIZE = 4
local BEAT_GROUP_SPACING = 1
local BEAT_WIDTH = 3
local LANE_HEADING_WIDTH = 12
local TOTAL_BEATS = 32
local TICKS_PER_BEAT = 4
local triggersPerInstrument = {
  basedrum = { true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false },
  hat = { false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true },
  snare = { false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false }
}
local triggerButtons
local currentBeatIndex = 0

function getPaletteEntries()
  local entries = {}
  for index = 0,15 do
    table.insert(entries, 2 ^ index)
  end
  return unpack(entries)
end

local COLOR_HEADER_FOREGROUND, COLOR_HEADER_BACKGROUND, COLOR_UNSELECTED_BEAT, COLOR_SELECTED_BEAT, COLOR_CURRENT_BEAT = getPaletteEntries()

monitor.setPaletteColor(COLOR_HEADER_FOREGROUND, 1, 1, 1)
monitor.setPaletteColor(COLOR_HEADER_BACKGROUND, 0.1, 0.1, 0.1)
monitor.setPaletteColor(COLOR_UNSELECTED_BEAT, 0.1, 0.1, 0.2)
monitor.setPaletteColor(COLOR_SELECTED_BEAT, 0.5, 0.5, 1)
monitor.setPaletteColor(COLOR_CURRENT_BEAT, 0.5, 1, 0.5)

local topMargin = math.floor((monitorHeight - TOTAL_LANE_HEIGHT) / 2)

local buttons = {}

function initButtons()
  triggerButtons = {}
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
      textColor = COLOR_HEADER_FOREGROUND,
      backgroundColor = COLOR_HEADER_BACKGROUND,
      text = instrument.displayName,
    })

    triggerButtons[instrument.name] = {}
    
    for beatIndex = 1,TOTAL_BEATS do
      local button = {
        x = LEFT_MARGIN + LANE_HEADING_WIDTH + (beatIndex - 1) * (BEAT_WIDTH + BEAT_SPACING) + math.floor((beatIndex - 1) / BEAT_GROUP_SIZE + 1) * BEAT_GROUP_SPACING + 1,
        y = y,
        width = BEAT_WIDTH,
        height = LANE_HEIGHT,
        paddingTop = paddingTop,
        paddingLeft = 1,
        textColor = COLOR_UNSELECTED_BEAT,
        backgroundColor = COLOR_UNSELECTED_BEAT,
        text = ""
      }
      table.insert(buttons, button)
      triggerButtons[instrument.name][beatIndex] = button;
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

function updateButtonColor(instrument, beatIndex)
  local button = triggerButtons[instrument][beatIndex]
  print("updateButtonColor", instrument, beatIndex)
  if beatIndex == currentBeatIndex then
    print("setting button to COLOR_CURRENT_BEAT", instrument, beatIndex)
    button.backgroundColor = COLOR_CURRENT_BEAT
  elseif triggersPerInstrument[instrument][beatIndex] then
    print("setting button to COLOR_SELECTED_BEAT", instrument, beatIndex)
    button.backgroundColor = COLOR_SELECTED_BEAT
  else
    print("setting button to COLOR_UNSELECTED_BEAT", instrument, beatIndex)
    button.backgroundColor = COLOR_UNSELECTED_BEAT
  end
end

function paintButton(button)
  monitor.setTextColor(button.textColor)
  monitor.setBackgroundColor(button.backgroundColor)
  clearSquare(button.x, button.y, button.width, button.height)
  monitor.setCursorPos(button.x + button.paddingLeft, button.y + button.paddingTop)
  monitor.write(button.text)
end

function paintScreen()
  for i,button in ipairs(buttons) do
    paintButton(button)
  end
end

function processBeat()
  local previousBeatIndex = currentBeatIndex
  currentBeatIndex = (currentBeatIndex % TOTAL_BEATS) + 1
  print("processBeat", previousBeatIndex, currentBeatIndex)
  for instrument, buttons in pairs(triggerButtons) do
    if previousBeatIndex > 0 then
      updateButtonColor(instrument, previousBeatIndex)
    end
    updateButtonColor(instrument, currentBeatIndex)
  end

  for instrument, triggers in pairs(triggersPerInstrument) do
    if triggers[currentBeatIndex] then
      speaker.playNote(instrument)
    end
  end
  paintScreen()
end

initButtons()
paintScreen()
local timerId = os.startTimer(TICKS_PER_BEAT * 0.05)
local quit
while not quit do
  local eventData = {os.pullEvent()}
  local event = eventData[1]
  -- print(table.unpack(eventData))
  if event == "timer" and eventData[2] == timerId then
    processBeat()
    timerId = os.startTimer(TICKS_PER_BEAT * 0.05)
  elseif event == "char" and eventData[2] == "q" then
    quit = true
  end
end