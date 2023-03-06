//
//  ItemNavbar.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

import Foundation
import SwiftUI

struct ItemNavbar: View {
    
    @ObservedObject private var model: ItemNavbar.Model
    
    init(model: ItemNavbar.Model) {
        self.model = model
    }
    
    public var body: some View {
        VStack(spacing: ItemNavbar.Constants.Spacing.verticalSpacing) {
            Text(model.value.description)
                .font(.system(size: ItemNavbar.Constants.Font.sizeValue, weight: .bold))
            
            Text(model.description)
                .font(.system(size: ItemNavbar.Constants.Font.sizeDescription))
                .foregroundColor(.gray)
        }
    }
}

extension ItemNavbar {
    final class Model: Identifiable, ObservableObject {
        public var id = UUID().uuidString
        @Published public var value: Int
        @Published public var description: String
        
        public init(value: Int, description: String) {
            self.value = value
            self.description = description
        }
    }
}

extension ItemNavbar {
    struct Constants {
        
        // MARK: - Spacing
        struct Spacing {
            static var verticalSpacing: CGFloat { return 10.0 }
        }
        
        // MARK: - Font sizes
        struct Font {
            static var sizeValue: CGFloat { return 20.0 }
            static var sizeDescription: CGFloat { return 15.0 }
        }
    }
}

struct ItemNavbar_Previews: PreviewProvider {
    static var previews: some View {
        ItemNavbar(model: ItemNavbar.Model(value: 421, description: "Overdue"))
    }
}
