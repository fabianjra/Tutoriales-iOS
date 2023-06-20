//
//  SwiftChallengesTests.swift
//  SwiftChallengesTests
//
//  Created by Fabian Rodriguez on 15/6/23.
//

import XCTest
@testable import SwiftChallenges

final class SwiftChallengesTests: XCTestCase {
    
    let challenge: StringChallenge = StringChallenge()

    //This function allow us to declare or instanciate values or variables, before the tests run.
    //By default, Xcode adds "class" to this function. It has to be removed.
    override func setUpWithError() throws {
        //This method is called before the invocation of each test method in the class.
    }

    //This function runs after each Test run.
    //For example: Can be used to erase some storage in "UserDefaults".
    override func tearDownWithError() throws {
        //This method is called after the invocation of each test method in the class.
    }

    //All test function have to start with "test" in the function name.

    /*
     1: Are the letters unique
     
     Write a function that accepts a String as its only parameter, and returns true if the string has
     only unique letters, taking letter case into account.
     */
    func test_uniqueLetters_OK() {
        
        XCTAssertEqual(challenge.uniqueLetters(text: "No duplicates"), true)
        
        XCTAssertEqual(challenge.uniqueLetters(text: "AaBbCc"), true)
        
        XCTAssertEqual(challenge.uniqueLetters(text: "Fabian"), false)
        
        XCTAssertEqual(challenge.uniqueLetters(text: "Hello, world"), false)
        
        XCTAssertEqual(challenge.uniqueLetters(text: "Helo, wrd"), true)
    }
    
    /*
     2: Is a string a palindrome?
     
     Write a function that accepts a String as its only parameter, and returns true if the string reads
     the same when reversed, ignoring case.
     */
    func test_isStringPolindrome_OK() {
     
        XCTAssertEqual(challenge.isStringPolindrome(text: "rotator"), true)
        
        XCTAssertEqual(challenge.isStringPolindrome(text: "Rats live on no evil star"), true)
        
        //false: even though the letters are the same in reverse the spaces are in different places.
        XCTAssertEqual(challenge.isStringPolindrome(text: "Never odd or even"), false)
        
        XCTAssertEqual(challenge.isStringPolindrome(text: "Hello, world"), false)
    }
    
    /*
     3: Do two strings contain the same characters?
     
     Write a function that accepts two String parameters, and returns true if they contain the same
     characters in any order taking into account letter case.
     */
    func test_twoStringSameCharacters_OK() {
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abca", text2: "abca"), true)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abc", text2: "cba"), true)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: " a1 b2 ", text2: " b1 a2"), true)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abc", text2: "abca"), false)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abc", text2: "Abc"), false)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abc", text2: "cbAa"), false)
        
        XCTAssertEqual(challenge.twoStringSameCharacters(text1: "abcc", text2: "abca"), false)
    }
    
    /*
     4: Does one string contain another?
     
     Write your own version of the contains() method on String that ignores letter case, and
     without using the existing contains() method.
     */
    func test_fuzzyContains_OK() {
        //TODO: Finish the method.
        //XCTAssertEqual("Hello, world".fuzzyContains(text: "Hello"), true)
        
        //XCTAssertEqual("Hello, world".fuzzyContains(text: "WORLD"), true)
        
        //XCTAssertEqual("Hello, world".fuzzyContains(text: "Goodbye"), false)
    }
    
    /*
     5: Count the characters
     
     Write a function that accepts a string, and returns how many times a specific character appears,
     taking case into account.
     */
    func test_countCharacters_OK() {
        
        XCTAssertEqual(challenge.countCharacters(text: "The rain in Spain", character: "a"), 2)
        
        XCTAssertEqual(challenge.countCharacters(text: "Mississippi", character: "i"), 4)
        
        XCTAssertEqual(challenge.countCharacters(text: "Hacking with Swift", character: "i"), 3)
        
        XCTAssertEqual(challenge.countCharacters(text: "Rosa Angelica", character: "a"), 2)
        
        //USING REDUCE:
        XCTAssertEqual(challenge.countCharacters(text: "Hacking with Swift", character: "i"), 3)
        XCTAssertEqual(challenge.countCharacterReduce(text: "Rosa Angelica", character: "a"), 2)
    }
    
    /*
     6: Remove duplicate letters from a string
     
     Write a function that accepts a string as its input, and returns the same string just with
     duplicate letters removed.
     */
    func test_removeDuplicatedLetters_OK() {
        
        XCTAssertEqual(challenge.removeDuplicatedLetters(text: "wombat"), "wombat")
        
        XCTAssertEqual(challenge.removeDuplicatedLetters(text: "hello"), "helo")
        
        XCTAssertEqual(challenge.removeDuplicatedLetters(text: "Mississippi"), "Misp")
        
        XCTAssertEqual(challenge.removeDuplicatedLetters(text: "Fabian"), "Fabin")
    }
    
    /*
     7: Condense whitespace
     
     Write a function that returns a string with any consecutive spaces replaced with a single space.
     */
    func test_codenseWhitespace_OK() {
        
        XCTAssertEqual(challenge.codenseWhitespace(text: "a   b   c"), "a b c")
        
        XCTAssertEqual(challenge.codenseWhitespace(text: "    a"), " a")
        
        XCTAssertEqual(challenge.codenseWhitespace(text: "abc"), "abc")
    }
    
    /*
     8: String is rotated
     
     Write a function that accepts two strings, and returns true if one string is rotation of the other,
     taking letter case into account.
     */
    func test_stringIsRotated_OK() {
        
        //XCTAssertEqual(challenge.stringIsRotated(textOriginal: "abcde", textRotated: "abcde"), true)
    }
    
    /*
     9: Find pangrams
     
     Write a function that returns true if it is given a string that is an English pangram, ignoring
     letter case.
     A pangram is a string that contains every letter of the alphabet at least once.
     */
    func test_findPangrams_OK() {
        
        XCTAssertEqual(challenge.findPangrams(text: "The quick brown fox jumps over the lazy dog"), true)
        
        XCTAssertEqual(challenge.findPangrams(text: "The quick brown fox jumped over the lazy dog"), false)
        
        XCTAssertEqual(challenge.findPangrams(text: "abcdefghijklmnopqrstuvwxyz- SI CONTIENE TODAS"), true)
        
        XCTAssertEqual(challenge.findPangrams(text: "abcdefghijklmnopqrstu..()^$"), false)
        
        //USING FILTER:
        XCTAssertEqual(challenge.findPangramsUsingFilter(text: "The quick brown fox jumps over the lazy dog"), true)
        XCTAssertEqual(challenge.findPangramsUsingFilter(text: "The quick brown fox jumped over the lazy dog"), false)
        XCTAssertEqual(challenge.findPangramsUsingFilter(text: "abcdefghijklmnopqrstuvwxyz- SI CONTIENE TODAS"), true)
        XCTAssertEqual(challenge.findPangramsUsingFilter(text: "abcdefghijklmnopqrstu..()^$"), false)
    }
    
    /*
     10: Vowels and consonants
     
     Given a string in English, return a tuple containing the number of vowels and consonants.
     Tip: Vowels are the letters, A, E, I, O, and U.
     consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.
     */
    func test_vowelsAndConsonants_OK() {

        let response1 = StringChallenge.VowelsConsonants(vowels: 6, consonants: 15)
        XCTAssertEqual(challenge.vowelsAndConsonants(text: "Swift Coding Challenges"), response1)
        
        let response2 = StringChallenge.VowelsConsonants(vowels: 4, consonants: 7)
        XCTAssertEqual(challenge.vowelsAndConsonants(text: "Mississippi"), response2)
    }
}
