//
//  ViewController.swift
//  AnimationFun
//
//  Created by Fabian Rodriguez on 10/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    //Se crea una vista roja, a la cual se le va a realizar la animacion.
    //Harcode:
    //let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    
    let redView = UIView()
    let _width: CGFloat = 140
    let _height: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        redView.backgroundColor = .systemRed
        
        view.addSubview(redView)
    }
    
    //In this function, the view is layed out.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       //So we can dynamically center it on the screen with no hard coded values.
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
        
        //animateMove()
        //animateScale()
        animationRotae()
    }


    func animateMove() {
        
        //Model layer: Track the configuration of the view (position, attributes, round corner, etc).
        let animation = CABasicAnimation()
        animation.keyPath = "position.x" //Property.
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        
        //Esta es la posicion final en la que debe quedar la vista.
        //Si no se utiliza esta propeidad de posicion, entonces la vista volvera a su posicion original.
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2)
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
    
    func animationRotae() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z" // Z-axis
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4 // 45 grados.
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeRotation(CGFloat.pi/4, 0, 0, 1)
    }
}

