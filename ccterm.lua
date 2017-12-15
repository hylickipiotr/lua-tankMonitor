do
  ccterm = {
    clear = function()
      term.clear()
      term.setCursorPos(1,1)
      return true
    end,

   reduceString = function(str, maxLetters)
      newStr = ""
      if #str > maxLetters and maxLetters > 3 then
        newStr = string.sub(str,1,maxLetters-3).. "..."
        return newStr
      else
        return str
      end
    end,
  }
end
