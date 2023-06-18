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
            
            //First index is basically: INDEX
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

/*
 4: Does one string contain another?
 
 Write your own version of the contains() method on String that ignores letter case, and
 without using the existing contains() method.
 */
//TODO: Use range to finish it.
extension String {
    
    func fuzzyContains(text: String) -> Bool {
        
        //var contains = false
        
//        if self.isEmpty {
//            return false
//        }
        
       // let range = self.range(of: text)
        
        
        return false
    }
}

extension StringChallenge {
    
    /*
     5: Count the characters
     
     Write a function that accepts a string, and returns how many times a specific character appears,
     taking case into account.
     */
    func countCharacters(text: String, character: Character) -> Int {
        
        var count = 0
        
        for item in text {
            
            if item == character {
                count += 1
            }
        }
        
        return count
    }
    
    //5: Count the characters: Using reduce
    func countCharacterReduce(text: String, character: Character) -> Int {
        
        let count = text.reduce(0) { $1 == character ? $0 + 1 : $0 }
        
        return count
    }
    
    
    /*
     6: Remove duplicate letters from a string
     
     Write a function that accepts a string as its input, and returns the same string just with
     duplicate letters removed.
     */
    func removeDuplicatedLetters(text: String) -> String {
        
        var newText = ""
        
        for letter in text {
            
            if newText.contains(letter) == false {
                newText.append(letter)
            }
        }
        
        return newText
    }
    
    /*
     7: Condense whitespace
     
     Write a function that returns a string with any consecutive spaces replaced with a single space.
     */
    //TODO: Use range to finish it.
    func codenseWhitespace(text: String) -> String {
        
        var seenSpace = false
        var removedSpaces = ""
        
        for letter in text {
            
            if letter == " " {
                
                if seenSpace {
                    continue //Continue with the next iteration.
                }
                
                seenSpace = true
                
            } else {
                seenSpace = false
            }
            
            removedSpaces.append(letter)
        }
        
        return removedSpaces
    }
}
