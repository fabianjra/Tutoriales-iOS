//
//  CirclingViewController.swift
//  AnimationFun
//
//  Created by Fabian Rodriguez on 10/6/23.
//

import UIKit

class CirclingViewController: UIViewController {
    
    //Vista que va a girar
    let redView = UIView()
    let _width: CGFloat = 40
    let _height: CGFloat = 40
    
    //Circulo sobre el que va a girar la vista roja.
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()

        redView.backgroundColor = .systemRed
        
        view.addSubview(redView)
        view.addSubview(redCircle)
        
        //add button for funcion shake:
        let buttonShake = makeButton("makeShake", posicionY: 200, accion: #selector(animationShake))
        view.addSubview(buttonShake)
        
        //Add button for action circling
        let buttonCircling = makeButton("Circling", posicionY: 300, accion: #selector(animateCircling))
        view.addSubview(buttonCircling)
    }
    
    //In this function, the view is layed out.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Draw box
        //We can dynamically center it on the screen with no hard coded values.
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
        
        // Draw Circle
        redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                                 y: view.bounds.midY - _diameter/2,
                                 width: _diameter, height: _diameter)
        
        let render = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))
        
        //Se crea un circulo con Core Graphics.
        let img = render.image { ctx in
            let rectangle = CGRect(x: 0,
                                   y: 0,
                                   width: _diameter, height: _diameter)
            
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        redCircle.image = img
        
        animateScale()
    }
    
    func makeButton(_ title: String, posicionY: CGFloat, accion: Selector) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: view.bounds.midX - 100,
                              y: view.bounds.midY + posicionY,
                              width: 200, height: 50)
        button.setTitle(title, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .blue
        button.addTarget(self, action: accion, for: .touchUpInside)
        
        return button
    }
    
    func animateScale() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.5
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeScale(2, 2, 1)
    }

    @objc func animationShake() {
        
        //Keyframe se utiliza para tener varias posiciones en la que va a estar una vista.
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 20, -20, 20, 0]
        
        //Esta es la duracion para cada valor del arreglo en "values"
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        
        animation.duration = 0.3
        
        //Permite que la animacion se vea centrada.
        animation.isAdditive = true
        
        redView.layer.add(animation, forKey: "shake")
    }
    
    @objc func animateCircling() {
        let boundingRect = CGRect(x: -_diameter/2,
                                  y: -_diameter/2,
                                  width: _diameter,
                                  height: _diameter)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position" //Indica que se va a cambiar la posicon
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 2
        orbit.isAdditive = true //Se mantendra centrado.
        
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        
        redView.layer.add(orbit, forKey: "redbox")
    }
}
