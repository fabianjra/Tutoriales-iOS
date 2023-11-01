//
//  inputView.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import SwiftUI

struct inputView: View {
    
    @Binding var text: String
    var title: String
    var placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .foregroundStyle(Color.secondary)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
    }
}

#Preview {
    inputView(text: .constant(""), title: "Email", placeholder: "name@example.com ")
}
