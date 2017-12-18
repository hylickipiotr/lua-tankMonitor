string.shorter = function(...)
   str = arg[1] or ""
   maxLetters = arg[2] or #str
   endOfString = arg[3] or ""

   local newStr = ""
   if #str > maxLetters and maxLetters > #endOfString then
     newStr = string.sub(str,1,maxLetters-#endOfString).. endOfString
     return newStr
   else
     return str
   end
 end
