Tank = {}

function Tank.new(tankInfo)
   local self = {}

   self.capacity = tankInfo.capacity or 0
   self.liquid = Liquid.new(tankInfo)

   function self.getPercentageLiquidStorageValue()
    return math.floor(self.liquid.amount/self.capacity*100)
   end

   return self
end
