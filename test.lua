function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local stop = false
while not stop do
  local ignoredEvents = Set {"key_up"}
  local event = {os.pullEvent()}
  print(table.unpack(event))

  local eventName = table.unpack(event)
  if not ignoredEvents[eventName]
  then
    stop = true
  end
end