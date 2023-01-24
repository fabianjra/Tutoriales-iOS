//
//  Challenge.swift
//  SpotifyPlayer
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-08-26.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class Challenge: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        let playButtonHeight: CGFloat = 40.0
        let margin: CGFloat = 8.0
        let marginSpotifyButton: CGFloat = 32.0
        
        // Comment in incrementally...
        let albumImage = makeImageView(named: "rush")
        let trackLabel = makeLabel(withText: "Tom Sawyer", size: 18, isBold: true)
        let albumLabel = makeLabel(withText: "Rush • Moving Pictures (2011 Remaster)", size: 18, textColor: .gray)
        
        let playButton = makePlayButton(named: "play")
        let previewStartLabel = makeLabel(withText: "0:00", size: 10)
        let progressView = makeProgressView()
        let previewEndLabel = makeLabel(withText: "0:30", size: 10)
        
                let spotifyButton = makeSpotifyButton(withText: "PLAY ON SPOTIFY")

        view.addSubview(albumImage)
        view.addSubview(trackLabel)
        view.addSubview(albumLabel)
        
        view.addSubview(playButton)
        view.addSubview(previewStartLabel)
        view.addSubview(progressView)
        view.addSubview(previewEndLabel)
        
                view.addSubview(spotifyButton)
        
        // Start your layout here...
        albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImage.heightAnchor.constraint(equalTo: albumImage.widthAnchor, multiplier: 1.0).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        trackLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: margin).isActive = true
        trackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        trackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
         
        albumLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: margin).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        playButton.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: margin).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
        
        previewStartLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: margin).isActive = true
        previewStartLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        progressView.leadingAnchor.constraint(equalTo: previewStartLabel.trailingAnchor, constant: margin).isActive = true
        progressView.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        previewEndLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: margin).isActive = true
        previewEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        previewEndLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        spotifyButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: marginSpotifyButton).isActive = true
        spotifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func makeImageView(named: String) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: named)
         
        // Stretch and grow
        view.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        
        return view
    }
    
    func makeLabel(withText text: String, size: CGFloat, isBold: Bool? = false, textColor: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.textColor = textColor ?? .black
        
        if isBold! {
            label.font = UIFont.boldSystemFont(ofSize: size)
        } else {
            label.font = UIFont.systemFont(ofSize: size)
        }
        
        return label
    }
    
    func makePlayButton(named: String) -> UIButton {
        let frameSize: Int = 100
        let image = UIImage(named: named) as UIImage?
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: frameSize, y: frameSize, width: frameSize, height: frameSize)
        
        return button
    }
    
    func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .gray
        
        return progressView
    }
    
    func makeSpotifyButton(withText title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .spotifyGreen
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: buttonHeight, bottom: 10, trailing: buttonHeight)
        button.configuration = config
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1 //Un espacio entre las letras.
            ])

        button.setAttributedTitle(attributedText, for: .normal) // Note how not button.setTitle()
        
        return button
    }
}
