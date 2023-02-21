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
            
            /*
             The only reason there is a synchronize method is so your app can tell NSUserDefaults to persist the dictionary "now"
             instead of waiting for the automatic saving that will eventually happen.
             
             And the only reason you ever need to do that is because your app might be terminated (or crash) before the next automatic save.
             
             In my own apps, the only place I call synchronize is in the applicationDidEnterBackground delegate method.
             This is to ensure the latest unsaved changes are persisted in case the app is terminated while in the background.
             */
            //userDefault.synchronize()
        }
    }
}
