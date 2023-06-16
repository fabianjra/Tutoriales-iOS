//
//  StringChallenge.swift
//  SwiftChallenges
//
//  Created by Fabian Rodriguez on 15/6/23.
//

import Foundation

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
    
    /*
     3: Do two strings contain the same characters?
     
     Write a function that accepts two String parameters, and returns true if they contain the same
     characters in any order taking into account letter case.
     */
    func twoStringSameCharacters(text1: String, text2: String) -> Bool {
        
        var checked: String = text2
        
        for letter in text1 {
            
            //First index ins basically: INDEX
            if let index = checked.firstIndex(of: letter) {
                checked.remove(at: index)
            }
        }
        
        return checked.count == 0
        
        //A simpler solution is to remember that strings are sequences in Swift and sort them directly.
        //Once that’s done, you can do a direct comparison using ==.
        //This ends up involving much less code:
        //return text1.sorted() == text2.sorted()
    }
}
