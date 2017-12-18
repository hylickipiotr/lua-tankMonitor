Block = {}

function Block.new(peripheralName)
  local self = {}

  self.peripheralName = peripheralName

  function self.hasLiquidStorage()
    return peripheral.wrap(self.peripheralName).getTankInfo
  end

  function self.getLiquidStorages()
    return peripheral.wrap(self.peripheralName).getTankInfo('')
  end

  return self
end
