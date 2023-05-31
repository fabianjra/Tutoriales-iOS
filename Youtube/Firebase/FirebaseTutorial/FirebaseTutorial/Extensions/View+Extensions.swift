//
//  View+Extensions.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    aligment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: aligment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
