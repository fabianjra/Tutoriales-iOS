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

var arrayString = ["fabian", "josue", "rodriguez", "alvarez"]
var arrayInt = [25, 30, 22, 10, 100, 1, 481]
var arrayCombinado: [Any] = ["texto1", 50, true, 60.11, false, "texto final 2"]
var arrayConNulos: [Any?] = [nil, 101, true, 5.9, nil, "texto con contenido"]


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
    //var multiDimensionalArray : [[Any]] = [[1,2,true], ["fabian",5,6],[7,"josue",9]]
    let multiDimensionalArray = [arrayString, arrayCombinado].joined()
    var singleArray = multiDimensionalArray.compactMap { $0 }
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
higherOrder_FlatMap()

// ------------------------------------------------------------------------------------------ //
