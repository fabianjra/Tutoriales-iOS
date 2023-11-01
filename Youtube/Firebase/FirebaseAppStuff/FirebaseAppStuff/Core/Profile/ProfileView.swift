//
//  ProfileView.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        List {
            Section {
                HStack(spacing: 15) {
                    Text(viewModel.currentUser?.initials ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(.secondary)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.currentUser?.fullname ?? "")
                            .fontWeight(.semibold)
                            .font(.title2)
                         
                        Text(viewModel.currentUser?.email ?? "")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Section("General") {
                HStack {
                    SettingsRowView(imageName: "gear", title: "Version")
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            
            Section("Account") {
                Button(action: {
                    // sign out
                }, label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
                })
                
                Button(action: {
                    // Delte account
                }, label: {
                    SettingsRowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: .red)
                })
            }
        }
    }
}

#Preview {
    ProfileView()
}
