term.clearAdv = function(...)
  cursorPositionX = arg[1]
  cursorPositionY = arg[2]

  term.clear()
  if cursorPositionX == "number" and cursorPositionY == "number" then
    term.setCursorPos(cursorPositionX,cursorPositionY)
  else
    term.setCursorPos(1,1)
  end
end
