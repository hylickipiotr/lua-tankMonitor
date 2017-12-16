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

-- Block = function(_peripheralName)
--   local peripheralName = _peripheralName
--
--   return {
--     peripheralName = peripheralName,
--
--     hasInternalLiquidStorage = function()
--       return peripheral.wrap(peripheralName).getTankInfo
--     end,
--
--     getTankInfo = function()
--       return peripheral.wrap(peripheralName).getTankInfo('')
--     end,
--   }
-- end
