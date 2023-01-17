//MARK: - GENERICS

/*
 Swift is built-up with generics, for example you can use Arrays or dictionaries with any kind of type values or with a type value specifically.
 */

//Arrays:
let intArray = [1, 2, 3, 4]
let stringArray = ["Fabian", "Josue", "Rodriguez", "Alvarez"]

var doubleArray = Array<Double>() //empty array
var floatArray: Array<Float> = [1.0, 3.4, 5.7]

//Dictionaries
let stringIntDicionary = ["1": 1, "2": 2, "3": 3]
let intIntDictionary = [1: 1, 2: 2, 3: 3]

var aDictionary = Dictionary<String, Int>()
var bDictionary: Dictionary<String, String> = ["nombre": "Fabian", "segundoNombre": "Josue", "primerApellido": "Rodriguez"]

//****************************************************************************************//

//EXAMPLE:
//Instead of using as parameters: "String, Int, Double, Float, etc.", use Generic:
//The placeholder "<T>", indicates that there is only 1 type for parameters.
func swap<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

func call_Swap() {
    var a = 5
    var b = 10

    var c = "50"
    var d = "60"

    swap(&a, &b)
    swap(&c, &d)
    print(a)
    print(b)
    print(c)
    print(d)
}
//call_Swap()


//Using 2 types of parameters:, for example for using "int" as A parameter and "String" as B parameter.
func genericFunction<T, U>(aParam: T, bParam: U) {
     
    print(aParam)
    print(bParam)
}

func call_GenericFunction() {
    
    let primero = 5.78
    let segundo = "segundo parametro"
    genericFunction(aParam: primero, bParam: segundo)
}
//call_GenericFunction()


//****************************************************************************************//

//Crating a Generic Stack:
struct Stack<Element> {
    
    private var items = [Element]()
    
    mutating func push(_ element: Element){
        items.append(element)
    }
    
    //Return optional, because could be nil.
    mutating func pop() -> Element?{
        items.popLast()
    }
}

func call_Stack() {
    
    var stack1 = Stack<Int>()
    stack1.push(5)
    stack1.push(10)

    //if nil: returns 0
    print(stack1.pop() ?? 0) // 5
    print(stack1.pop() ?? 0) // 10

    //Stack: Any
    var stackAny = Stack<Any>()
    stackAny.push("fabian")
    stackAny.push(10)
    stackAny.push(true)
}
//call_Stack()

//****************************************************************************************//

//SumDigits
/*  Create the function sumDigits that return the sum of digits in a given sequence of Type 'T' using generics.
 The input can either be a string containing the digits to sum or an array of Integers
 i.e.
 inputStr = "12343" >> then 1 + 2 + 3 + 4 + 3  >> then output -> 13
 
 inputArr = [4, 2, 5, 4] >> then 4 + 2 + 3 + 4 >> then output -> 15
 
 The String or array inputs can only contain Digits 0-9, no negative values allowed
 The input MUST NOT be modified before being sent as parameter to the sumDigits function
 */


/// T used inside the angle bracket <> is called the type parameter.
/// And based on the type of the value passed to the function, the T is replaced by that data type (Int, String, and so on).
/// Note: We can provide any name to the type parameter: <S>, <Element>, etc. But generally, we use T.
/// - Parameter input:
/// - Throws:
/// - Returns: Suma de los numeros
func SumDigits<T>(input: T) {
    
}
