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
}
