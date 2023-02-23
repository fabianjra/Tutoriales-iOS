//
//  ViewController.swift
//  BindingMVVM
//
//  Created by Fabian Josue Rodriguez Alvarez on 22/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginVM = LoginViewModel()
    
    //Lazy means that is going to initialize once.
    /*
     A lazy var is a property whose initial value is not calculated until the first time it's called.
     It is also a part of properties in which we have other properties like constant, computed, and mutable properties.
     Remember that lazy property must always be declared as variables with the var keyword, not constants.
     */
    lazy var txtUsername: UITextField = {
        
        let txtUserName = makeTextField(text: "Enter username", view: self.view)
        
        // NOTE: This is the bid from: VIEW to VIEW-MODEL
        txtUserName.bind { [weak self] text in
            
            //Cada vez que se preisona una tecla, es ejecutado el Binding:
            print(text)
            
            //the username is no longer String, now is a Dynamic type.
            self?.loginVM.username.value = text
        }
        
        return txtUserName
    }()
    
    lazy var txtPassword: UITextField = {
        
        let txtPassword = makeTextField(text: "Enter password", view: self.view)
        txtPassword.isSecureTextEntry = true

        
        // NOTE: This is the bid from: VIEW to VIEW-MODEL
        txtPassword.bind { [weak self] text in
            
            //the password is no longer String, now is a Dynamic type.
            self?.loginVM.password.value = text
        }
        
        return txtPassword
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Register the Username for the Binding:
        //The closure is going to get call, whenever the username property is settted.
        loginVM.username.bind { [weak self] text in
            //Here now, wen can't access the Textfield, because is inside the "setupView" property.
            //The easiest way is crating a Lazy property on the Top, inside the view Controller
            
            //Right way:
            self?.txtUsername.text = text
        }
    
        
        //Create the bind listener for Password
        loginVM.password.bind { [weak self]text in
            self?.txtPassword.text = text
        }
        
        
        setupView()
    }
    
    private func setupView() {
        
        let lblTitle = makeLabel(text: "Binding: VIEW to VIEW-MODEL", size: 20, view: view)
        lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //        let txtUsername = makeTextField(text: "Enter username", view: self.view)
        txtUsername.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        txtUsername.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //
        //        // NOTE: This is the bid from: VIEW to VIEW-MODEL
        //        txtUsername.bind { [weak self] text in
        //
        //            //Cada vez que se preisona una tecla, es ejecutado el Binding:
        //            print(text)
        //
        //            //the username is no longer String, now is a Dynamic type.
        //            self?.loginVM.username.value = text
        //        }
        //
        //        let txtPassword = makeTextField(text: "Enter password", view: self.view)
        //        txtPassword.isSecureTextEntry = true
        txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 15).isActive = true
        txtPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //
        //        // NOTE: This is the bid from: VIEW to VIEW-MODEL
        //        txtPassword.bind { [weak self] text in
        //
        //            //the password is no longer String, now is a Dynamic type.
        //            self?.loginVM.password.value = text
        //        }
        
        let loginButton = makeButton(withText: "Login", action: #selector(login), view: self.view)
        loginButton.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 15).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let fetchLoginInfoButton = makeButton(withText: "Fetch login info", action: #selector(fechLoginInfo), view: self.view)
        fetchLoginInfoButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        fetchLoginInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func login() {
        print("The binding:")
        print(loginVM.username.value)
        print(loginVM.password.value)
    }
    
    // NOTE: This allows to change the value: VIEW-MODEL to VIEW
    @objc private func fechLoginInfo() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            
            //the username is no longer String, now is a Dynamic type.
            //you need to add the "value" property:
            self?.loginVM.username.value = "Josue Alvarez"  //This line is the one that will change the username property.
            //After 2 seconds and once the value is changed, the "didSet lister(value)" is going to get fired. so pass the new value to the listener.
            //The listener is in the ViewDidLoad, listening by "bind" function.
            
            
            //Update password by bind:
            self?.loginVM.password.value = "123"
        }
        
    }
}

// MARK: Utilities:

extension ViewController {
    
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
    
    private func makeButton(withText title: String, color: UIColor? = nil, action: Selector, view: UIView) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        
        if color != nil { config.baseBackgroundColor = color }
        
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
