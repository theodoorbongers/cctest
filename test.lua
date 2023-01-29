function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local stop = false
local count = 0
while not (stop or count > 10) do
  local ignoredEvents = Set { "key", "key_up", "char" }
  local event = {os.pullEvent()}
  count = count + 1
  print("q", event[2])

  local eventName = table.unpack(event)
  if eventName == "char"
  then
    print "JA"
    stop = true
  end

  if not ignoredEvents[eventName]
  then
    print(table.unpack(event))
  end
end