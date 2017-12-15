local peripheralName

newBlock = function(_peripheralName)
  peripheralName = _peripheralName
  return {
    peripheralName = peripheralName,

    hasInternalLiquidStorage = function()
      return peripheral.wrap(peripheralName).getTankInfo
    end,

    getTankInfo = function()
      return peripheral.wrap(peripheralName).getTankInfo('')
    end,
  }
end
