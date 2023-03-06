//
//  CustomRectangle.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

//Estructura que conforma el protocolo Shape, para crearle una linea inferior curvada al rectangulo que se va a utilizar como Header.

import Foundation
import SwiftUI

struct CustomRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //Agregar los piuntos para dibujar el rectangulo:
        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) //Top-Left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))//Top-Right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))//Bottom-Right
        
        //Agregar puntos para dibujar la curva en la parte inferior:
        let c1 = CGPoint(x: rect.midX + 50, y: rect.maxY + 20)
        let c2 = CGPoint(x: rect.midX - 50, y: rect.maxY + 20)
        
        path.addCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY), //Bottom-Left
            control1: c1,
            control2: c2)
        
        path.closeSubpath()//No hace falta
        
        return path
    }
}
