//
//  RnmCustomInputTableViewCell.swift
//  RomanNumeralsMapping
//
//  Created by Hussain  on 31/3/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import UIKit

class RnmCustomInputTableViewCell: UITableViewCell {
    @IBOutlet weak var inputText : UITextField?
    @IBOutlet weak var outPutText : UITextField?
    var representedObject : AnyObject? = nil
    var romanDictionary : [String : Int] = ["M" : 1000, "CM" : 900, "D" : 500, "CD" : 400, "C" : 100, "XC" : 90, "L" : 50, "XL" : 40, "X" : 10, "IX" : 9, "V" : 5, "IV" : 4, "I" : 1];
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func convertRomanIntoDecimal(sender : AnyObject){
        let input = self.inputText?.text
        let inputInUpperCase = input?.uppercaseString
        validateCharactersFromString(inputInUpperCase!)
    }
    
    func validateCharactersFromString(inputValue : String){
        var mutableStrList  = [AnyObject]()
        var valid : Bool? = true
        for (var char = 0 ; char < inputValue.characters.count; char++){
            let keyCharacter = inputValue[char]
            mutableStrList.append(String(keyCharacter))
            var filteredList : [AnyObject]?
            if (keyCharacter == "I" || keyCharacter == "X" || keyCharacter == "C"){
                filteredList = mutableStrList.filter({$0.containsString(String(keyCharacter))})
                if (filteredList!.count < 5){
                    valid = true
                }
                else{
                    valid = false
                    displayAlert()
                    break
                }
            }
            else if (keyCharacter == "M"){
                filteredList = mutableStrList.filter({$0.containsString(String(keyCharacter))})
                if (filteredList!.count <= 5){
                    valid = true
                }
                else{
                    valid = false
                    displayAlert()
                    break
                }
            }
                //Second Checking Count of character (V,L,D) which should not be more than 1.
            else if (keyCharacter == "V" || keyCharacter == "L" || keyCharacter == "D"){
                filteredList = mutableStrList.filter({$0.containsString(String(keyCharacter))})
                if (filteredList!.count < 2){
                    valid = true
                }
                else{
                    valid = false
                    displayAlert()
                    break
                }
            }
            
                //Third if charcters are other than  I,X,C,M,V,L,D then display Invalid input.
            else
            {
                valid = false
                displayAlert()
                break
            }
    }
        if (valid == true){
            valid = validateTwoOrMoreSmallerNumberInFrontLargerNumber(mutableStrList)
        }
        if (valid == true){
            var totalValue = 0
            let strCount = mutableStrList.count
            for (var i = 0; i < strCount; i++){
                var j = i + 1
                if (j >= strCount){
                    j = i;
                }
                let previousIndex : Int? = self.romanDictionary[mutableStrList[i] as! String]
                let nextIndex : Int? = self.romanDictionary[mutableStrList[j] as! String]
                if (previousIndex >= nextIndex){
                    totalValue += previousIndex!;
                }
                else{
                    totalValue -= previousIndex!;
                }
            }
            //Checking if decimal value will generate correct Roman Numerals
            let str = romanNumeral(totalValue)
            if (self.inputText?.text?.uppercaseString == str){
                valid = true;
                let formattedString : String = NSString(format: "%d",(totalValue)) as String
                self.outPutText?.text = formattedString
            }
            else{
                valid = false;
                displayAlert();
            }
        }
        else
        {
            valid = false;
            displayAlert();
        }
    }

    
    func validateTwoOrMoreSmallerNumberInFrontLargerNumber(smallNumber : [AnyObject]) -> Bool{
        var tempArray : [AnyObject] = smallNumber
        var isValid : Bool = true
        if (tempArray.count == 0){
             isValid = false
        }
        else{
            repeat{
                let tempCount = tempArray.count - 1
                let lastObj : String = tempArray.last as! String
                let lastInteger : Int? = self.romanDictionary[lastObj]
                var integerCount = 0;
                for (var i = 0; i<tempCount ; i++){
                    let charStr : String = tempArray[i] as! String
                    let tempInteger : Int? = self.romanDictionary[charStr]
                    if (tempInteger < lastInteger){
                        integerCount++
                    }
                    if (integerCount > 1){
                        isValid = false
                    }
                }
                tempArray.removeLast()
            }while (tempArray.count > 0)
        }
        return isValid
    }
    
    
    func romanNumeral(value : NSInteger) -> String{
        var n = value
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let valueCount = 13
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        var numeralString = ""
        for (var j = 0; j < valueCount; j++)
        {
            while (n >= values[j])
            {
                n = n - values[j];
                numeralString.appendContentsOf(numerals[j])
            }
        }
        return numeralString;
    }
    
    
    func displayAlert () {
        let trimmedString = self.inputText!.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let formattedString : String = NSString(format: "%@ is not a valid input",(trimmedString)!) as String
        let alertController  = UIAlertController(title: kApplicationName, message: (trimmedString!.characters.count > 0) ? formattedString : kNoData, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: kOkButton, style: UIAlertActionStyle.Cancel, handler: nil))
        let viewController = self.representedObject as! RnmViewController
         viewController.presentViewController(alertController, animated: true, completion:nil)
        self.inputText!.text = kNone;
        self.outPutText!.text = kNone;
        return;
    }
    
}

extension String{
    subscript(i : Int) -> Character{
        return self[self.startIndex.advancedBy(i)]
    }
}
