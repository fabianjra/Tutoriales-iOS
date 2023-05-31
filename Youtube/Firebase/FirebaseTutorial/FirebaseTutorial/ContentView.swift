//
//  ContentView.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI
import Firebase

//Link Youtube: https://www.youtube.com/watch?v=6b2WAePdiqA

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var userIsLoggedIn = false
    
    var body: some View {
        
        if userIsLoggedIn {
            ListView()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue, .gray],
                                                 startPoint: .top,
                                                 endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -80, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) { //Add color white to placeholder text:
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                line
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) { //Add color white to placeholder text:
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                line
                
                VStack {
                    Button {
                        
                        register()
                        
                    } label: {
                        Text("Sign up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.blue)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.bottom)
                    
                    Button {
                        
                        login()
                        
                    } label: {
                        Text("Already have an account? Login")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                }
                .offset(y: 110)
                
            }
            .frame(width: 350)
            .onAppear {
                
                //Handle session for navigation.
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    var line: some View {
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.white)
    }
    
    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                debugPrint(error?.localizedDescription ?? "ERROR AL REGISTRAR USER")
            }
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            debugPrint(error?.localizedDescription ?? "ERROR AL HACER LOGIN")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
