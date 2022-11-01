//
//  ViewController.swift
//  Pruebas-UIKit
//
//  Created by Fabian Josue Rodriguez Alvarez on 31/10/22.
//

import UIKit

//NOTA: Los IBOulets vienen con un Force Unwrapped, porque lo primero que se carga es el ViewDidLoad, asi que se garantiza que esos Oulets tengan valores.

//CICLO DE VIDA DE UN ViewController:
//Se hereda a UIViewController, por eso al llamar a "super." dentro de los metodos, se llama la logica herededada del UIViewController.
class ViewController: UIViewController {
    
    //Estos llamados a las vistas son realizadas automaticamente por el sistema.
    //El ContentView es la vista principal que cotiene el Storyboard.

    //1: Called when "ContentView" is created in memory, or loaded from the storyboard.
    //Its called only for the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //2: Called before "ContentView" is added to app's view hierarchy.
    //Just before the view shows up on the screen.
    //La vista se agrega a la jerarquia, aunque esté oculta, porque se encuentra instanciada.
    //ViewWillApear no significa que la vista necesariamente se vaya a mostrar, porque podria tener el atributo hidden.
    //Its called everytime the view is gonna appear (maybe coming back from another screen).
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //3: Called after the "ContentView" is added to app's view Hierarchy.
    //To: add a visual animation.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //4: Called before the "ContentView" is removed from the app's view hierarchy.
    //To: commiting save cahnges.
    //To: Do something before the view is gone.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //5: Called after the "ContentView" is removed from the app's view hierarchy.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - LAYOUTS:
    
    //There is no default implementation.
    //They are for give acces to this point in time, to make changes if need.
    
    //1: Called when the content view's bounds change, but BEFORE it lays out its subviews.
    //Example: When you rotate the phone from portrait to landscape.
    override func viewWillLayoutSubviews() {
        
    }
    
    //2: Called when the content view's bounds change, but AFTER it lays out its subviews.
    //Example: When you rotate the phone from portrait to landscape.
    //Maybe for an animation.
    override func viewDidLayoutSubviews() {
        
    }
}

