//
//  SecondViewController.swift
//  LevelUpInAutoLayout
//
//  Created by Fabian Josue Rodriguez Alvarez on 23/12/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews(){
        let topLabel = makeLabel(withText: "Top", size: 32)
        
        view.addSubview(topLabel)
        
        //Challenge:
        let bottomLabel = makeLabel(withText: "Bottom", size: 40)
        view.addSubview(bottomLabel)
        
        //Sides label
        let leadingLabel = makeLabel(withText: "Leading", size: 40)
        let trailingLabel = makeLabel(withText: "Trailing", size: 40)
        view.addSubview(leadingLabel)
        view.addSubview(trailingLabel)
        
        //Another way to active a constraint in an array:
        //They are separated by comas.
        NSLayoutConstraint.activate([
            
            //Se usa el AutoLAyout:
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //-20 points of spacing:
            bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        //Classic way to activate a constraint: .isActive = true
        //In this case, is not necessesary to use "safeAreaLayoutGuide", because that is for top and bottom, but you are free to use it.
        leadingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        leadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        trailingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        trailingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func makeLabel(withText text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: size)
        
        return label
    }
}
