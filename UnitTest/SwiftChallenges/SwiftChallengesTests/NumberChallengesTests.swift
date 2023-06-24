//
//  NumberChallengeTest.swift
//  SwiftChallengesTests
//
//  Created by Fabian Rodriguez on 20/6/23.
//

import XCTest
@testable import SwiftChallenges

final class NumberChallengesTests: XCTestCase {

    let challenge: NumberChallenge = NumberChallenge()

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
     16: Fizz Buzz
     
     Write a function that counts from 1 through 100,
     and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.
     */
    func test_uniqueLetters_OK() {
        
        /*
         Sample input and output:
         
         • 1 should print “1”
         • 2 should print “2”
         • 3 should print “Fizz”
         • 4 should print “4”
         • 5 should print “Buzz”
         • 15 should print “Fizz Buzz”
         */
        XCTAssertNotNil(challenge.fizzBuzz())
    }
    
    /*
     17: Generate a random number in a range
     
     Write a function that accepts positive minimum and maximum integers, and returns a random
     number between those two bounds, inclusive.
     */
    func test_generateRandomNumberInRange_OK() {
        
        XCTAssertLessThanOrEqual(challenge.generateRandomNumberInRange(min: 1, Max: 5), 5)
        XCTAssertGreaterThanOrEqual(challenge.generateRandomNumberInRange(min: 1, Max: 5), 1)
        
        XCTAssertLessThanOrEqual(challenge.generateRandomNumberInRange(min: 8, Max: 10), 10)
        XCTAssertGreaterThanOrEqual(challenge.generateRandomNumberInRange(min: 8, Max: 10), 8)
        
        XCTAssertLessThanOrEqual(challenge.generateRandomNumberInRange(min: 12, Max: 12), 12)
        XCTAssertGreaterThanOrEqual(challenge.generateRandomNumberInRange(min: 12, Max: 12), 12)
        
        XCTAssertNotEqual(challenge.generateRandomNumberInRange(min: 1, Max: 2), 3)
        
        XCTAssertNotEqual(challenge.generateRandomNumberInRange(min: 5, Max: 10), 1)
        
        XCTAssertNotEqual(challenge.generateRandomNumberInRange(min: 10, Max: 11), 9)
    }
    
}
