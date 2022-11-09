import UIKit

//MARK: - OPTIONALS:

class UnwrapExample {
    
    //2 maneras de declararlos.
    var name: String?
    var name2: Optional<String>
    
    init() {
        self.name = ""
        self.name2 = ""
    }
}

private func Optionals(){
    DispatchQueue.global().async {
        sleep(2)
        print("Sync inside")
    }
    
    print("Outside")
}


//MARK: - HIGHER-ORDER FUNCTION:

/*
 In mathematics and computer science, a higher-order function is a function that does at least one of the following:
 
 – takes one or more functions as arguments (i.e. procedural parameters),
 
 – returns a function as its result.
 
 All other functions are first-order functions.
 */

//Higher order functions are based on closures.

/*
 Higher order functions are applied to arrays, dictionaries and sets in swift.
 In simple way we use higher order functions in place of writing so many for loops to loop through arrays, dictionaries and sets.
 
 List of higher order functions:
 
 Map
 CompactMap
 FlatMap
 Reduce
 Filter
 Contains
 Sorted
 ForEach
 removeAll
 */

var arrayString = ["fabian", "", "rodriguez", "alvarez", "pedro", "alfonso", "alvarado", "facundo", "roberto", "", "patricio"]
var arrayInt = [25, 30, 22, 10, 100, 1, 481]
var arrayCombinado: [Any] = ["texto1", 50, true, 60.11, false, "texto final 2", false, "entre boleanos", true, 50]
var arrayConNulos: [Any?] = [nil, 101, true, 5.9, nil, "texto con contenido", false, "entre boleanos", true, 50]


private func CONCAT(){
    let newArrayJoined = [arrayString, arrayCombinado].joined()
    
    print(newArrayJoined)
    
    newArrayJoined.forEach { item in
        print(item)
    }
}
//CONCAT()

// ------------------------------------------------------------------------------------------ //

//Map:
/*
 It will loop through each and every element in collection,
 then perform operations provided by us and returns new collection.
 */
private func higherOrder_Map(){
    
    let arrayUppercased = arrayString.map { $0.uppercased() }
    print(arrayUppercased)
}
//higherOrder_Map()

// ------------------------------------------------------------------------------------------ //

//CompactMap:
/*
 In map function we may get nil values, sometimes we need to check if the value is nil or not.
 While compactMap will return only valid values without nil values. Let’s see with an example
 */
private func higherOrder_CompactMap(){
    
    //Que no sean nulos (gracias a compactMap y solo los String
    let newCompactArray = arrayConNulos.compactMap { $0 as? String }
    print(newCompactArray)
}
//higherOrder_CompactMap()

// ------------------------------------------------------------------------------------------ //

//FlatMap:
private func higherOrder_FlatMap(){
    
    //When we have multidimensional collections and wants to merge them as one then we can use flatmap.
    var multiDimensionalArray : [[Any]] = [[1,2,true], ["fabian",5,6],[7,"josue",9]]
    //let multiDimensionalArray = [arrayString, arrayCombinado].joined()
    var singleArray = multiDimensionalArray.flatMap { $0 }
    print(singleArray)
    
    /*
     If we have 2 single arrays and wants to merge them as multi dimensional array,
     then also we can use map and flatmap combined.
     */
    let resultArray = arrayString.map { first in
        
        arrayInt.map { second in
            
            (first, second)
        }
    }.flatMap { $0 }
    
    print(resultArray)
}
//higherOrder_FlatMap()

// ------------------------------------------------------------------------------------------ //

//Reduce:
private func higherOrder_Reduce(){
    
    //reduce function takes a collection and converts it into a single value.
    var sumArrayElements : [Int] = [1,1,1,2]
    
    /*
     It always takes 2 values , first value is the result of the previous operation provided in the closure. Second values is the each value from the collection. After reduce , we have braces with value 0 like reduce(0) , 0 is the initial/first value in the closure, change 0 value to another value and see the results , then we can clearly understand what is initial value.
     */
    //Empieza con un numero, el cual usa como base para empezar a sumarle.
    var sumValue = sumArrayElements.reduce(2) { firstValue, secondValue in
        
        return firstValue + secondValue
    }
    
    //we can write above function in short way: $0 = firstValue. $1 = secondValue.
    var anotherSumValue = sumArrayElements.reduce(2) { $0 + $1 }
    print(anotherSumValue)
    
    print(sumValue)
}
//higherOrder_Reduce()

// ------------------------------------------------------------------------------------------ //

//Filter:
//To apply filters in the collection , we use filter function.
private func higherOrder_Filter(){
    
    //Filtrar solo por tipos booleanos
    var soloBooleanos = arrayCombinado.filter{ $0 as? Bool == true}
    print(soloBooleanos)
    
    var multiplesValidaciones = arrayCombinado.filter{ ($0 as? String)?.isEmpty == false && $0 as? String == "texto1" }
    print(multiplesValidaciones)
}
//higherOrder_Filter()

// ------------------------------------------------------------------------------------------ //

//Contains:
//To check if the collection elements contains provided value we use Contains
private func higherOrder_Contains(){
    
    var filtrado = arrayString.filter{ $0.isEmpty || $0.contains("ro") }
    
    /*
     var filtrado = arrayString.filter { String in
     String.isEmpty || String.contains("ro")
     }
     */
    
    print(filtrado) //["", "rodriguez", "pedro", "roberto", ""]
}
//higherOrder_Contains()

// ------------------------------------------------------------------------------------------ //

//Sorted:
//To sort elements either in ascending or descending order we use sorted function
private func higherOrder_Sorted(){
    
    // default sort is ascending order
    let sortedString = arrayString.sorted()
    print(sortedString)
    
    // we can also write in this way
    let mySorterArray = arrayInt.sorted { $0 < $1 }
    print(mySorterArray)
    
    // another way to write , which is simpler way is
    let descSortArray = arrayInt.sorted(by: <)
    print(descSortArray)
}
//higherOrder_Sorted()

// ------------------------------------------------------------------------------------------ //

//ForEach:
//for each works like for loop in swift, only difference is we can’t use continue or break inside for loop,
//so it will make sure we go through each and every element of collection
private func higherOrder_ForEach(){
    
    var upperCased: [String] = []
    
    arrayString.forEach {
        
        if $0.isEmpty == false {
            upperCased.append( $0.uppercased() )
        }
    }
    
    print(upperCased)
}
//higherOrder_ForEach()

// ------------------------------------------------------------------------------------------ //

//RemoveAll:
/*
 If we want to remove some occurrence of any sub string from a string or any element from collection which matches
 the condition then we can use removeAll
 */
private func higherOrder_RemoveAll(){
    
    //Remove Even numbers
    arrayInt.removeAll(where: {$0 % 2 != 0})
    print(arrayInt)
    
    //Remove Odd numbers
    arrayInt.removeAll(where: {$0 % 2 == 0})
    print(arrayInt)
    
    //Remove boolean types and nil
    arrayConNulos.removeAll(where: { $0 is Bool || $0 == nil })
    //print(arrayConNulos)
    
    arrayConNulos.forEach{ print($0!) } //ForceUnwrap, se eliminaron los nulos.
    
}
higherOrder_RemoveAll()
