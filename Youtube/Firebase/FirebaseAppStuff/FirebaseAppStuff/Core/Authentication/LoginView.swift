//
//  LoginView.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Image("firebase-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                
                VStack {
                    inputView(text: $email,
                              title: "Email",
                              placeholder: "user@example.com")
                    .textInputAutocapitalization(.none)
                    
                    inputView(text: $password,
                              title: "Password",
                              placeholder: "password",
                              isSecureField: true)
                    
                }
                .padding()
                
                Button(action: {
                    print("")
                    
                }, label: {
                    HStack {
                        Text("Log in")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                })
                .background(.blue)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
                
                Spacer()
                
                //Register
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Not have an account?")
                        
                        Text("Sing up")
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    LoginView()
}
