//
//  RegistrationView.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //Un EnvironmentObject no se puede inicializar. Ya fue inicializado 1 sola vez al inicio del App.
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            Image("firebase-logo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding()
            
            VStack(spacing: 20) {
                inputView(text: $fullName,
                          title: "Full name",
                          placeholder: "Fabian R. A.")
                
                inputView(text: $email,
                          title: "Email",
                          placeholder: "user@example.com")
                .textInputAutocapitalization(.none)
                
                inputView(text: $password,
                          title: "Password",
                          placeholder: "password",
                          isSecureField: true)
                
                inputView(text: $confirmPassword,
                          title: "Confirm password",
                          placeholder: "confirmed password",
                          isSecureField: true)
                
            }
            .padding()
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
                    } catch {
                        print("error catch: \(error)")
                    }
                }
                
            }, label: {
                Text("Sign up")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            })
            .background(.blue)
            .clipShape(.buttonBorder)
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                dismiss()
            } label: { 
                HStack {
                    Text("Already have an account?")
                    
                    Text("Sing in")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 14))
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    RegistrationView()
}
