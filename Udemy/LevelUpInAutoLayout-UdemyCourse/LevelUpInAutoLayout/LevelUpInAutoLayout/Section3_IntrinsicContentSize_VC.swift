//
//  Section3_IntrinsicContentSize_VC.swift
//  LevelUpInAutoLayout
//
//  Created by Fabian Josue Rodriguez Alvarez on 10/1/23.
//

import UIKit

//SECCION 3: Intrinsic Content Size

class Section3_IntrinsicContentSize_VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //16. Lab: Intrinsic Content Size Inaction
        //setupViews_16()
        
        //************************************************//
        
        //17. Lab: Content Hugging & Compression Resistance
        //setupViews_17()
        
        //************************************************//
        
        //18. Working with Images
        setupViews_18()
    }
    
    func setupViews_16(){
        
        /* 1: By default, this label has a size. Using Intrinsic Content Size.
         If you change the text, the label will adjust automatically, without changing
         the width by us. */
        let label1 = makeLabel(withText: "label1", size: 32, color: .yellow)
        
        view.addSubview(label1)
        
        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        //2: Here we can change manually the size of the label, overriding the Anchors:
        //label1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //label1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //3: Another way to change the size, is adjusting the trailing:
        //label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8).isActive = true
    }
    
    func makeLabel(withText text: String, size: CGFloat, color: UIColor) -> UILabel {
        //let label = UILabel()
        
        //Usar un label personalizado:
        let label = BigLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
        label.backgroundColor = color
        
        return label
    }
    
    //*******************************************************************************************//
    
    func setupViews_17(){
        let nameLabel = makeLabel(withText: "Name", color: .yellow)
        let nameTextField = makeTextField(withPlaceHolderText: "Enter name here")
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        nameTextField.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor).isActive = true //Sobre la misma linea del label.
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        //Hasta aqui, el ancho del label y el Textfield son ambiguos, necesitan asignarse.
        
        //Se debe cambiar la prioridad del "Hugging" para aumentarlo en 1. y asi estar un valor por encima del de 250 del Textfield.
        nameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal) //Property label. It's not a constraint.
        
    }
    
    func makeLabel(withText text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.backgroundColor = color
        
        return label
    }
    
    func makeTextField(withPlaceHolderText text: String) -> UITextField {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = text
        textfield.backgroundColor = .lightGray
        
        return textfield
    }
    
    //*******************************************************************************************//
    
    func setupViews_18(){
        let image = makeImageView(named: "rush")
        let label = makeLabel(withText: "Title")
        let button = makeButton(withText: "Get Started")
        
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(button)
        
        //Imageviews by themselves have intrinsic size
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 300).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //NOTA: Hasta aqui, los 3 controles anteriores tienen ambiguedad en "height".
        //Todos tienen la misma prioridad en Hugging Vertical.
    }
    
    func makeImageView(named: String) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: named)
        view.backgroundColor = .green
        
        //Resolver la ambiguedad:
        //Why only dimension? Because is the only dimension that is ambigous:
        
        //meaning: Im ok hugging a little bit less.
        //Puede ajustar su altura para comprimirse un poco y ajustarse a los demas controles.
        view.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        
        //Meaning: Im ok stretching it.
        view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        
        return view
    }
    
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .yellow
        
        return label
    }
    
    func makeButton(withText text: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = text
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        configuration.baseBackgroundColor = .blue
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

//Override the Intrinsic Content Size of a label:
class BigLabel: UILabel {
    // just a suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}
