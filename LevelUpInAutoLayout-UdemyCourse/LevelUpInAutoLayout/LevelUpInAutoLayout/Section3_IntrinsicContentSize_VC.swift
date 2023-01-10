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
        setupViews_16()
        
        //************************************//
        
        //17. Lab: XX
        //setupViews_17()
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
}

//Override the Intrinsic Content Size of a label:
class BigLabel: UILabel {
    // just a suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}
