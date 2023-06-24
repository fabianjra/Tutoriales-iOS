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
    
    /*
     8: String is rotated
     
     Write a function that accepts two strings, and returns true if one string is rotation of the other,
     taking letter case into account.
     */
    func stringIsRotated(textOriginal: String, textRotated:String) -> Bool {
        
        //TODO: No se entiende.
        
        return true
    }
    
    /*
     9: Find pangrams
     
     Write a function that returns true if it is given a string that is an English pangram, ignoring
     letter case.
     A pangram is a string that contains every letter of the alphabet at least once.
     */
    func findPangrams(text: String) -> Bool {
        
        let abc = "abcdefghijklmnopqrstuvwxyz"
        var containLetter = true
        
        for abeLetter in abc {
            
            if !text.lowercased().contains(abeLetter) {
                containLetter = false
            }
        }
        
        return containLetter
    }
    
    //9: Find pangrams: Using filter
    func findPangramsUsingFilter(text: String) -> Bool {
     
        var isPangrams = false
        let set = Set(text.lowercased()) //Set: It is an array, but removed duplicates
        
        let filtered = set.filter { $0 >= "a" && $0 <= "z" }
        
        //NOTE: All characters in the abecedary are in total 26 letters.
        if filtered.count == 26 {
            isPangrams = true
        }
        
        return isPangrams
    }
    
    /*
     10: Vowels and consonants
     
     Given a string in English, return a tuple containing the number of vowels and consonants.
     Tip: Vowels are the letters, A, E, I, O, and U.
     consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.
     */
    func vowelsAndConsonants(text: String) -> VowelsConsonants {
        
        var response = VowelsConsonants(vowels: 0, consonants: 0)
        
        let vowels = "AEIOU"
        let consonants = "BCDFGHJKLMNPQRSTVWXYZ"
        
        for letter in text.lowercased() {
            
            for vowel in vowels.lowercased() {
                if vowel == letter {
                    response.vowels += 1
                }
            }
            
            for consonant in consonants.lowercased() {
                if consonant == letter {
                    response.consonants += 1
                }
            }
        }
        
        return response
    }
    
    public struct VowelsConsonants: Equatable {
        var vowels: Int
        var consonants: Int
    }
    
    /*
     11: Three different letters
     
     Write a function that accepts two strings, and returns true if they are identical in length but
     have no more than three different letters, taking case and string order into account.
     */
    func threeDifferentsLetters(text1: String, text2: String) -> Bool {
        
        var countDiferences = 0
        let array2 = Array(text2)
        
        //First: Validate if string are same count.
        guard text1.count == text2.count else { return false }
        
        //Second: Compare characters
        for (i, letter1) in text1.enumerated() {
            
            if letter1 != array2[i] {
                
                countDiferences += 1
            }
        }
        
        //Third: Differences cannot be higher than 3.
        if countDiferences > 3 {
            return false
        }
        
        return true
    }
    
    /*
     12: Find longest prefix
     
     Write a function that accepts a string of words with a similar prefix, separated by spaces, and
     returns the longest substring that prefixes all words.
     */
    func findLongestPrefix(text: String) -> String {
        
        let parts = text.components(separatedBy: " ")
        
        guard let first = parts.first else { return "" }
        
        var currentPrefix = ""
        var bestPrefix = ""
        
        for letter in first {
            
            currentPrefix.append(letter)
            
            for word in parts {
                
                if !word.hasPrefix(currentPrefix) {
                    return bestPrefix
                }
            }
            
            bestPrefix = currentPrefix
        }
        
        return bestPrefix
    }
    
    /*
     13: Run-length encoding
     
     Write a function that accepts a string as input, then returns how often each letter is repeated in
     a single run, taking case into account.
     
     Tip: This approach is used in a simple lossless compression technique called run-length encoding.
     */
    func runLenghtEncoding(text: String) -> String {
        
        var counter = 0
        var newString = ""
        var pastLetter = ""
        
        //Enumerated: Para saber cuando es el ultimo caracter y solamente hacerle append al texto final.
        for (i, letter) in text.enumerated() {
            
            if pastLetter != String(letter) {
                
                //Si la letra es diferente y ya se tenia el contador mayor a 1: Es hora de hacer el append al texto final, junto a su contador.
                //Luego de esto, se reinicia el contador y se lleva 1 de la letra actual.
                //Sino: solamente se aumenta 1 y se asigna la letra anterior a la actual.
                if counter >= 1 {
                    
                    newString.append(pastLetter + "\(counter)")
                    
                    //Reset counter to the new letter:
                    counter = 1
                    
                } else {
                    counter += 1
                }
                
                pastLetter = String(letter)

                //Si la letra es la misma a la pasada, solamente aumenta 1 al contador.
            } else {
                counter += 1
                
                if i == (text.count - 1) {
                    
                    newString.append(pastLetter + "\(counter)")
                }
            }
        }
        
        return newString
    }
}
