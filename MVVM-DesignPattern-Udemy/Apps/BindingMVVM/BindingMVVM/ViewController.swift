//
//  ViewController.swift
//  BindingMVVM
//
//  Created by Fabian Josue Rodriguez Alvarez on 22/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginVM = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupView()
    }
    
    private func setupView() {
        
        let lblTitle = makeLabel(text: "Binding: VIEW to VIEW-MODEL", size: 20, view: view)
        lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let txtUserName = makeTextField(text: "Enter username", view: self.view)
        txtUserName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        txtUserName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtUserName.bind { [weak self] text in
            
            //Cada vez que se preisona una tecla, es ejecutado el Binding:
            print(text)
            self?.loginVM.username = text
        }
        
        let txtPassword = makeTextField(text: "Enter password", view: self.view)
        txtPassword.isSecureTextEntry = true
        txtPassword.topAnchor.constraint(equalTo: txtUserName.bottomAnchor, constant: 15).isActive = true
        txtPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtPassword.bind { [weak self] text in
            self?.loginVM.password = text
        }
        
        let button = makeButton(withText: "Login", action: #selector(login), view: self.view)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func login() {
        print("The binding:")
        print(loginVM.username)
        print(loginVM.password)
    }
    
    private func makeLabel(text: String, size: CGFloat, view: UIView) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        return label
    }
    
    private func makeTextField(text: String, view: UIView) -> BindingTextField {
        let textField = BindingTextField() //Para el Binding.
        textField.placeholder = text
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        return textField
    }
    
    private func makeButton(withText title: String, action: Selector, view: UIView) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        //config.baseBackgroundColor = .lightGray
        //config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        button.configuration = config
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1 //Un espacio entre las letras.
            ])

        button.setAttributedTitle(attributedText, for: .normal) // Note how not button.setTitle()
        
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
        
        return button
    }
}
