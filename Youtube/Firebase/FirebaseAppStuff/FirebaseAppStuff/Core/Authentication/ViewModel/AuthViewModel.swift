//
//  AuthViewModel.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 1/11/23.
//

import Firebase

//El AuthViewModel es el encargado de toda las funciones de autenticar los usuarios.
//Tambien de enviar notificaciones al UI, Newtwroking y demas.

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? //From Firebase.
    @Published var currentUser: User? //From Model
    
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
