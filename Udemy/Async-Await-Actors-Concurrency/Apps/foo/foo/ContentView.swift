//
//  ContentView.swift
//  foo
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/4/23.
//

import SwiftUI

//1: Se cambia struct por actor.
//Actor permite que se ejcute esta clase o struct, sobre un solo Thread.
//De esta manera, un solo thread maneja el incremento del enumarador, asi que no va a ir brincando de thread en thread para aumentar su valor, utilizando "DispatchQueue.concurrentPerform".
actor Counter {
    var value: Int = 0
    
    //2: Se quita el mutating, porque ya no es un struct
    /*mutating*/ func increment() -> Int {
        value += 1
        return value
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            
            Button {
                
                let counter = Counter()
                
                //Hacerlo de esta manera, ejecuta el incremetador de manera concurrente y nunca tendra un order definido.
                DispatchQueue.concurrentPerform(iterations: 100) { _ in
                    
                    //4: Debido a que se usa await, se debe ejecutar en Task
                    Task {
                        //3: Se agrega await, porque ahora es async. Esto debido a Actor
                        debugPrint("Num incrementado: \(await counter.increment())")
                    }
                }
                
            } label: {
                Text("Incrementar")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
