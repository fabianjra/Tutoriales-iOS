//
//  AppDelegate.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 15/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavigationBar()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //Crea el estilo para el Navigationbar
    private func setupNavigationBar(){
        let lightBlue = UIColor(red: 0/255, green: 141/255, blue: 211/255, alpha: 1.0) /* #008dd3 */
        let whiteColorText = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //Old background color method:
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = lightBlue
        appearance.titleTextAttributes = whiteColorText
        appearance.largeTitleTextAttributes = whiteColorText
        
        UINavigationBar.appearance().standardAppearance = appearance;
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        //UINavigationBar.appearance().prefersLargeTitles = true //Se va a majear independientemente en cada vista.
        
        //Change buttons nvigationBar color:
        UIBarButtonItem.appearance().tintColor = .white
        
        //NOTA:
        /*
         Para mantener siempre el Statusbar en color blanco se raliza lo siguiente:
         1: Se selecciona en el archivo de la aplicacion (icono azul), el Status Bar Style: Light Content.
         2: Se agrega al archivo "info.plist" la llave: "View controller-based status bar appearance" con valor en "NO".
         */
    }
    
    static func getWeatherURL(_ cityName: String) -> URL {
        let apiKey = "4b04a0477518e155d94c9a37678059bb"
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=imperial"
        
        return URL(string: weatherURL)!
    }
}

