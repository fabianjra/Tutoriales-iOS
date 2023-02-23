//
//  BindingTextField.swift
//  BindingMVVM
//
//  Created by Fabian Josue Rodriguez Alvarez on 22/2/23.
//

import UIKit

class BindingTextField: UITextField {
    
    var textChanged: (String) -> Void = { _ in } //Close for the subscribe.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //This init get fired when: Whenever we are trying to use the UI or the Storyboard, to construct a binding Textfield.
    //We are not using Storybard this time, but if you were, this particular function or initialize is going to get called when you deserialize the XML generated from the Storyboard into the Swift code.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // In this Initialize, we attach the Editing Change Event, so whenever we type something in the Binding Textfield, we listen to it.
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) //editingChanged: Permite que se ejecute cada vez que el texto cambia.
    }
    
    //The completion used in this function, has to match the one declared as a variable (textChanged).
    func bind(callback: @escaping(String) -> Void) {
        textChanged = callback
    }
    
    //The caller subscribe to the changes, using this function.
    //This could be made by using a closure.
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            textChanged(text) //The caller get the text.
        }
    }
}
