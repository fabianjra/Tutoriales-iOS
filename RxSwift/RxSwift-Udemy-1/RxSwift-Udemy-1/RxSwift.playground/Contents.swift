import UIKit
import RxSwift

//====================================================================================================================//
//        BASICS      //
//====================================================================================================================//

_ = Observable.from([1, 2, 3, 4, 5])

//Just contiene un solo objeto.
let observable1 = Observable.just(1)

//Permite crear un observable de un set de elementos.
let observable2 = Observable.of(1, 2, 3)

private func Observable3(){
    
    //Crear un observable de un array.
    let observable3 = Observable.of([1, 2, 3])
    
    observable3.subscribe{ event in
        
        
        guard let element = event.element else {
            print("Vacio")
            return
        }
        
        print(element)
        //[1, 2, 3]
    }
    
}
//Observable3()

private func Observable4(){
    
    //Se usa para un array especificamente.
    //FROM: Convierte los elementos del array a items individuales. A diferencia de "of" que hace un observable de todo el array como un unico elemento.
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
        
        //Se obtiene el valor contenido, realizando un Unwrap, porque es opcional
        if let element = event.element {
            print(element)
        }
        else
        {
            print("Vacio")
        }
        /*
         1
         2
         3
         4
         5
         Vacio
         */
    }
    
    //"onNext": La forma mas facil o correcta de acceder al elemento especificamente.
    let subscription4 = observable4.subscribe(onNext: { element in
        print("onNext element: ", element)
    })
    
    //"DISPOSE": Cuando se usa un subscriber, él se va a quedar escuchado u observando. Se tiene que eliminar con dispose.
    //Si no se hace dispose, podria provocarse un memory leak.
    subscription4.dispose()
}
//Observable4()


//====================================================================================================================//
//        DISPOSE      //
//====================================================================================================================//

/// Como utilizar DisposeBag correctamente para un Subscribe.
private func disposeFunction1(){
    
    //Se crea el disposeBag para poder hacerle Dispose al observable.
    let disposeBag = DisposeBag()
    
    //Un subscribe debe ser siempre disposable, por medio de un "DisposeBag".
    Observable.of("A", "B", "C")
        .subscribe{
            print($0)
        }.disposed(by: disposeBag) //Se utiliza el diposeBag para eliminarlo.
    
}//End function
//disposeFunction1()


//====================================================================================================================//
//        "Create" Observable      //
//====================================================================================================================//

/// Una segunda manera de crear un Observable.
/// Crear el Observable con "create", permite describir cada paso que se ejecuta.
private func observableExample2(){
    
    let disposeBag = DisposeBag()
    
    //Esta manera de instanciar, brinda un oberver.
    Observable<String>.create { observer in
        
        observer.onNext("Fabian, unico elemento como string")
        observer.onCompleted()
        observer.onNext("Texto string despues de onCompleted()") //No se ejecuta, porque antes se llama a "onCompleted()"
        
        //"Create": Obliga a retornar un disposable.
        return Disposables.create()
    }
    //Se puede crear el subscriber desde el mismo Observable
    .subscribe(onNext: { element in
        
        print("1: Se imprimie el elemento de onNext:", element)
        
    }, onError: { error in
        
        print("2: Se ejecuto onError: ", error)
        
    }, onCompleted: {
        
        print("3: Ejecucion de onCompleted")
        
    }, onDisposed: {
        
        print("4: Ejecucion de onDisposed")
        
    })
    .disposed(by: disposeBag)
    
}//End function
//observableExample2()

//====================================================================================================================//
//        SUBJECTS      //
//====================================================================================================================//

/*
 They are "Observables" as well the "Observers".
 Tipos de Subjects:
 
 1: Publish subjects
 2: Replay subject
 3: BehaviorRelay
 4: Variable
*/

private func publishSubject_1(){
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    
    //Este evento no se va a mostrar, porque aun no se ha realizado la subscripcion.
    subject.onNext("onNext 1 - Publish Subject")
    
    //"Subscribe": Es el encargado de realizar algo, ya que se subscribe y está a la escucha del PublishSubject.
    //Sin subsribe, no pasa nada.
    //El subsribe se realiza sobre el mismo objeto del Publish.
    subject.subscribe{ event in
        
        print("Esta es la subscripcion: ", event)
    }
    
    //Estos elementos si se muestran en el print, porque ya existe una subscripcion.
    subject.onNext("onNext 2: Despues de que el subscriber se crea")
    subject.onNext("onNext 3: Tercer evento.")
    
    subject.onCompleted() //se da por completado el Observer, pero se muestra como un evento más.
    
    subject.onNext("onNext 4: despues de completed") //Este no se ejecuta porque está despues del onCompleted().
    
    subject.dispose() //Se elimina el publish Subject
    
    subject.onNext("onNext 5: ultimo") //Este no se ejecuta porque está despues del dispose.
    
}//End function
publishSubject_1()
