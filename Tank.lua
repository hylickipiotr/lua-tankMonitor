local peripheralName
local idInternalTank
local ravName
local name
local capacity
local amount
local percent

local isEmpty = function(liquidAmount)
  return liquidAmount
end

local percentageValue = function()
  if amount ~= nil and capacity ~= nil then
    return math.floor(tonumber(amount/capacity*100))
  end
end

local updateTankInformation = function(tableTankInfo)
  if isEmpty(tableTankInfo.amount) then
    ravName = tableTankInfo.ravName
    name = tableTankInfo.name
    capacity = tableTankInfo.capacity
    amount = tableTankInfo.amount
  else
    ravName = "empty"
    name = "Empty"
    capacity = tableTankInfo.capacity
    amount = 0
  end
  percent = percentageValue()
end

newTank = function(pName, tableTankInfo)
  peripheralName = pName
  updateTankInformation(tableTankInfo)
  return {
    peripheralName = peripheralName,
    idInternalTank = idInternalTank,
    ravName = ravName,
    name = name,
    capacity = capacity,
    amount = amount,
    percent = percent,
  }
end
