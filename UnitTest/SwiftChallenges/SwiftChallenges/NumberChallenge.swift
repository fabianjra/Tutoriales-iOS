//
//  NumberChallenge.swift
//  SwiftChallenges
//
//  Created by Fabian Rodriguez on 20/6/23.
//

import Foundation

public class NumberChallenge {
    
    /*
     16: Fizz Buzz
     
     Write a function that counts from 1 through 100,
     and prints “Fizz” if the counter is evenly divisible by 3,
     “Buzz” if it’s evenly divisible by 5,
     “Fizz Buzz” if it’s even divisible by three and five,
     or the counter number for all other cases.
     */
    func fizzBuzz() {
        
        for i in 1...100 {
            
            if i % 3 == 0 && i % 5 == 0 {
                print("\(i): Fizz Buzz")
                
            } else if i % 3 == 0 {
                print("\(i): Fizz")
                
            } else if i % 5 == 0 {
                print("\(i): Buzz")
                
            } else {
                print(i)
            }
        }
    }
    
    /*
     17: Generate a random number in a range
     
     Write a function that accepts positive minimum and maximum integers, and returns a random
     number between those two bounds, inclusive.
     */
    func generateRandomNumberInRange(min: Int, Max: Int) -> Int {
        
        let randomInRange = Int.random(in: min...Max)
        
        return randomInRange
    }
    
    /*
     18: Recreate the pow() function
     
     Create a function that accepts positive two integers, and raises the first to the power of the
     second.
     
     Tip: If you name your function myPow() or challenge18(), you’ll be able to use the built-in
     pow() for your tests. The built-in pow() uses doubles, so you’ll need to typecast.
     */
    func recreatePow(number: Int, times: Int) -> Int {
        
        //precondition(number > 0 && times > 0, "Should be higher than zero")
        
        guard number > 0, times > 0 else { return 0 }
        
        var result = 1
        
        for _ in 0..<times {
            
            result *= number
        }
        
        return result
    }
}
