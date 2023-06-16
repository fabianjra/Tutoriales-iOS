// SWIFT CODING CHALLENGES: Strings - Book edition 2019

import XCTest

final class SwiftChallengesStrings: XCTestCase {
    
    let letters: String

    //This function allow us to declare or instanciate values or variables, before the tests run.
    //By default, Xcode adds "class" to this function. It has to be removed.
    override func setUp() {
        super.setUp()
        
        self.letters = "Fabian"
    }
    
    //This function runs after each Test run.
    //For example: Can be used to erase some storage in "UserDefaults".
    override func tearDown() {
        super.tearDown()
    }
    
    //All test function have to start with "test" in the function name.

    /*
     1: Are the letters unique
     
     Write a function that accepts a String as its only parameter, and returns true if the string has
     only unique letters, taking letter case into account.
     */
    func test_uniqueLetters(letters: String) {
        
        let isUnique: Bool = false
        
        if letters.isEmpty {
            
            
        }
        
        XCTAssertEqual(isUnique, true)
    }
    
    assert(uniqueLetters(letters: "Fabian") == true)
}
