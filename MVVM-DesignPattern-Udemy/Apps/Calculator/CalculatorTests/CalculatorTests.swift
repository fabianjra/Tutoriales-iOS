//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Fabian Josue Rodriguez Alvarez on 24/2/23.
//

import XCTest

@testable import Calculator //To use the Calculatro Project Functions.

final class CalculatorTests: XCTestCase {
    
    //Remove all test cases by default, so we can add a new one.
    
    //All test function have to start with "test" in the function name.
    func test_addTwoNumbers_OK() {
        
        let calculator = Calculator()
        let result = calculator.add(2, 3)
        
        //Compare if the result is equal to the constant (es una suma, por eso deberia ser 5).
        XCTAssertEqual(result, 5)
    }
    
    /*
     //All test function have to start with "test" in the function name.
     func test_addTwoNumbers_FAIL() {
     
     let calculator = Calculator()
     let result = calculator.add(2, 3)
     
     XCTAssertEqual(result, 6)
     }
     */
    
    func test_substract_OK() {
        let calculator = Calculator()
        let result = calculator.substract(3, 1)
        
        XCTAssertEqual(result, 2)
    }
}
