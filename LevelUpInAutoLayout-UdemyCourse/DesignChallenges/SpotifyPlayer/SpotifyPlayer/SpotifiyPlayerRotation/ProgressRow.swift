//
//  ProgressbarView.swift
//  SpotifyPlayer
//
//  Created by Fabian Josue Rodriguez Alvarez on 30/1/23.
//  Copyright © 2023 Jonathan Rasmusson. All rights reserved.
//

import UIKit

// Note: This control I did design flush to the edges (padding provided by stackView)

class ProgressRow: UIView {

    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {

        //Add controls:
        let playButton = makePlayButton(named: "play")
        let previewStartLabel = makeLabel(withText: "0:00", size: 10)
        let progressView = makeProgressView()
        let previewEndLabel = makeLabel(withText: "0:30", size: 10)
        
        addSubview(playButton)
        addSubview(previewStartLabel)
        addSubview(progressView)
        addSubview(previewEndLabel)
        
        playButton.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
        
        previewStartLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: margin).isActive = true
        previewStartLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        progressView.leadingAnchor.constraint(equalTo: previewStartLabel.trailingAnchor, constant: margin).isActive = true
        progressView.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        previewEndLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: margin).isActive = true
        previewEndLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        previewEndLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
    }
    
    //Optional
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: playButtonHeight)
    }
}
