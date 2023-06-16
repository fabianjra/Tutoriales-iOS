//
//  StringChallenge.swift
//  SwiftChallenges
//
//  Created by Fabian Rodriguez on 15/6/23.
//

public class StringChallenge {
    
    /*
     1: Are the letters unique
     
     Write a function that accepts a String as its only parameter, and returns true if the string has
     only unique letters, taking letter case into account.
     */
    func uniqueLetters(text: String) -> Bool {
        
        var isUnique: Bool = true
        
        var checked: [Character] = []
        
        for item in text {
            
            for char in checked {
                
                if item == char {
                    isUnique = false
                }
            }
            
            checked.append(item)
        }
        
        return isUnique
    }
    
    /*
     2: Is a string a palindrome?
     
     Write a function that accepts a String as its only parameter, and returns true if the string reads
     the same when reversed, ignoring case.
     */
    func isStringPolindrome(text: String) -> Bool {
        
        var reversedText: String = ""
        
        for item in text {
            reversedText = "\(item)" + reversedText.lowercased()
        }

        return text.lowercased() == reversedText
    }
}
