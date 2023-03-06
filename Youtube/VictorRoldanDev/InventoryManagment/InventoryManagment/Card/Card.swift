//
//  Card.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

import SwiftUI

struct Card: View {
    
    @ObservedObject private var model: Card.Model
    
    init(model: Card.Model) {
        self.model = model
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack{
                model.type.icon
                Text(model.type.description).font(.system(size: 15, weight: .light))
                
                Spacer()
                
                Circle().frame(width: 10, height: 10)
                    .foregroundColor(model.status.color)
                
                Text(model.status.description).font(.system(size: 15, weight: .light))
            }.foregroundColor(.gray)
            
            Text(model.title)
                .font(.system(size: 16, weight: .bold))
            
            HStack {
                Text("For").foregroundColor(.gray)
                Text(model.owner)
                Constants.Images.chevronDown
                    .font(.system(size: 13, weight: .bold))
                
                Spacer()
                
                Text(model.time)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        
        //Crea el color al lado izquierdo para identificar la card
        .overlay(
            HStack{
                Rectangle()
                    .fill(model.status.color)
                //.padding(.vertical, -20)
                    .frame(width: 5)
                Spacer()
            }//.frame(maxWidth: .infinity)
        )
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray.opacity(0.5), radius: 15.0, x: 0, y: 0)
        .padding(.vertical, 10) //Separacion extra del exterior
        //.padding(.horizontal, 20) //Separacion extra del exterior
        .listRowSeparator(.hidden) //Oculta la linea separadora cuando se agrega en un List
    }
}

extension Card {
    final class Model: Identifiable, ObservableObject {
        public var id = UUID()
        @Published public var type: ´Type´
        @Published public var status: Status
        @Published public var title: String
        @Published public var owner: String
        @Published public var time: String
        
        public init(type: Card.´Type´ = .asset, status: Card.Status = .open, title: String, owner: String, time: String) {
            self.type = type
            self.status = status
            self.title = title
            self.owner = owner
            self.time = time
        }
    }
    
    enum ´Type´: String, Identifiable, CustomStringConvertible {
        public var id: Self { self }
        case asset
        case troubleshoot
        
        var icon: Image {
            switch self {
            case .asset: return Constants.Images.stack
            case .troubleshoot: return Constants.Images.questionMark
            }
        }
        
        var description: String {
            switch self {
            case .asset: return "Asset"
            case .troubleshoot: return "Troubleshoot"
            }
        }
    }
    
    enum Status: String, Identifiable, CustomStringConvertible {
        public var id: Self { self }
        case open
        case inProgress
        case accepted
        case solved
        case onHold
        
        var color: Color {
            switch self {
            case .open: return Color.green
            case .inProgress: return Color.yellow
            case .accepted: return Color.blue
            case .solved: return Color.black
            case .onHold: return Color.red
            }
        }
        
        var description: String {
            switch self {
            case .open: return "Open"
            case .inProgress: return "In Progress"
            case .accepted: return "Accepted"
            case .solved: return "Solved"
            case .onHold: return "On Hold"
            }
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(model: Card.Model(type: .asset,
                               status: .open,
                               title: "Request for a new Apple Macbook Pro",
                               owner: "Fabian Rodriguez",
                               time: "2m"))
    }
}
