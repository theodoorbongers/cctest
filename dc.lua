local instruments = { "basedrum", "hat", "snare", "cow_bell" }

monitor = periphals.find("monitor")

function drawGrid()
  for index, name in ipairs(instruments) do
    monitor.setCursorPos(1, index)
    monitor.write(name)
  end
end

drawGrid()
