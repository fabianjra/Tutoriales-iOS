//
//  SpotifiyPlayerRotation.swift
//  SpotifyPlayer
//
//  Created by Fabian Josue Rodriguez Alvarez on 30/1/23.
//  Copyright © 2023 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class SpotifiyPlayerRotation: UIViewController {
    
    var stackView = UIStackView()
    let controlsView = ControlsView()
    
    init() {
        stackView = makeStackView(withOrientation: .vertical)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForOrientationChanges()
        setupViews()
    }
    
    func registerForOrientationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(SpotifiyPlayerRotation.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func setupViews() {
        
        let coverView = makeCoverView(named: "rush")
        let controlsStackView = makeControlsStackView(controlsView: controlsView)
        
        stackView.addArrangedSubview(coverView)
        stackView.addArrangedSubview(controlsStackView)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func rotated() {
        
        print("**************************************")
        
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
            print("SpotifiyPlayerRotation: Landscape")
        } else {
            stackView.axis = .vertical
            print("SpotifiyPlayerRotation: Portrait")
        }
        
        controlsView.adjustConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
