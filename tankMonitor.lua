ccterm = assert(loadfile "ccterm.lua")()

local TANK = {}

function percentageValue(maxStorage,value)
  return math.floor(tonumber(value/maxStorage*100))
end

function hasInternalLiquidStorage(p)
  return peripheral.wrap(p).getTankInfo
end

function getTankPeripheralNames()
  tanks = {}
  for i,v in ipairs(peripheral.getNames()) do
    if hasInternalLiquidStorage(v) then
      table.insert(tanks,v)
    end
  end
  return tanks
end

function getTankInfo(name)
  return peripheral.wrap(name).getTankInfo('')
end

function isLiquidInTank(tankInfo)
  return tankInfo.amount
end

function updateLiquidSotregeValueInTank()
  tanksInfo = {}
  for i,peripheralName in ipairs(getTankPeripheralNames()) do
    for j,internalTankInfo in ipairs(getTankInfo(peripheralName)) do
      if isLiquidInTank(internalTankInfo) then
        table.insert(tanksInfo,
          {
            ["peripheralName"]=peripheralName,
            ["idInternalTank"]=j,
            ["ravName"]=internalTankInfo.ravName,
            ["name"]=internalTankInfo.name,
            ["capacity"]=internalTankInfo.capacity,
            ["amount"]=internalTankInfo.amount,
            ["percent"]=percentageValue(internalTankInfo.capacity,internalTankInfo.amount)
          })
      else
        table.insert(tanksInfo,
          {
            ["peripheralName"]=peripheralName,
            ["idInternalTank"]=j,
            ["ravName"]="NoLiquid",
            ["name"]="NoLiquid",
            ["capacity"]=internalTankInfo.capacity,
            ["amount"]=0,
            ["percent"]=0
          })
      end
    end
  end
  return tanksInfo
end

function convertTableTankInformation(tankInfo)
  newTankInfo = {}
  
  return newTankInfo
end

function displayLiquidStorageValueInTanksOnTerminal()
  clear()
  for i,tankInfo in ipairs(TANK) do
    str = ""
    for k,v in pairs(tankInfo) do
      str = str.. reduceString(tostring(v),15).. "/"
    end
    print(str)
  end
end

function main()
  TANK = updateLiquidSotregeValueInTank()
  displayLiquidStorageValueInTanksOnTerminal()
end

main()
