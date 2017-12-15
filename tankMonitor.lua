CCTermApi = loadfile('ccterm.lua')()
BlockAPI = loadfile('Block.lua')()
TankAPI = loadfile('Tank.lua')()
Monitor = loadfile('Monitor.lua')()

local TANK = {}

local function logic ()
  for i,peripheralName in ipairs(peripheral.getNames()) do
    _block = newBlock(peripheralName)
    if _block.hasInternalLiquidStorage() then
      for j,internalTank in ipairs(_block.getTankInfo('')) do
        _tank = newTank(peripheralName, internalTank)
        _tank.idInternalTank = j
        table.insert(TANK, _tank)
      end
    end
  end
end

local function displayLiquidStorageValueInTanksOnTerminal()
  ccterm.clear()
  for i,tankInfo in ipairs(TANK) do
    str = ""
    for k,v in pairs(tankInfo) do
      str = str.. ccterm.reduceString(tostring(v),15).. "/"
    end
    print(str)
  end
end

local function displayLiquidStorageValueInTanksOnMonitor()
  monitor = newMonitor("top")
  monitor.clearAdv()

  for i,v in ipairs(TANK) do
    local percent = v.percent
    local spaceBeetwenTankBoxs = 1
    local tankBoxWidth = (monitor.width-(spaceBeetwenTankBoxs*(#TANK-1))-((monitor.width-(spaceBeetwenTankBoxs*(#TANK-1)))%#TANK))/#TANK
    local tankBoxWithSpaceLength = (#TANK*tankBoxWidth)+((#TANK-1)*spaceBeetwenTankBoxs)
    local spaceBeforeTankBox = ((monitor.width-tankBoxWithSpaceLength)-1*((monitor.width-tankBoxWithSpaceLength)%2))/2
    if tankBoxWidth >= 4 then displayPercentageValueOnTop=1 else displayPercentageValueOnTop=0 end
    local tankBoxHeight = math.floor((percent/100)*(monitor.height-displayPercentageValueOnTop))
    local tankBoxStartPositionX = spaceBeforeTankBox+(spaceBeetwenTankBoxs*(i-1))+(tankBoxWidth*(i-1)+1)
    local percentageStringLength = #tostring(percent)+1
    local spaceBeforepercentageValueText = ((tankBoxWidth-percentageStringLength)-1*((tankBoxWidth-percentageStringLength)%2))/2
    local percentageValueTextPositionX = tankBoxStartPositionX+spaceBeforepercentageValueText
    local percentageValueTextPositionY = monitor.height-tankBoxHeight

    print(percentageValueTextPositionX.. " "..  percentageValueTextPositionY)
    monitor.drawBox(tankBoxStartPositionX,monitor.height,tankBoxWidth,tankBoxHeight,colors.red)
    if displayPercentageValueOnTop == 1 then
      monitor.writeAdv(percent.. "%", percentageValueTextPositionX, percentageValueTextPositionY)
    end
  end
end

local function main()
  while true do
    TANK = {}
    logic()
    displayLiquidStorageValueInTanksOnTerminal()
    displayLiquidStorageValueInTanksOnMonitor()
    sleep(0.2)
  end
end

main()
