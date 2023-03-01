//
//  LoginViewModel.swift
//  BindingMVVM
//
//  Created by Fabian Josue Rodriguez Alvarez on 22/2/23.
//

//A ViewModel could be a Struct, depending on what the ViewModel is doing.
struct LoginViewModel {
    
    //Not all the values has to be Dynamic, only the ones you are interested in getting the value, so you can pass the value from the Model to the UI.
    var username = Dynamic("")
    var password = Dynamic("")
}
