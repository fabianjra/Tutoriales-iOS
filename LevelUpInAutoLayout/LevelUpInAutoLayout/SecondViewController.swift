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
        
        //1:
        //setupViews_safeAreaLayoutGuide()
        
        //2:
        //setupViews()
        
        //3:
        setuoView2()
    }
    
    //1:
    func setupViews_safeAreaLayoutGuide(){
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
    
    //2: Auto Layout: Using "LayoutGuide", en lugar de "safeAreaGuide".
    //La principal diferencia es que "LayoutGuide" agrega un margen a los bordes del rectangulo.
    //Al inicio, se usaban "Spacer Views", ahora eso se reemplazó con los LayoutGuides.
    func setupViews(){
        let readView = UIView()
        readView.translatesAutoresizingMaskIntoConstraints = false
        readView.backgroundColor = .green
        view.addSubview(readView)
        
        NSLayoutConstraint.activate([
            readView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            readView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            readView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            readView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    //3: LayoutGuides: Creacion de 2 botones alineados mediante "LayoutGuide".
    //Se agregan espacios entre los botones, en leading, middle y trailing para hacer espacios iguales, a demas del margin a los extremos.
    func setuoView2(){
        
        //Existen "margins" en los extremos de la pantalla, a la izquierda del leading y a la derecha del trailing, por ambos ser LayoutGuide.
        //pero estos margin se agregan con una clase llamada "layoutMarginsGuide"
        
        let leadingGuide = UILayoutGuide()
        let okButton = makeButton(title: "OK", color: UIColor.darkBlue)
        
        let middleGuide = UILayoutGuide()
        
        let cancelButton = makeButton_deprecated(title: "Cancel", color: UIColor.darkGreen)
        let trailingGuide = UILayoutGuide()
        
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        
        //"addLayoutGuide" es un "lowLevelAPI", no se esta agrengado a la vista, sino al Layout.
        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)
        
        //Margin a los extremos de la pantalla.
        let margin = view.layoutMarginsGuide
        
        //leding guide:
        margin.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor).isActive = true
        leadingGuide.trailingAnchor.constraint(equalTo: okButton.leadingAnchor).isActive = true
        
        //middle guide:
        okButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor).isActive = true
        middleGuide.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor).isActive = true
        
        //Trailing guide:
        cancelButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor).isActive = true
        trailingGuide.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        
        //Button equal widths
        okButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        
        //Spacer equal widths
        leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor).isActive = true
        leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor).isActive = true
        
        //Vertical position:
        leadingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        trailingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //giving layout guides default height:
        leadingGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        middleGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        trailingGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //Funcion de makeButton con "configuration" para no usar los "EdgeInsets" de forma deprecada.
    func makeButton(title: String, color: UIColor) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        configuration.baseBackgroundColor = color
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    func makeButton_deprecated(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true //Tamaño del texto se ajusta a la anchura del boton.
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        button.backgroundColor = color
        
        return button
    }
}

extension UIColor {
    static let darkBlue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1.0)
    static let darkGreen = UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1.0)
    static let darkOrgane = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
    static let darkTeal = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1.0)
    static let darkYellow = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
}
