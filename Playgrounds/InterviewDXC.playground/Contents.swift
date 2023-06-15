
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

//*****************************************************************************
//*****************************************************************************


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

//*****************************************************************************
//*****************************************************************************


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
