import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        var returnedString = ""
        
        var tempArray = [String]()
        var nestingCounter = 0
        
        //multiplier vars
        var multiplier = 1
        var isPreviousInt = false
        var previousInt = ""
        var mulpiplierArray = [Int]()
        
        
        message.forEach { char in
            
            if char.isNumber {
                
                //check it because of number can contain more than 1 char
                if isPreviousInt {
                    previousInt += String(char)
                    multiplier = Int(previousInt)!
                } else {
                    
                isPreviousInt = true
                previousInt = String(char)
                multiplier = Int(previousInt)!
                }
                
                return
            }
            
            isPreviousInt = false
            
            if char == "[" {
                
                nestingCounter += 1
                mulpiplierArray.append(multiplier)
                multiplier = 1
                
                tempArray.append("")
                return
            }
            
            if char == "]" {
                
                //getting full string from scope
                var stringWithMultiplier = ""
                for _ in 0..<mulpiplierArray.last! {
                    stringWithMultiplier += tempArray.last!
                }
                
                if nestingCounter > 1 {
                    tempArray[nestingCounter - 1 - 1] += stringWithMultiplier
                } else {
                    returnedString += stringWithMultiplier
                }
                
                nestingCounter -= 1
                tempArray.removeLast()
                mulpiplierArray.removeLast()
                return
            }
            
            if nestingCounter == 0 {
                returnedString += String(char)
            } else {
                tempArray[nestingCounter - 1] += (String(char))
            }
        }
            
        return returnedString
    }
}
