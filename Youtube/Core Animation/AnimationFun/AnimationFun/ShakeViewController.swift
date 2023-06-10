//
//  ShakeViewController.swift
//  AnimationFun
//
//  Created by Fabian Rodriguez on 10/6/23.
//

import UIKit

class ShakeViewController: UIViewController {
    
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
        
        animateScale()
        
        //add button for funcion:
        let button = UIButton()
        button.frame = CGRect(x: view.bounds.midX - 100,
                              y: view.bounds.midY + 200,
                              width: 200, height: 50)
        button.setTitle("Make a shake", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(animationShake), for: .touchUpInside)
        
        view.addSubview(button)
        
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
}
