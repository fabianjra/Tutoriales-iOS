//
//  CrossfadeView.swift
//  CustomViewChallenge
//
//  Created by Fabian Josue Rodriguez Alvarez on 29/1/23.
//  Copyright © 2023 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class CrossfadeView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let marginTop: CGFloat = 32.0
        let marginSides: CGFloat = 4.0
        
        let crossfadeLabel = makeBoldLabel(withText: "Crossfade")
        let crossfadeMinLabel = makeSubLabel(withText: "0s")
        let crossfadeProgressView = makeProgressView()
        let crossfadeMaxLabel = makeSubLabel(withText: "12s")
        
        addSubview(crossfadeLabel)
        addSubview(crossfadeMinLabel)
        addSubview(crossfadeProgressView)
        addSubview(crossfadeMaxLabel)
        
        crossfadeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        crossfadeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        crossfadeMinLabel.topAnchor.constraint(equalTo: crossfadeLabel.bottomAnchor, constant: marginTop).isActive = true
        crossfadeMinLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        crossfadeProgressView.centerYAnchor.constraint(equalTo: crossfadeMinLabel.centerYAnchor).isActive = true
        crossfadeProgressView.leadingAnchor.constraint(equalTo: crossfadeMinLabel.trailingAnchor, constant: marginSides).isActive = true
        crossfadeProgressView.trailingAnchor.constraint(equalTo: crossfadeMaxLabel.leadingAnchor, constant: -4).isActive = true
        
        crossfadeMaxLabel.centerYAnchor.constraint(equalTo: crossfadeMinLabel.centerYAnchor).isActive = true
        crossfadeMaxLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    // Size suggestion
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 100)
    }
}
