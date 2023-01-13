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
        setupViews_17()
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
}

//Override the Intrinsic Content Size of a label:
class BigLabel: UILabel {
    // just a suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}
