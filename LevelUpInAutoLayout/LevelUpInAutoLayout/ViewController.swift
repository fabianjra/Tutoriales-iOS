//
//  ViewController.swift
//  LevelUpInAutoLayout
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    func setupViews(){
        
        //Make the UpperLeft Label
        let upperLeftLabel = makeLabel(withText: "UpperLeft", size: 14)
        
        //Add label to the SubView
        view.addSubview(upperLeftLabel)
        
        //Add Anchors:
        //upperLeftLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        //Solo de esta manera, no toma en cuenta el "Safe Area" y queda sobre la barra de estado superior.
        
        //Se toma en cuenta el Safe Area para el Anchor.
        upperLeftLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        upperLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        
        //Make the UpperRight Label
        let upperRightLabel = makeLabel(withText: "UpperRight", size: 20)
        view.addSubview(upperRightLabel)
        upperRightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        upperRightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        //Make the BottomLeft Label
        let bottomLeftLabel = makeSecondaryLabel(withText: "Bottom Left", size: 30)
        view.addSubview(bottomLeftLabel)
        bottomLeftLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        bottomLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        //Make the BottomRight Button
        let bottomRightButton = makeButton(withText: "Button Right")
        view.addSubview(bottomRightButton)
        bottomRightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        bottomRightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    
        //Create the Viw in the center screen:
        let centerView = makeView()
        view.addSubview(centerView)
        
        //Medidas posicion del View:
        centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //Medidas de altura y ancho:
        //Option 1: Size Explicity.
        centerView.heightAnchor.constraint(equalToConstant: 50).isActive = false
        centerView.widthAnchor.constraint(equalToConstant: 100).isActive = false
        
        //Option 2: Size Dinamically (Pinning)
        
        //Width:
        centerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        centerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        //Height:
        centerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        centerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
    //For the TopAnchors
    func makeLabel(withText text: String, size: CGFloat) -> UILabel {
        
        let label = UILabel()
        
        //If you dont set to false: your control wont participate in the Auto Layout Solver.
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: size)
        
        return label
    }
    
    //For the bottomAnchors Left:
    func makeSecondaryLabel(withText text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .gray
        
        return label
    }
    
    //For the bottomAnchors Right:
    func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.backgroundColor = .blue
        
        return button
    }
    
    //For the square in the center screen:
    func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        
        return view
    }
}

