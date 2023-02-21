//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

import Foundation

enum Unit: String, CaseIterable {
    case celcius = "metric"
    case farenheit = "imperial"
}

extension Unit {
    
    var displayName: String {
        get {
            switch(self) {
            case .celcius:
                return "Celcius"
                
            case .farenheit:
                return "Farenheit"
            }
        }
    }
}

class SettingsViewModel {
    
    let units = Unit.allCases
    
    var selectedUnit: Unit {
        get {
            let userDefault = UserDefaults.standard
            var unitValue = ""
            
            if let value = userDefault.value(forKey: "unit") as? String {
                unitValue = value
            }
            
            return Unit(rawValue: unitValue) ?? Unit.celcius //Celcius by default
        }
        
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
}
