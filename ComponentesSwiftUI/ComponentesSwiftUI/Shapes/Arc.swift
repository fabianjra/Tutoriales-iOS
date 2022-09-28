//
//  Arc.swift
//  ComponentesSwiftUI
//
//  Created by Fabian Josue Rodriguez Alvarez on 28/9/22.
//

import SwiftUI

struct ArcView: Shape {
    var endAngle: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc( center: CGPoint(x: rect.midX, y: rect.midY),
                         radius: rect.width/2,
                         startAngle: .degrees(0),
                         endAngle: .degrees(endAngle),
                         clockwise: false)
        }
    }
}

struct Arc: View {
    @State var progress: CGFloat = 150.0
    
    var body: some View {
        VStack{
            ArcView(endAngle: progress)
                .fill(Color(.blue))
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(90))
            
            Slider(value: $progress, in: 0...360, step: 1){
                
            }minimumValueLabel: {
                Text("Min")
            }maximumValueLabel: {
                Text("Max")
            }
            .padding(.horizontal)
            
            Text("Degress: \(Int(progress))")
        }
    }
}

struct Arc_Previews: PreviewProvider {
    static var previews: some View {
        Arc()
    }
}
