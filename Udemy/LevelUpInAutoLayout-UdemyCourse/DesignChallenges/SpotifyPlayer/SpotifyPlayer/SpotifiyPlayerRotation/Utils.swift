//
//  Utils.swift
//  SpotifyPlayer
//
//  Created by Fabian Josue Rodriguez Alvarez on 30/1/23.
//  Copyright © 2023 Jonathan Rasmusson. All rights reserved.
//

import UIKit

//MARK: - Sizes:

let margin: CGFloat = 8.0
let playButtonHeight: CGFloat = 40.0
let marginSpotifyButton: CGFloat = 32.0

//MARK: - Controls:

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

func makeSpotifyButtonPlayView() -> UIView {
    let spotifyButton = makeSpotifyButton(withText: "PLAY ON SPOTIFY")
    
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.heightAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
    container.addSubview(spotifyButton)
    
    spotifyButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    spotifyButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    spotifyButton.heightAnchor.constraint(equalToConstant: playButtonHeight).isActive = true
    
    return container
}

func makeSpotifyButton(withText title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = .spotifyGreen
    config.cornerStyle = .capsule
    config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: playButtonHeight, bottom: 10, trailing: playButtonHeight)
    button.configuration = config
    
    let attributedText = NSMutableAttributedString(string: title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.kern: 1 //Un espacio entre las letras.
    ])
    
    button.setAttributedTitle(attributedText, for: .normal) // Note how not button.setTitle()
    
    return button
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

func makeCoverView(named: String) -> UIImageView {
    let coverView = makeImageView(named: named)
    
    let heightAnchorConstraint = coverView.heightAnchor.constraint(equalTo: coverView.widthAnchor)
    heightAnchorConstraint.priority = .defaultHigh
    heightAnchorConstraint.isActive = true
    
    return coverView
}

func makeStackView(withOrientation axis: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 8.0
    
    return stackView
}

func makeControlsStackView(controlsView: UIView) -> UIView {
    let stackView = makeStackView(withOrientation: .vertical)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    stackView.addArrangedSubview(controlsView)
    
    return stackView
}

//MARK: - Validations:

/*
 An application can use more than one scene, each with one or more windows.
 Use the connectedScenes method to obtain the list of connected scenes for the application.
 Use the window or keyWindow property on a scene to obtain the window.
 If you are certain that your app uses only one scene with one window you could obtain the same root view controller using the following:
 */
func getUIInterfaceOrientation() -> UIInterfaceOrientation {
    
    //Not deprecated code.
    guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return .unknown
    }
    
    guard let firstWindow = firstScene.windows.first else {
        return .unknown
    }
    
    return firstWindow.windowScene?.interfaceOrientation ?? .unknown
}

//MARK: - Extensions:

extension UIColor {
    static let spotifyGreen = UIColor(red: 28/255, green: 184/255, blue: 89/255, alpha: 1)
}
