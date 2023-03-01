//
//  ControlsView.swift
//  SpotifyPlayer
//
//  Created by Fabian Josue Rodriguez Alvarez on 30/1/23.
//  Copyright © 2023 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ControlsView: UIView {
    
    let stackView: UIStackView
    var topAnchorConstraint = NSLayoutConstraint()
    var centerYAnchorConstraint = NSLayoutConstraint()
    
    init() {
        stackView = makeStackView(withOrientation: .vertical)
        stackView.distribution = .fillProportionally
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        //Add controls:
        let trackLabel = makeLabel(withText: "Tom Sawyer", size: 18, isBold: true)
        let albumLabel = makeLabel(withText: "Rush • Moving Pictures (2023 Remake)", size: 18, textColor: .gray)
        let progressView = ProgressRow()
        let spotifyButton = makeSpotifyButtonPlayView()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(trackLabel)
        stackView.addArrangedSubview(albumLabel)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(spotifyButton)
        
        //Static constraints:
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //Dynamic constraints
        topAnchorConstraint = stackView.topAnchor.constraint(equalTo: topAnchor)
        centerYAnchorConstraint = stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
    }
    
    //Validate if portrait or landspace
    func adjustConstraints() {
        let orientation = getUIInterfaceOrientation()
        
        if orientation == .portrait {
            topAnchorConstraint.isActive = true
            centerYAnchorConstraint.isActive = false
            
            print("ControlsView: Portrait. Margin: \(margin)")
        } else {
            topAnchorConstraint.isActive = false
            centerYAnchorConstraint.isActive = true
            
            print("ControlsView: Ladscape. Margin: \(margin)")
        }
    }
    
    //Optional
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

