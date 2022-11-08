//
//  ViewController.swift
//  Pruebas-UIKit
//
//  Created by Fabian Josue Rodriguez Alvarez on 31/10/22.
//

import UIKit

//CICLO DE VIDA DE UN ViewController:
//Se hereda a UIViewController, por eso al llamar a "super." dentro de los metodos, se llama la logica herededada del UIViewController.
class ViewController: UIViewController {
    
    //NOTA: Los IBOulets vienen con un Force Unwrapped, porque lo primero que se carga es el ViewDidLoad, asi que se garantiza que esos Oulets tengan valores.
    @IBOutlet weak var constraintCenterLabel: NSLayoutConstraint!
    @IBOutlet weak var contraintTopLabel: NSLayoutConstraint! //Segundo Constraint, desactivado por defecto. Utilizado para subir el label al Top.
    
    //Estos llamados a las vistas son realizadas automaticamente por el sistema.
    //El ContentView es la vista principal que cotiene el Storyboard.

    //1: Called when "ContentView" is created in memory, or loaded from the storyboard.
    //Its called only for the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Para practica de constraints por codigo.
        createButton(view)
        
        //OTROS:
        higherOrderFunction()
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
    
    //MARK: - CONSTRAINTS:
    
    private func createButton(_ view: UIView) {
        
        let button = UIButton(type: .system)
        button.setTitle("Psuh me", for: .normal)
        button.addTarget(self, action: #selector(bottonPushed), for: .touchUpInside)
        
        //Se crea el boton y en los constraints, se indica que se ajuste al bottom de la pantalla
        view.addSubview(button)
        
        //cuando los constraint se crean se deben activar.
        let leftConstraint = button.leftAnchor.constraint(equalTo: view.leftAnchor) //Esto crea un constraint, pero se debe activar
        leftConstraint.isActive = true
        
        //Utilizar el idioma correcto: Leading o Trailig
        //let rightConstraint = button.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        //Se utiliza Trailing porque es derecho.
        let rightConstraint = button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        rightConstraint.isActive = true
        
        //Este es un ejemplo de un constraint creado sin tomar en cuenta el SafeArea:
        //let bottomConstraint = button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        //Mismo constraint creado tomando en cuenta el SafeArea, se agrega: "safeAreaLayoutGuide"
        let bottomConstraint = button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint.isActive = true

        //Despues de crear los constraints por codigo, hay 1 cosa mas que hacer
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //En caso de que se quiera agregar un Width especifico.
        //Al agregarlo, muestra el error:
        /*
         Will attempt to recover by breaking constraint
         <NSLayoutConstraint:0x6000026f34d0 UIButton:0x143f071f0'Psuh me'.width == 100   (active)>
         */
        //button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Una forma facil de identificar el Constraint que está fallando, es agregar un identificador, para ver en el LOG cual es el incorrecto.
        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 100)
        widthConstraint.identifier = "bottom button Width"
        widthConstraint.isActive = true
    }
    
    @objc func bottonPushed(_ button: UIButton) {
        
        adjustViewPosition()
    }
    
    private func adjustViewPosition() {
        //NOTA: Cuando se utiliza AutoLayout en los constraint, no se debe cambiar el size o position, con CGRect o CGPoint.
        
        //Se debe acceder al constraint que ya tiene asignado en el Storyboard, para subir la vista al Top Screen, que actualmente está centrado.
        
        //Esta manera no es la correcta, por lo que una forma conveniente de hacerlo, es tener 2 constraint y usar uno u otro, dependiendo de la necesidad.
        //constraintCenterLabel.constant = -view.frame.size.height / 2 + 100 //Se sube la vista, ajustando la constante del Constraint.
        
        //Al agregar un segundo constraint, se ve una casilla que dice "installed" al seleccionar ese contraint. Eso indica si el Constraint está activo o no. (en las opciones del storyboard).
        //Lo que se debe hacer, es desactivar el constraint que centra el label y activar el del TOP (Segundo constraint agregado).
        //constraintCenterLabel.isActive = false
        //contraintTopLabel.isActive = true
        
        //validacion para hacerlo dinamico.
        if constraintCenterLabel.isActive {
            
            constraintCenterLabel.isActive = false
            contraintTopLabel.isActive = true
        } else {
            constraintCenterLabel.isActive = true
            contraintTopLabel.isActive = false
        }
    }
    
    
    //MARK: - Higher-Order Function:
    
    /*
     In mathematics and computer science, a higher-order function is a function that does at least one of the following:

     – takes one or more functions as arguments (i.e. procedural parameters),

     – returns a function as its result.

     All other functions are first-order functions.
     */
    
    //Higher order functions are based on closures.
    
    /*
     Higher order functions are applied to arrays, dictionaries and sets in swift.
     In simple way we use higher order functions in place of writing so many for loops to loop through arrays, dictionaries and sets.
     
     List of higher order functions:
     
     Map
     CompactMap
     FlatMap
     Reduce
     Filter
     Contains
     Sorted
     ForEach
     removeAll
     */
    private func higherOrderFunction(){
        
        let fruits = [
            "apple",
            "orange",
            "cherry"
        ]

        var uppercasedFruits = fruits.map { $0.uppercased() }
        
        print("********************************************")
        print("Uppercased: ", uppercasedFruits)
        print("********************************************")
        
        
        /*
         If we want to remove some occurrence of any sub string from a string or any element from collection which matches the condition then we can use removeAll
         */
        uppercasedFruits.removeAll(where: { $0 == "APPLE" })
        
        print("********************************************")
        print("removedApple: ", uppercasedFruits)
        print("********************************************")
        
        
        /*
         for each works like for loop in swift,
         only difference is we can’t use continue or break inside for loop , so it will make sure we go through each and every element of collection
         */
        var lowerCasedClosure: [String] = []
        var lowerCasedSymbol: [String] = []
        
        //Con closure item
        uppercasedFruits.forEach { item in
            lowerCasedClosure.append(item.lowercased())
        }
        
        uppercasedFruits.forEach { lowerCasedSymbol.append($0.lowercased()) }
        
        print("********************************************")
        print("lowerCasedSymbol: ", lowerCasedSymbol)
        print("********************************************")
    }
    
}

