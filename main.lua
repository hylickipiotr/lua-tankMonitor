local TANK = {}

local function logic()

  for i,peripheralName in ipairs(peripheral.getNames()) do
    local block = Block.new(peripheralName)
    if block.hasLiquidStorage() then
      for j,internalTank in ipairs(block.getLiquidStorages()) do
        local tank = Tank.new(internalTank)
        tank.peripheralName = block.peripheralName
        table.insert(TANK, tank)
      end
    end
  end
end

local function displayLiquidStorageValueInTanksOnTerminal()
  term.clearAdv()
  for i,tankInfo in ipairs(TANK) do
    --for k,v in pairs(tankInfo) do print(k,"|",v) end
    peripheralName = string.shorter(tankInfo.peripheralName, 15, "...")
    liquidName = string.shorter(tankInfo.liquid.rawName, 10, "...")
    liquidAmount = tankInfo.liquid.amount
    tankCapacity = tankInfo.capacity
    tankPercent = tankInfo.getPercentageLiquidStorageValue()
    print(liquidName," ",tankPercent,"% ",liquidAmount,"/",tankCapacity," [",peripheralName,"]")
  end
end

local function displayLiquidStorageValueInTanksOnMonitor()
  monitor = Monitor("top")
  monitor.clearAdv()

  for i,tank in ipairs(TANK) do
    local percent = tank.getPercentageLiquidStorageValue()

    --Calculate width, height and position of TankBox
    local spaceBeetwenTankBoxs = 1
    local tankBoxWidth = (monitor.width-(spaceBeetwenTankBoxs*(#TANK-1))-((monitor.width-(spaceBeetwenTankBoxs*(#TANK-1)))%#TANK))/#TANK
    local tankBoxWithSpaceLength = (#TANK*tankBoxWidth)+((#TANK-1)*spaceBeetwenTankBoxs)
    local spaceBeforeTankBox = ((monitor.width-tankBoxWithSpaceLength)-1*((monitor.width-tankBoxWithSpaceLength)%2))/2
    if tankBoxWidth >= 4 then displayPercentageValueOnTop=1 else displayPercentageValueOnTop=0 end
    local tankBoxHeight = math.floor((percent/100)*(monitor.height-displayPercentageValueOnTop))
    local tankBoxStartPositionX = spaceBeforeTankBox+(spaceBeetwenTankBoxs*(i-1))+(tankBoxWidth*(i-1)+1)

    --Calculate length and position of LiquidPercentageValue in interant tank
    local percentageStringLength = #tostring(percent)+1
    local spaceBeforepercentageValueText = ((tankBoxWidth-percentageStringLength)-1*((tankBoxWidth-percentageStringLength)%2))/2
    local percentageValueTextPositionX = tankBoxStartPositionX+spaceBeforepercentageValueText
    local percentageValueTextPositionY = monitor.height-tankBoxHeight

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
    sleep(3)
  end
end

main()
