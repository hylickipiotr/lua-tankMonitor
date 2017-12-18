Liquid = {}

function Liquid.new(tankInfo)
  local self = {}

  self.amount = tankInfo.amount or 0
  self.name = tankInfo.name or "empty"
  self.rawName = tankInfo.rawName or "Empty"

  return self
end
