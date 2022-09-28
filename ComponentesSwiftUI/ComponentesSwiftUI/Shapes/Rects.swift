//
//  Shapes.swift
//  ComponentesSwiftUI
//
//  Created by Fabian Josue Rodriguez Alvarez on 27/9/22.
//

import SwiftUI

//Crear un triangulo.
struct Triangle: Shape {
    
    //Rect: se refiere a un rectangulo.
    func path(in rect: CGRect) -> Path {
        
        //Otra forma de crear el path (igual a hacerlo con Closure):
        //var path = Path()
        //return path
        
        //Se puede agregar un let, para no usar "rect.midX" en cada punto
        let mid = rect.width / 2
        
        return Path { path in
            path.move(to: CGPoint(x: mid, y: 0)) //Se puede usar directametne un numero.
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.height)) //Se puede hacer de diferentes formas
            //path.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) //No hace falta, pero se agrega para dibujar la ultima linea donde cierra.
            path.closeSubpath() //Cierra la linea, conectando la ultima con el primer punto.
        }
    }
}

struct Quadrilateral: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct Rects: View {
    var body: some View {
        VStack{
            Circle()
            //La propiedad Stroke, permite cambiar la forma en la que se ve la figura (shape).
                .stroke(style: StrokeStyle(
                lineWidth: 10,
                lineCap: .square,
                dash: [50]))
        }
    }
}

struct Shapes2: View {
    var body: some View {
        VStack{
            Triangle()
                .fill(LinearGradient(colors: [.red, .blue, .green],
                                     startPoint: .top,
                                     endPoint: .bottom))
//                .stroke(LinearGradient(colors: [.red, .blue, .green],
//                                       startPoint: .top,
//                                       endPoint: .bottom),
//                        lineWidth: 5)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Quadrilateral()
                .frame(width: 300, height: 300)
        }
    }
}

struct Rects_Previews: PreviewProvider {
    static var previews: some View {
        //Rects()
        Shapes2()
    }
}
