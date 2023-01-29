function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local stop = false
while not stop do
  local ignoredEvents = Set { "key", "key_up", "char" }
  local event = {os.pullEvent()}
  print("q", event[2])

  local eventName = table.unpack(event)
  if eventName == "char"
  then
    print("JA")
  end
  if eventName == "key"
  then
    stop = true
  end

  if not ignoredEvents[eventName]
  then
    print(table.unpack(event))
  end
end