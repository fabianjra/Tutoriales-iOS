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

//MARK: - GRAND CENTRAL DISPATCH:

//Serial Queue:
//The tasks start once the past task finishes.
private func SerialQueue(){
    
    //Attributes: If you omit that attribute, the dispatch queue executes tasks serially.
    let serialQueue = DispatchQueue.init(label: "swiftbeta.serial.queue")
    
    serialQueue.async {
        print("Started task 1...")
        print("Finished task 1...")
    }
    
    serialQueue.async {
        print("Started task 2...")
        print("Finished task 2...")
    }
    
    serialQueue.async {
        print("Started task 3...")
        print("Finished task 3...")
    }
}
//SerialQueue()

//Concurrent Queue.
//In this case, the 3 tasks starts at the same time.
//You dont know when a task starts and finishs, because this is controlled by GCD.
private func ConcurrentQueue(){
    
    let concurrentQueue = DispatchQueue.init(label: "swiftbeta.concurrent.queue", attributes: .concurrent)
    
    concurrentQueue.async {
        print("Started task 1...")
        print("Finished task 1...")
        print("1")
    }
    
    concurrentQueue.async {
        print("Started task 2...")
        print("Finished task 2...")
        print("2222222222222222222222222222")
    }
    
    concurrentQueue.async {
        print("Started task 3...")
        print("Finished task 3...")
        print("33333333333333333333333333333333333333333333333333333333333333333333333333333")
    }
}
//ConcurrentQueue()

// ------------------------------------------------------------------------------------------ //

//3 types of Queues

//1: Main queue
//es el thread principal de la app, podemos acceder a él desde cualquier punto de la app porque es accesible globalmente.
private func MainQueue(){
    DispatchQueue.main.async {
        print("Reload collectionView")
    }
}
//MainQueue()

/*
 2: Global queues.
 son colas que se comparten por todo el sistema.
 Tenemos distintas prioridades:
 -high
 -default
 -low
 -brackground.
 
 Cuando enviamos tareas a las global queues especificamos un Quality of Service (QoS),
 que determina esas prioridades que acabamos de mencionar:
 -userInteractive
 -userInitiated
 -utility
 -background.
 
 User-interactive: This represents tasks that must complete immediately to provide a nice user experience. Use it for UI updates, event handling and small workloads that require low latency. The total amount of work done in this class during the execution of your app should be small. This should run on the main thread.
 
 User-initiated: The user initiates these asynchronous tasks from the UI. Use them when the user is waiting for immediate results and for tasks required to continue user interaction. They execute in the high-priority global queue.
 
 Utility: This represents long-running tasks, typically with a user-visible progress indicator. Use it for computations, I/O, networking, continuous data feeds and similar tasks. This class is designed to be energy efficient. This gets mapped into the low-priority global queue.
 
 Background: This represents tasks the user isn’t directly aware of. Use it for prefetching, maintenance and other tasks that don’t require user interaction and aren’t time-sensitive. This gets mapped into the background priority global queue.
 */
private func GlobalQueue(){
    
    // Highest priority
    DispatchQueue.global(qos: .userInteractive).async {
        print("UserInteractive: termina 1") //Por defecto es la primera.
    }
    
    // High priority
    DispatchQueue.global(qos: .userInitiated).async {
        print("UserInitiated: termina 2")
    }
    
    // low priority
    DispatchQueue.global(qos: .utility).async {
        print("Utility: termina 3")
    }
    
    // Lowest priority
    DispatchQueue.global(qos: .background).async {
        print("Background: termina 4")
    }
}
//GlobalQueue()

/*
 3: Custom queues.
 Son colas que creamos nosotros (could by serial or concurrency).
 El anterior ejemplo de colas en serie y concurrente sería un ejemplo de custom queues.
 */
private func CustomQueue(){
    
    let concurrentQueue = DispatchQueue(label: "swiftbeta.concurrent.queue", attributes: .concurrent)
    
    concurrentQueue.async {
        print("Started task 1...")
        print("Finished task 1...")
    }
}
//CustomQueue()

//En GCD puedes lanzar colas de forma síncrona o asíncrona. Depende de como lo quieras implementar
private func SyncAndAsyncQueue(){
    
    // Usa async para ejecutar ese bloque de código de forma asíncrona
    DispatchQueue.global(qos: .default).async {
        print("Puede continuar con el siguiente proceso meintras este termina")
    }
    
    // Usa sync para ejecutar ese bloque de código de forma síncrona
    DispatchQueue.global(qos: .background).sync {
        print("Espera a que el proceso termine para continuar, es sincrono.")
    }
}
//SyncAndAsyncQueue()

/*
 Uno de los métodos que tenemos con DispatchQueue es el de poder retrasar la ejecución de una tarea.
 Es tan simple como usar el método asyncAfter y especificar el tiempo en segundos
 */
private func delayTask(){
    
    DispatchQueue.main.async {
        print("Message")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("Message printed after 2 seconds")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        print("Message printed after 4 seconds")
    }
    
    /* El resultado es:
     Message
     Message printed after 2 seconds
     Message printed after 4 seconds
     */
}
delayTask()

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
//higherOrder_RemoveAll()
