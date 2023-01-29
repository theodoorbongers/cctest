function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local stop = false
while not (stop) do
  local ignoredEvents = Set { "key", "key_up", "char" }
  ignoredEvents = {}
  local event = {os.pullEvent()}

  local eventName = table.unpack(event)
  if eventName == "char" and event[2] == "q"
  then
    stop = true
  end

  if not ignoredEvents[eventName]
  then
    print(table.unpack(event))
  end
end