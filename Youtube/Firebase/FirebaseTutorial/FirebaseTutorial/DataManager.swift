//
//  DataManager.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation
import Firebase

class DataManager: ObservableObject {
    @Published var dogs: [Dog] = []
    
    init() {
        fetchDogs()
    }
    
    func fetchDogs() {
        dogs.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Dogs")
        
        //Llama a la base de datos:
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                debugPrint(error?.localizedDescription ?? "ERROR AL OBTENER DOGS")
                return
            }
            
            //Obtiene los datos de la coleccion "Dogs" y los recorre:
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    //parsea las propiedades:
                    let id = data["id"] as? String ?? ""
                    let breed = data["breed"] as? String ?? ""
                    
                    let dog = Dog(id: id, breed: breed)
                    self.dogs.append(dog)
                }
            }
        }
    }
}
