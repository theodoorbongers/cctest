local stop = false
while not stop do
  local event = {os.pullEvent()}
  print(table.unpack(event))
  stop = true
end