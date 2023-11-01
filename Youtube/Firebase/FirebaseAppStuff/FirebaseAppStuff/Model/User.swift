//
//  User.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    let fullname: String
    let email: String
    
    //Permite descomponer el nombre completo de una persona basandose en un solo texto String
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            
            return formatter.string(from: components)
        }
        
        return "" 
    }
}

extension User { 
    static var MOCK_USER = User(id: "123", fullname: "Fabian Rodriguez", email: "fabian@gmail.com")
}
