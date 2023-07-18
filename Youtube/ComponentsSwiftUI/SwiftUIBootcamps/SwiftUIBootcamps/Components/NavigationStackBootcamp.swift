//
//  NavigationStackBootcamp.swift
//  SwiftUIBootcamps
//
//  Created by Fabian Rodriguez on 13/7/23.
//

import SwiftUI

struct NavigationStackBootcamp: View {
    
    let fruits = ["Apple", "Grappe", "Watermelon", "Strawberry"]
    
    //Este array podria incluso inicializarse con un conjunto de Strings para iniciar con un grupo de pantallas navegadas.
    @State private var stackPath: [String] = []
    
    var body: some View {
        
        //Path: Va a almacenar todos los links a los que entren que sean String, en este caso el de frutas porque son de tipo String. No van a funcionar ahora los de tipo INT porque el navigationStack se le indico un path con un tipo de dato.
        NavigationStack(path: $stackPath) {
            
            ScrollView {
                VStack (spacing: 20) {
                    
                    //El path permite agregar un item al path, para que se navegue hacia ese item.
                    Button("Super segue!") {
                        //stackPath.append("Coconut")
                        
                        //Tambien es posible hacer un push de multiples pantallas a la vez:
                        stackPath.append(contentsOf: ["Mango", "Coconut", "Banana"])
                    }
                    
                    ForEach(0..<10) { hashable in
                        
                        //NAvigationLink ahora usara el hashable de INT para navegar, usando navigationDestination.
                        //De esta manera, la pantalla se renderiza hasta que se navegue a ella.
                        NavigationLink(value: hashable) {
                            Text("Next view number: \(hashable)")
                        }
                        
                        /*
                        //NOTE: NavigationLink is not lazy, the views inside are rendered in background when this main view is called.
                        NavigationLink(destination: {
                            SecondView(value: value)
                        }, label: {
                            Text("Next view number: \(value)")
                        })
                         */
                    }
                    
                    
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text("Fruit to navigate: \(fruit)")
                        }
                    }
                }
            }
            
            //.navigationTitle("Nav Bootcamp")
            //.navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Nav bootcamp", displayMode: .inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Go back") {
                        print("Pressed")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings") {
                        print("Pressed")
                    }
                }
            }
            
            //Hashable: Es del tipo donde se indica en el "for". En este caso, hashable es de tipo Int.
            .navigationDestination(for: Int.self) { hashable in
                SecondView(value: hashable)
            }
            .navigationDestination(for: String.self) { value in
                Text("Fruit selected: \(value) ")
            }
        }
    }
    
    func SecondView(value: Int) -> some View {
        
        print("View number: \(value)")
        
        return Text("View: \(value)")
    }
}

struct NavigationStackBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootcamp()
    }
}
