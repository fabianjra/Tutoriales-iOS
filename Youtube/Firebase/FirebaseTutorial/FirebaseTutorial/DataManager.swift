//
//  DataManager.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation
import Firebase

class DataManager: ObservableObject, Equatable {
    
    @Published var dogs: [Dog] = []
    
    init() {
        //fetchDogsPersistance()
    }
    
    static func == (lhs: DataManager, rhs: DataManager) -> Bool {
        return lhs.dogs == rhs.dogs
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
                    let id = data["id"] as? Int ?? 0
                    let breed = data["breed"] as? String ?? ""
                    
                    let dog = Dog(id: id, breed: breed)
                    self.dogs.append(dog)
                }
            }
        }
    }
    
    func addDog(_ breed: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Dogs").document()
        
        ref.setData(["breed": breed, "id": Int.random(in: 10..<999999)]) { error in
            
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetchDogsPersistance() {
        //dogs.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Dogs")
        
        ref.addSnapshotListener { snapshot, error in
            
            guard let dogs = snapshot?.documents else {
                debugPrint(error?.localizedDescription ?? "NO DATA")
                return
            }
            
            var arreglo: [Dog] = []
            
            //Obtiene los datos de la coleccion "Dogs" y los recorre:
            for dog in dogs {
                let data = dog.data()
                
                //parsea las propiedades:
                let id = data["id"] as? Int ?? 0
                let breed = data["breed"] as? String ?? ""
                
                let dog = Dog(id: id, breed: breed)
                arreglo.append(dog)
            }
            
            self.dogs = arreglo
            arreglo.removeAll()
        }
    }
}
