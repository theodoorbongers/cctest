while true do
  local event, arg1, arg2, arg3, arg4, arg5 = os.pullEvent("chat_message")
  print(event)
  print(arg1)
  print(arg2)
  print(arg3)
  print(arg4)
  print(arg5)
end