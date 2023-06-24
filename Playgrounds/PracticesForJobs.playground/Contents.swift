//*****************************************************************************
//  REVERSE NUMBERS
//*****************************************************************************

func reverse1(numbers: [Any]) -> [Any]{
    
    var result: [Any] = []
    
    //CompactMap will avoid nil values:
    var arrayInt = numbers.compactMap { $0 as? Int}
    
    result = arrayInt.sorted(by: > )
    
    return result
}

let numbers1: [Any] = [2, 4.5, "6", 10, false, "Fabian", 95]
print("Reverse 1. Original: \(numbers1)")
print(reverse1(numbers: numbers1))

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------


// INCOMPELTE:
func reverse2(numbers: Int) -> Int {
    
    //Convert Int to String
    var numberString = String(numbers)

    //Convert String to Array Strings
    var stringArray = Array(numberString)

    //Reverse the string
    var reversedString = stringArray.reduce("") { String([$1] + $0) }

    //Convert Array String to Array Int
    var arrayStringToInt = reversedString.compactMap { Int( String($0) ) }

    //Convert Array String to Int
    var arrayIntToInt = Int( arrayStringToInt.reduce("") { $0 + String($1) } ) ?? 0

    //Convert string to int
    var stringToInt = Int(reversedString) ?? 0
    
    return stringToInt //int
}

let numbers2 = 1239872
print("Reverse 2. Original: \(numbers2)")
print(reverse2(numbers: numbers2))

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

func reverse3(numbers: Int) -> String {
    
    var reversed = ""
    
    for number in numbers.description {
        
        reversed = "\(number)" + reversed
        //reversed = String(number) + reversed
    }
    
    return reversed
}

let numbers3 = 12498743
print("Reverse 3. Original: \(numbers3)")
print(reverse3(numbers: numbers3))


//*****************************************************************************
//  IN ARRAY, FIND THE SECOND LARGER NUMBER.
//*****************************************************************************

print("*************************************")
print("")

func secondLarger1(numbers: [Int]) -> Int {
    
    var HigherNumber = 0
    var secondiHigherNumber = 0
    
    for number in numbers {
        
        if number > HigherNumber {
            
            secondiHigherNumber = HigherNumber
            
            HigherNumber = number
            
        } else if number > secondiHigherNumber {
            
            secondiHigherNumber = number
        }
    }
    
    return secondiHigherNumber
}

let arrayNumbersLarger1 = [5, 10, 4, 99, 76, 88, 101]
print("ArrayLarger 1. Original: \(arrayNumbersLarger1)")
print(secondLarger1(numbers: arrayNumbersLarger1))

//----------------------------------------------------------------------------
print("*************************************")
print("")
//----------------------------------------------------------------------------

func secondLarger2(numbers: Array<Int>) -> String {
    
    var max1 = 0
    var max2 = 0
    
    for number in numbers {
        
        if number > max1 {
            
            max2 = max1
            max1 = number
            
        } else if number > max2 {
            max2 = number
        }
    }
    
    return String(max2)
}

let arrayNumbersLarger2: Array = [10, 20, 30, 5, 11, 54, 90, 44, 34, 35]
print("ArrayLarger 2. Original: \(arrayNumbersLarger2)")
print(secondLarger2(numbers: arrayNumbersLarger2))


//----------------------------------------------------------------------------
print("*************************************")
print("")
//----------------------------------------------------------------------------


let texto = "Fabian Rodriguez"

print(texto.reversed())

print(String(texto.reversed()))
