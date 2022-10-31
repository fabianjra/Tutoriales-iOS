import UIKit
import RxSwift

_ = Observable.from([1, 2, 3, 4, 5])

//Just contiene un solo objeto.
let observable1 = Observable.just(1)

//Permite crear un observable de un set de elementos.
let observable2 = Observable.of(1, 2, 3)

//Crear un observable de un array.
let observable3 = Observable.of([1, 2, 3])

//Se usa para un array especificamente.
//Of es para la funcion de un array, pero from es para crear el array de forma individual.
let observable4 = Observable.from([1, 2, 3, 4, 5])

//Permite obtener el dato del obejto al que se esta observando.
//Subscirbe permite obtener la secuencia de eventos (valores contenidos en el Observable).
observable4.subscribe { event in
    //print(event)
    /*
     next(1)
     next(2)
     next(3)
     next(4)
     next(5)
     completed
     */
    
    //Se obtiene el valor contenido, realizando un Unwrap.
    if let element = event.element {
        print(element)
    }
}

