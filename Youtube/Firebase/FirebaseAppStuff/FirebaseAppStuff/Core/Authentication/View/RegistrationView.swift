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
                
                ZStack(alignment: .trailing) {
                    inputView(text: $confirmPassword,
                              title: "Confirm password",
                              placeholder: "confirmed password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
                
            }
            .padding()
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
                    } catch {
                        print("error catch: \(error.localizedDescription)")
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
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
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

extension RegistrationView: AuthenticationFormProtocol {
    
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") &&
        !password.isEmpty && password.count > 5 &&
        !fullName.isEmpty &&
        password == confirmPassword
    }
}

#Preview {
    RegistrationView()
}
