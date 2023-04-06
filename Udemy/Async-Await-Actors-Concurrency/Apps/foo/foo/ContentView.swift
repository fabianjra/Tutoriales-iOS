//
//  ContentView.swift
//  foo
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/4/23.
//

import SwiftUI

struct Counter {
    var value: Int = 0
    
    mutating func increment() -> Int {
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
                    
                    var counter = counter
                    
                    debugPrint("Num incrementado: \(counter.increment())")
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
