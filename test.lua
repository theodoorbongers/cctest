local stop = false
while not stop do
  local event = {os.pullEvent()}
  print(event)
  stop = true
end