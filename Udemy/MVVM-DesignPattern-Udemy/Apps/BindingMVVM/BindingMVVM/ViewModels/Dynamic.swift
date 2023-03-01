//
//  Dynamic.swift
//  BindingMVVM
//
//  Created by Fabian Josue Rodriguez Alvarez on 23/2/23.
//

// NOTE: This class allos the APP, Binding the Textfield from: VIEW-MODEL to VIEW.
class Dynamic<T> {
    
    typealias Listener = (T) -> Void //Closure
    var listener: Listener?
    
    //When the Username is setted, the listener is fired, so we can get the value and assign it to the VIEW.
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(callback: @escaping(T) -> Void) {
        self.listener = callback
    }
    
    init(_ value: T) {
        self.value = value
    }
}
