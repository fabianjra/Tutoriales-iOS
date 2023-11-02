//
//  AuthViewModel.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 1/11/23.
//

import Firebase
import FirebaseFirestoreSwift

//Ut ilizado para validar si un formalario es valido o no
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

//El AuthViewModel es el encargado de toda las funciones de autenticar los usuarios.
//Tambien de enviar notificaciones al UI, Newtwroking y demas.

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // Firebase Object.
    @Published var currentUser: User? // Model.
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            do {
                try await fetchUser()
                
            } catch {
                print("error catch: \(error.localizedDescription)")
            }
            
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        self.userSession = result.user
        try await fetchUser()
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws { 
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user //La actaulizacion de la variable Published esta sucediendo en Background Thread. Debe hacerse sobre Main.
        
        let user = User(id: result.user.uid, fullname: fullname, email: email)
        
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection(Const.USER_COLLECTION).document(user.id).setData(encodedUser)
        
        //Se asigna el usuario en Firebase al Publish que se esta manejando en local:
        try await fetchUser()
        
        //Otra manera de asignar el CurrentUser sin tener que volver a ir a Firebase es la siguiente:
//        self.currentUser = user
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
        self.currentUser = nil
        self.userSession = nil
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot =  try await Firestore.firestore().collection(Const.USER_COLLECTION).document(uid).getDocument()
        
        self.currentUser = try snapshot.data(as: User.self)
        
        print("Current usuario es: \(self.currentUser ?? User(id: "", fullname: "", email: ""))")
    }
}


private struct Const {
    public static let USER_COLLECTION: String = "user"
}
