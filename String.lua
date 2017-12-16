string.reduceString = function(str, maxLetters, endOfString)
   newStr = ""
   if #str > maxLetters and maxLetters > #endOfString then
     newStr = string.sub(str,1,maxLetters-#endOfString).. endOfString
     return newStr
   else
     return str
   end
 end
