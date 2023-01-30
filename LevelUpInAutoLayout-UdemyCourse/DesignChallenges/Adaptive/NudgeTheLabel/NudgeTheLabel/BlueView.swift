//
//  BlueView.swift
//  NudgeTheLabel
//
//  Created by Jonathan Rasmusson Work Pro on 2019-08-23.
//  Copyright © 2019 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

//
// Challenge: Set the constraints on the label in this view so that when the
//            view is in portrait, the label is 8pts from the top (topAnchor)
//            and when the view is in landscape, it is centered vertically (centerY).
//

class BlueView: UIView {
    
    var topAnchorConstraint = NSLayoutConstraint()
    var centerYAnchorConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .blue
        
        let label = makeLabel(withText: "Adjusting constraints", size: 24)
        
        addSubview(label)
        
        // Static constraints
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // Dynamic constraints
        topAnchorConstraint = label.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        centerYAnchorConstraint = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        adjustConstraints()
    }
    
    func adjustConstraints() {
        
        /*
         An application can use more than one scene, each with one or more windows.
         Use the connectedScenes method to obtain the list of connected scenes for the application.
         Use the window or keyWindow property on a scene to obtain the window.
         If you are certain that your app uses only one scene with one window you could obtain the same root view controller using the following:
         */
        
        //Not deprecated code.
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        guard let firstWindow = firstScene.windows.first else {
            return
        }
        
        if firstWindow.windowScene?.interfaceOrientation == .portrait {
            //Fill in these values here
            print("Portrait")
            
            topAnchorConstraint.isActive = true
            centerYAnchorConstraint.isActive = false
        } else {
            // Fill in these values here
            print("Landscape")
            
            topAnchorConstraint.isActive = false
            centerYAnchorConstraint.isActive = true
        }
        
        /*
         //'statusBarOrientation' was deprecated in iOS 13.0: Use the interfaceOrientation property of the window scene instead.
         if UIApplication.shared.statusBarOrientation.isPortrait {
         // Fill in these values here
         print("Portrait")
         } else {
         // Fill in these values here
         print("Landscape")
         }
         */
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}
