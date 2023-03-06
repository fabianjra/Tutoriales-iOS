//
//  Constants.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

import SwiftUI

struct Constants {
    
    // MARK: - Colors
    struct Colors {
        static let lightBlueGradiant: Array = [Color.lightBlue, Color.lightBlue, Color.lighterBlue]
    }
    
    // MARK: - Images
    struct Images {
        
        //Views:
        static let hamburger = Image(systemName: "line.3.horizontal")
        static let add = Image(systemName: "plus")
        static let sort = Image(systemName: "slider.vertical.3")

        //Controls:
        static let chevronDown = Image(systemName: "chevron.down")
        
        //Card Type:
        static let stack = Image(systemName: "square.stack.3d.up.fill")
        static let questionMark = Image(systemName: "questionmark.circle.fill")
    }
}
