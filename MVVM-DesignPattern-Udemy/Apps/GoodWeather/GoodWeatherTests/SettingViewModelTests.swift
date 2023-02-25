//
//  SettingViewModelTests.swift
//  GoodWeatherTests
//
//  Created by Fabian Josue Rodriguez Alvarez on 24/2/23.
//

import XCTest

@testable import GoodWeather

final class SettingViewModelTests: XCTestCase {

    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.settingsVM = SettingsViewModel()
    }
    
    //We want to see if the default weather unit is "Farenheit".
    func test_should_make_sure_that_default_selected_unit_is_farenheit() {
        
        XCTAssertEqual(self.settingsVM.selectedUnit, .celcius)
    }
    
    //Valdia que el nombre para el displayname sea el correcto
    func test_should_return_correct_display_name_for_celcius() {
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Celcius")
    }
    
    //Valida que la seleccion de unit, sea correctamente guardado en el "UserDefaults"
    func test_should_be_able_to_save_user_unit_selection() {
        
        //En este ejemplo se ha guardado en UserDefaults un dato, deberia borrarse despues de finalizar la prueba.
        self.settingsVM.selectedUnit = .farenheit
        let userDefaults = UserDefaults.standard
        
        XCTAssertNotNil(userDefaults.value(forKey: Constants.unit))
    }
    
    //En el test: "test_should_be_able_to_save_user_unit_selection" se guarda o se modifica un dato en UserDefaults.
    //Esto debe deshacerse cuando finaliza la prueba.
    override func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Constants.unit)
    }
}
