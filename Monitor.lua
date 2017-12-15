newMonitor = function(peripheralName)
  local mon = peripheral.wrap(peripheralName)

  mon.width, mon.height = mon.getSize()

  mon.drawBox = function(positionX, positionY, width, height, color)
    local line = string.rep(" ", width)
    mon.setBackgroundColor(color)
    for i=positionY, positionY-height+1, -1 do
      mon.setCursorPos(positionX, i)
      mon.write(line)
    end
  end

  mon.clearAdv = function(...)
    local cursorPosX = tonumber(arg[1])
    local cursorPosY = tonumber(arg[2])

    mon.setBackgroundColor(colors.black)
    mon.clear()
    if type(cursorPosX)=='number' and type(cursorPosY)=='number' then
      mon.setCursorPos(cursorPosX,cursorPosY)
    else
      mon.setCursorPos(1,1)
    end
  end

  mon.writeAdv = function(...)
    local str = arg[1]
    local cursorPosX = arg[2]
    local cursorPosY = arg[3]
    if type(cursorPosX)=='number' and type(cursorPosY)=='number' then
      mon.setCursorPos(cursorPosX,cursorPosY)
    else
      mon.setCursorPos(1,1)
    end
    mon.setBackgroundColor(colors.black)
    mon.write(str)
  end

  return mon
end
