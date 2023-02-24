//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Fabian Josue Rodriguez Alvarez on 24/2/23.
//

import XCTest

@testable import Calculator //To use the Calculatro Project Functions.

//Remove all test cases by default, so we can add a new one.
final class CalculatorTests: XCTestCase {
    
    private var calculator: Calculator!
    
    //This function allow us to declare or instanciate values or variables, before the tests run.
    //By default, Xcode adds "class" to this function. It has to be removed.
    override func setUp() {
        super.setUp()
        
        self.calculator = Calculator()
    }
    
    //All test function have to start with "test" in the function name.
    func test_addTwoNumbers_OK() {
        
        let result = self.calculator.add(2, 3)
        
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
        
        let result = self.calculator.substract(3, 1)
        
        XCTAssertEqual(result, 2)
    }
    
    
    //This function runs after each Test run.
    override func tearDown() {
        super.tearDown()
        
        /*
         Esta funcion sirve como para cuando utilizamos "UserDefaults", posiblemente sean cambiados algunos cambios, entonces utilizamos
         esta funcion para devolver cambios o borrar valores que no deberian conservarse.
         */
        UserDefaults().removeObject(forKey: "anything") //Example.
    }
}
