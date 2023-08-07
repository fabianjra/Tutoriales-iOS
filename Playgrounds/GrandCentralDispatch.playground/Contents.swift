import Foundation

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

private func sleeping(){
    DispatchQueue.global().async {
        sleep(2)
        print("Sync inside")
    }
    
    print("Outside")
}

//sleeping()

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
 -(default)
 -utility
 -background.
 
 User-interactive:
 This represents tasks that must complete immediately to provide a nice user experience.
 Use it for UI updates, event handling and small workloads that require low latency.
 The total amount of work done in this class during the execution of your app should be small.
 This should run on the main thread.
 
 User-initiated:
 The user initiates these asynchronous tasks from the UI.
 Use them when the user is waiting for immediate results and for tasks required to continue user interaction.
 They execute in the high-priority global queue.
 
 Utility:
 This represents long-running tasks, typically with a user-visible progress indicator.
 Use it for computations, I/O, networking, continuous data feeds and similar tasks.
 This class is designed to be energy efficient.
 This gets mapped into the low-priority global queue.
 
 Background:
 This represents tasks the user isn’t directly aware of.
 Use it for prefetching, maintenance and other tasks that don’t require user interaction and aren’t time-sensitive.
 This gets mapped into the background priority global queue.
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
    
    DispatchQueue.global().async {
        print("final")
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
//delayTask()

/*
 Using DispatchGroup
 */
func hello1(completion: @escaping (String) -> Void) {
    //Llamado a un API.
    DispatchQueue.global().async {
        sleep(1)
        print("Prueba en dispatch Group 1")
    }
}

func hello2(completion: @escaping (String) -> Void) {
    //Llamado a un API.
    DispatchQueue.global().async {
        sleep(3)
        print("Prueba en dispatch Group 2")
    }
}

//Permite ir a funciones y procesarlas una por una y no avanzar hasta que se haya terminado el proceso anterior.
//Esto es para funciones asincronas, ya que no siempre van a tardar lo mismo y una funcion puede ser mas rapida que otra.
//Los procesos van en cadena.
private func usingDisptachGroup() -> Bool{
    
    var buttonLogin: Bool = false
    
    let group = DispatchGroup()
    
    group.enter() //Inicio del Dispatch group.
    print("Enter function hello1")
    
    hello1 { item in
        
        //Hacer alguna logica, con el resutlado obtenido de la funcion llamada
        group.leave() //Finaliza el group.
        print("Leave hello1")
    }
    
    group.enter() //Inicio del Dispatch group, parte 2
    print("Enter function hello2")
    
    hello2 { item in
        //Hacer alguna logica, con el resutlado obtenido de la funcion llamada
        group.leave() //Finaliza el group.
        print("Leave hello2")
    }
    
    group.notify(queue: .main) {
        print("Disptach group notifica que se finalizaron todos los procesos. Bool: \(buttonLogin)")
        buttonLogin = true //Do something when all the group is ready.
    }
    
    return buttonLogin
}
let result = usingDisptachGroup()
print("Estado del boton: \(result)")
