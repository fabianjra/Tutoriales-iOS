# Tutoriales iOS

Proyectos y codigo basado en cursos de Udemy, libros y tutoriales de Youtube.
Algunos codigos de ejemplos son ligeramente cambiados a sus videos originales para efectos de aprendizaje.

<p>&nbsp;</p>

## Proyectos:

- [Youtube: ComponentesSwiftUI](#ComponentesSwiftUI)
- [Youtube: Pruebas-UIKit](#Pruebas-UIKit)
- [Youtube: Inventory Managment](#InventoryManagment)
- [Libro: MasteringSwiftUI](#MasteringSwiftUI)
- [Udemy: LevelUpInAutoLayout](#LevelUpInAutoLayout-UdemyCourse)
- [Udemy: RxSwift](#RxSwift)
- [Udemy: MVVM Design Pattern](#MVVM-DesignPattern-Udemy)
- [Udemy: Async/Await-and-Actors-Concurrency](#Async-Await-and-Actors-Concurrency)
- [Youtube: General videos](#youtube-general-videos)

<p>&nbsp;</p>


## ComponentesSwiftUI

Componentes de SwiftUI con ejemplos explicados por el youtuber Victor Roldan Dev.
[Link del canal en youtube de Victor Roldan DEV](https://www.youtube.com/@VictorRoldanDev).

**Componentes:**
- Shapes
- Searchable
- TabViews
- TabView customizable
- StatesWrappers
- ObservablesWrappers


<p>&nbsp;</p>


## Pruebas-UIKit

Ejemplos de codigo para UIKit y generalidades como

**Codigos sobre:**
- High Order Functions
- Constraints
- Fases de los view en un ViewController

Se agregó un Playground para codigo de ejemplo sobre `Grand Central Dispatch`.


<p>&nbsp;</p>


## InventoryManagment

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/VictorRoldanDev/InventoryManagment)
- **Description:** App maquetada con diseño hecha en SwiftUI. Es un video tutorial de Yotube por Victor Roldan DEV.
    * A los elementos se les agregó su modelo para cargar la vista con datos dinamicamente.
    * Hay varios `TODO` para finalizar por cuenta propia.
    * Link del tutorial en Youtube: [Aprende a maquetar con SwfitUI](https://youtu.be/TdO5lCcGA4U)
    * Diseño original: [Admin & Inventory Management App](https://dribbble.com/shots/5395283-Admin-Inventory-Management-App-Day-287-365-Project365/attachments/5395283?mode=media)
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/Youtube/VictorRoldanDev/InventoryManagment/InventoryManagment/Assets.xcassets/InventoryManagmentScreenshot.imageset/InventoryManagmentScreenshot.png" width="200">


<p>&nbsp;</p>


## MasteringSwiftUI

- Componentes generales.

Libro sobre SwiftUI por Simon NG.
Almacenado en mediafire. Link Host mediafire "mediafire.com" + link:  /file/chrmfh0cxvhrs1m/Mastering_swiftUI_Simon_NG.pdf/file


<p>&nbsp;</p>


## LevelUpInAutoLayout-UdemyCourse

Curso de Udemy sobre Auto Layout.

Workspace compuesto por proyectos: 
- LevelUpInAutoLayout: Proyecto general.
- 1-Examples: Lista de configuraciones.
- Carpeta "DesignChallenges": Challenges para crear vistas.

### Intrinsic Content Size:

Its the natural size of an iOS control wants to be (default size of a control).
This allows controls to lay themselves out without requering full contraints.

- “CHCR” Give us the ability to flex our controls:

Example: Label and size is (50, 20)

- Content Hugging: “hug” `<= 50`
*Es decirle que no va a permitir que se amplíe hasta cierto punto. Lo “abraza”.
Im not gonna let you grow.*

- Compression Resistance:  “resist” `>= 50`
*Es decirle que resista, para que no permita encogerse tanto. Lo retiene desde andetro, como si estuveira extendiendo lo brazos.
Im not gonna let you shrink.*

Se le asigna una anchura, pero en caso de necesitarlo, puede ampliarse o reducirse un poco a conveniencia.

- Priorities decide:

**UILayoutPriority:**
- .required: 1000 (anchors)
- .defaultHight: 750 (intrinsic size) optional. (I can being compressed)
- .defaultLow: 250 (intrinsic size) optional. (I can stretch)

**Resolver conflictos:**
- By hugging myself a bit less, I make myself more stretchable, setting defaultLow from 250, to 249.

**RESUME:** 
- InstrinsicContentSize constraints are optionals.
- We Adjust them through CHCR.
- They can be overridden with anchors.

**Key points:**
- We do most of our layout with anchors.
- Occasionally we tweak the CHCR of controls to resolve ambiguity.
- This is how we make our applications adaptive in their layout.

**Links that helps (Intrinsic Content Size):**
- [Views with Intrinsinc Content Size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
- [Content Hugging Compression Resistance (CHCR)](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)

### UIStackView:

* This is a container (has no intrinsic content size of it's own). 
* Not all distribution work the same.
* Everything inside needs to be intrinsically content sized (Everything needs to be able to size itself).
* Stackviews doesn't have a specific size by default, the dinamically change based on the content it has inside (buttons, labels, etc).
* Source code example (Stackview and CustomView): [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/CustomViewChallenge/CustomViewChallenge/Challenge.swift)

**Distribution: Fill:**
- Fills all available space.
- Default settings.
- Uses Intrinsic Content Size (CHCR).
- If CHCR the same, will complain.

**Distribution: Fill equally:**
- Makes all controls the same size.
- Only distribution NOT use intrinsic content size.
- Fill equally will break the optional intrinsic content size in order to fill equally.
- Remember: Intrinsic content size is a recomendation, not a requirement.

**Distribution: Fill proportionally:**
- Mantains proportions as layout grows and shrinks.

**Distribution: Equal spacing:**
- Calculate the entire space and tries to make them all the same in base of all controls inside. 

**Distribution: Equal centering:**
- Spaces equally between center of controls.

**Links that helps (Stack Views):**
- Googleable Terms: `UIStackView`, `Distribution`, `Alignment`, `UIScrollView`.

- [UIStackViews](https://developer.apple.com/documentation/uikit/uistackview)
- [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
- [Auto Layout Cookbook Example](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1)
- [Distribution](https://developer.apple.com/documentation/uikit/uistackview/distribution)
- [Alignment](https://developer.apple.com/documentation/uikit/uistackview/alignment)
- [NSHipster](https://nshipster.com/uistackview/)

*Gotchas:*
- When adding views to `UIStackView` remember it's `addArrangedSubview` not `addSubview`.

### Adaptive layouts:

There are 3 ways to tweak the constraints:

- Change the constant: `.topAnchorConstraint.constant == 44`. 
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Constants.swift)

<p>&nbsp;</p>

- Enable / disable: `.leadingAnchorConstraint.isActive = true / false`. 
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Constraints.swift)
- Practice: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/Adaptive/NudgeTheLabel/NudgeTheLabel/BlueView.swift)

<p>&nbsp;</p>

- Toggle visibility: `label2.isHidden = true / false`. 
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Visibility.swift)
- Practice: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/AdjustSpacersBlueView.swift)

<p>&nbsp;</p>

- Challenge practice (Rotation, CustomView, StackView, enable/disable constraints): [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/SpotifyPlayer/SpotifyPlayer/SpotifiyPlayerRotation/SpotifiyPlayerRotation.swift)

**Orientation:**
- In this example and design challenge we used `UIDevice.current.orientation.isLandscape` to determine device orientation. This works, but its deprecated and no longer the ideal way. I used it purely for it's simplicity and to focus more on the Auto Layout.
- If you want to talk orientation changes, the language we use today is more around class sizes. This is because on the iPad you can be in what looks like a landscape orientation but really render in portrait. So large iPhone sizes enable you to do this too.
- In this cases you want to listen for callbacks and events from the `UITraitCollection` class which you can read more about here.
- [Link for UITraitCollection](https://developer.apple.com/documentation/uikit/uitraitcollection)

<p>&nbsp;</p>

## RxSwift

Curso de Udemy sobre RxSwfit.


<p>&nbsp;</p>


## MVVM-DesignPattern-Udemy

### Pattern: MVC (Model-View-Controller):
- **Model**: Data. The primary porpuse of the models, is to get the information from an API and set to the model, so the data can be manipulated. 
- **View**: User interface.
- **Controller**: The middle. This is in charge of the comunnication bewteen the model and the view.

### Pattern: MVVM (Model-View-ViewModel):
This pattern is similar to MVC, but this allows you to "decopling" between the view and the business logic.

- **MVVM:** Model - View - ViewModel
    * The `Model` notify to the `ViewModel`.
    * The `ViewModel` bind the `View`: ViewModel: Valida la informacion que recibe del View (logica de negocio).
    * The `View` talk to the `ViewModel`.
    * The `ViewModel` update the `Model`.

### _Apps made up with MVVM:_

### GoodNews:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodNews)
- **Description:** This app consumes an API for news, get a title and description to show in a TableView by `URLSession.shared.dataTask` and map the JSON to a "article" model.
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodNews/GoodNews/Assets.xcassets/GoodNewsAppScreenshot.imageset/GoodNewsAppScreenshot.png" width="200">

### HotCoffe:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/HotCoffe)
- **Description:** This app get orders by a WebService by `GET` http method. Those orders are shown in the Main `TableView`. It casn also add orders by adding a new one, using `POST` http method. The app uses `Coding`, `Decoder` and `Cncoder` to manipulate the data and model.
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/MVVM-DesignPattern-Udemy/Apps/HotCoffe/HotCoffe/Assets.xcassets/HotCoffeeAppScreenshot.imageset/HotCoffeeAppScreenshot.png" width="200">

For this App, we need to consume an API where we add orders, get orders and remove orders. This is the data we need to know for using it on Postman:

- Get all offee orders (GET method): https://warp-wiry-rugby.glitch.me/orders
- Delete all coffe orders (GET method): https://warp-wiry-rugby.glitch.me/clear-orders
- Post a new coffee order (POST method): https://warp-wiry-rugby.glitch.me/orders
- JSON structure for adding a new order:
```
{
    "name": "Josh Alvz",
    "email": "josh@gmail.com",
    "type": "Lattee",
    "size": "medium"
}
```

### GoodWeather:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodWeather)
- **Description:** This app get city names from an API and gets the weather temperature in celcius and farenheit. This app cosumes an API in this WEB: https://openweathermap.org/
- **Utilites:** There are some utilites like for example, show a global `UIAlertController` or validate if a `textField` is empty. This is the file: [Utils source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodWeather/GoodWeather/Utils/Utils.swift)
- **Unit Test examples:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodWeather/GoodWeatherTests)
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/MVVM-DesignPattern-Udemy/Apps/GoodWeather/GoodWeather/Assets.xcassets/GoodWeatherAppScreenshot.imageset/GoodWeatherAppScreenshot.png" width="200">

### Bindigs:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/BindingMVVM)
- **Description:** There are differents ways to bind, 2 commons:
* `'View` to `View Model`: Example: A `View` has 2 `textfields` "name" and "age". Each time the text changes on the screen, the 2 properties (var) on the `ViewModel` has to change also, beacuase they are binded to the `View`. This should be automatically.
* `View Model` to `View`: Example: Same 2 `textfields` "name" and "age" are on the `ViewModel`. Whenever these 2 properties changes, this update is going to be reflected on the `View` (Textfield on the screen).
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/MVVM-DesignPattern-Udemy/Apps/BindingMVVM/BindingMVVM/Assets.xcassets/BindingMVVMAppScreenshot.imageset/BindingMVVMAppScreenshot.png" width="200">

### TESTING:

- Unit Test project: [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/MVVM-DesignPattern-Udemy/Apps/Calculator) 

1. **UNIT TEST:** Unit Test allows the developer to write code which test other pieces of code.
    - FAST: Doesn't have to depend on a service.
    - AUTOMATED: Doesn't have to write it again and again.
    - INDEPEND: Example: You can't say that you can't run the test because a service is down.
    - REPEATABLE: You can run many times the test.

2. **Test Driven Development (TDD):** Start writing a failing test -> make the test pass -> refactor. 

- For adding the UNIT TEST class: Select the project (blue icon), then go to EDITOR -> ADD TARGET -> Select: Unit Testing Bundle and create it. This will create the Test Class (XCTestCase).
- All test, have to start with "test" in the function name.
- One way to add a "project class" to the Test project, is selecting the class, then RightSideBar: -> Show File Inspector -> Target Membership -> Select the Unit Test Project.
- Another way is to import te project to the Test Case: `@testable import Calculator`
- The function `setUp()` allows us to create an instanciation of something we are going to use across the Tests.
- The function `tearDown()` is going to excecute afer each Test.
- Run all test shortcut: `cmd + u`

### Bonus lecture:

- [Building Augmented Reality Apps Using RealityKit & ARKit](https://www.udemy.com/course/building-augmented-reality-apps-in-realitykit-arkit/?referralCode=BB7A8EC8AEA928AAD34F)
- [Introduction to Server Driven UI in iOS](https://www.udemy.com/course/introduction-to-server-driven-ui-in-ios-swift-swiftui/?referralCode=2F57B10C28B68D440B89)
- [Test Driven Development in iOS Using Swift](https://www.udemy.com/course/test-driven-development-in-ios-using-swift/?referralCode=07649C41E6E184CE86B3)
- [SwiftUI Cookbook - Over 100 Recipes for Building iOS Apps](https://www.udemy.com/course/swiftui-cookbook-over-100-recipes-for-building-ios-apps/?referralCode=06ADC26414C593DE91B4)
- [Async/Await and Actors - Concurrency in Swift](https://www.udemy.com/course/asyncawait-and-actors-concurrency-in-swift/?referralCode=BE09E803E9E7CBF7F368)
- [Swift for Intermediate and Advanced iOS Developers](https://www.udemy.com/course/swift-for-intermediate-and-advanced-ios-developers/?referralCode=2F0103424A4D82742C72)
- [GraphQL with iOS and SwiftUI: The Complete Developers Guide](https://www.udemy.com/course/graphql-in-ios-using-swift/?referralCode=9A2C826D12F2E863275E)
- [Core Data in iOS](https://www.udemy.com/course/core-data-in-ios/?referralCode=F87F4552453DA9E776FE)
- [Flutter and Firebase - Build Real World iOS and Android Apps](https://www.udemy.com/course/flutter-firebase-build-real-world-ios-and-android-apps/?referralCode=007B47CAB3795A71C57A)
- [Writing Clean Code](https://www.udemy.com/course/writing-clean-code-swift/?referralCode=CEB5F35104C973122FE7)
- [The Complete Hands-On SwiftUI Apps Using Firebase](https://www.udemy.com/course/the-complete-hands-on-swiftui-apps-using-firebase/?referralCode=688190DEB57CD2E86A8F)
- [MVVM Design Pattern in SwiftUI](https://www.udemy.com/course/mvvm-design-pattern-in-swiftui/?referralCode=DBCF3B88D25104DA4FB2)
- [Machine Learning and Artificial Intelligence Using Swift](https://www.udemy.com/course/machine-learning-and-artificial-intelligence-using-swift/?referralCode=CB992C10526C60C084DB)
- [SwiftUI - Declarative Interfaces for any Apple Device](https://www.udemy.com/course/swiftui-declarative-interfaces-for-any-apple-device/?referralCode=EB97896D293C976B3231)
- [Flutter and Dart - Build Apps Using MVVM Design Pattern](https://www.udemy.com/course/flutter-dart-mvvm-design-pattern/?referralCode=3E32698D188E47553501)
- [Mastering RxSwift in iOS](https://www.udemy.com/course/mastering-rxswift-in-ios/?referralCode=4B50D1EF895799098F55)
- [Mastering ARKit for iOS](https://www.udemy.com/course/mastering-arkit-for-ios-using-swift/?referralCode=E52ADAFBC9DA334B8B47)
- [Intermediate and Advanced iOS - Build Real World Apps](https://www.udemy.com/course/building-real-world-ios-apps-using-swift/?referralCode=872A9E8AF6F238EB7FB0)
- [The Complete Guide to JSON Parsing in Swift](https://www.udemy.com/course/ultimate-guide-to-json-parsing-with-swift/?referralCode=8E75504604F2D5D6BF00)
- [Mastering MapKit for iOS](https://www.udemy.com/course/mastering-mapkit-for-ios/?referralCode=3F231ECA284DAB0947D7)
- [Machine Learning in iOS Using Swift](https://www.udemy.com/course/mastering-core-ml-for-ios/?referralCode=E1E95CF3FAFBB5C123A3)
- [Mastering Firebase for iOS Using Swift](https://www.udemy.com/course/practical-firebase-for-ios-using-swift/?referralCode=F37F1A54C6DD750475A5)
- [The Complete Guide to Lean Controllers in iOS](https://www.udemy.com/course/a-complete-guide-to-lean-controllers-in-ios/?referralCode=293D4E7C65E565EF9F47)


<p>&nbsp;</p>


## Async-Await-and-Actors-Concurrency

- **THREADS:** They are useful when you need perform a task without blocking the rest of the application.

- **Gran Central Dispatch:** GCD is a low-level API for managing concurrent operations. It can help to improve the app’s responsiveness, allowing concurrency in tasks. GCD is in charge of administrate queues.

- **QUEUES:**
    * Main Queue: Runs on the main thread. `DispatchQueue.main`. Should be used only for UI events. The main thread is Serial Queue. FIFO.
    * Global Queue: Allows concurrency that are shared by the whole system (High, Default, Low y Background). `DispathQueue.global`. Background thread should be used for downloading tasks and other events that shouldn't block the UI.
    * Custom Queue: These can be either serial or concurrent.

- **QUEUE TYPES:**
    * Serial: This is a way to do tasks. They are in line, excecuting one by one, once tha last task is completed.
    * Concurrent: They run without an order, runs at the same time and they are administrated by Grand Central Dispatch.
    
- **QoS: Quality of Service:** This is a class property that indicates the task’s importance and guides the GCD in the priority to give.

    1. User interactive: Animations or events handling.
    2. User initiated: Work that the user kicks off and should yield immediate results. This work must be completed for the user to continue.
    3. Default: This is preferred, which means that is the QoS by default. It's going to take a decision on your behalf in selecting the default or whatever kind of QoS.
    4. Utility: For tasks that the user doesn't track actively. Work that may take a bit and doesn’t need to finish right away. Analogous to progress bars and importing data
    5. Background: This work isn’t visible to the user. Backups, syncs, indexing, etc.
    6. Unspecified: No QoS or priority setting defined.
    
    ```
    DispatchQueue.global(qos: .userInteractive) - highest priority
    DispatchQueue.global(qos: .userInitiated)
    DispatchQueue.global() // default
    DispatchQueue.global(qos: .utility)
    DispatchQueue.global(qos: .background) - lowest priority 
    ```
    
How to switch from to the Global Background Thread to the Main Thread:

```
DispatchQueue.global().async {
    //download the image
    
    DispatchQueue.main.Async {
        //Refresh the UI
    }
}
```

- **Deprecated code:**
    * `Async { }` is now: `Task { }`
    * `asyncDetached { }` is now: `Task.detached { }`

- **Resources:**
    * [Concurrency and Multithreading in iOS](https://www.viget.com/articles/concurrency-multithreading-in-ios/)
    * [Medium: Concurrency in Swift (GCD PT1)](https://ali-akhtar.medium.com/concurrency-in-swift-grand-central-dispatch-part-1-945ff05e8863)
    * [Swift by Sundell: Task-based concurrency in Swfit](https://www.swiftbysundell.com/articles/task-based-concurrency-in-swift/)
    * [Cocoacasts: Threads, Queues, and Concurrency](https://cocoacasts.com/swift-and-cocoa-fundamentals-threads-queues-and-concurrency)


- **Continuation:**
    * This is for export our existing functions which are using Callbacks, to use async.


### GettingStartedAsyncAwait App:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Udemy/Async-Await-Actors-Concurrency/Apps/GettingStartedAsyncAwait)
- **Description:** This app uses an API: https://ember-sparkly-rule.glitch.me/current-date which returns this Json:
`{"date":"Wed Mar 01 2023 05:50:29 GMT+0000 (Coordinated Universal Time)"}`. This app fills a List based on the button, to get the current date an append to the list.
- **Screenshot:** 
<img src="" width="200">


- **Tasks:**
    * [Diference between task and detached task](https://www.hackingwithswift.com/quick-start/concurrency/whats-the-difference-between-a-task-and-a-detached-task)
    * [async-let](https://github.com/apple/swift-evolution/blob/main/proposals/0317-async-let.md)
    * [Strcutured concurrency](https://github.com/apple/swift-evolution/blob/main/proposals/0304-structured-concurrency.md)

- **Concurrencia en Tasks:**
    * [Avoiding Race Conditions in Swift](https://medium.com/swiftcairo/avoiding-race-conditions-in-swift-9ccef0ec0b26)

- **actor (class):**
    * Si se quiere utilizar "actor" en luegar de "class" para una clase, se debe tomar en cuenta que por defecto esa clase no se puede modificar desde afuera, pero se puede utilizar async para la modificacion de sus propiedades. En el proyecto "LearnActors" se puede ver el ejemplo.
    * Actos permite hacer concurrencia, pero ejecutando una sola accion a la vez si es que está validada.
    * _Error mostrado: `Actor-isolated instance method 'withDraw' can not be referenced from a non-isolated context` _
    * [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/Async-Await-Actors-Concurrency/Apps/LearnActors/LearnActors/ContentView.swift)

- **Task:**
    * Task.detached: Esta forma de llamar a una funcion asincrona, permite que no se ejecuta sobre el Main Thread.
    * Con "await MainActor.run {" se puede realizar un llamado al Main Thread dentro de deteched.
    * Ejemplo: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/Udemy/Async-Await-Actors-Concurrency/Apps/LearnMainActor/LearnMainActor/View%20Models/TodoListViewModel.swift)

- **WWDC 2021 videos async/await:**
    * [Meet async/await in Swift](https://developer.apple.com/videos/play/wwdc2021/10132/)
    * [Explore structured concurrency in Swift](https://developer.apple.com/videos/play/wwdc2021/10134)
    * [Meet AsyncSequence](https://developer.apple.com/videos/play/wwdc2021/10058)
    * [Protect mutable state with Swift actors](https://developer.apple.com/videos/play/wwdc2021/10133)


<p>&nbsp;</p>


## Youtube General Videos

### Projects:

- **SwiftUI MVVM Pattern:**
    - **Title:** SwiftUI MVVM Pattern (Model View ViewModel) - Xcode 12, 2022, Weather App, iOS Development
    - **Link video:** [Video](https://www.youtube.com/watch?v=ak8x-p-q8tU)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/MVVM/WeatherAppMVVM)
    - **Description:** In this video we will learn how to apply the MVVM architecture pattern to our swiftui app. We will build a real world weather app as an example - working with the latest versions of swift and xcode.


- **SwiftUI with Firebase:**
    - **Title:** Complete SwiftUI Firebase Tutorial: Auth, Sign Up Page, Cloud Firestore, Read & Write Data
    - **Link video:** [Video](https://www.youtube.com/watch?v=6b2WAePdiqA)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/Firebase/FirebaseTutorial)
    - **Description:** This SwiftUI Firebase Tutorial walks you through how to use Firebase Auth (Authentication) and Firebase Cloud Firestore with SwiftUI to create a sign up page, read / fetch data, and write to a database using a swiftui list view. SwiftUI is one of the best ways for beginners to learn how to create their own app in iOS / Swift. You will need Xcode to complete this tutorial.
    - **Notes:**
        * Agregar la dependencia: [Link firebase dependency](https://github.com/firebase/firebase-ios-sdk.git)
        * Aagregar las siguientes opciones: `FirebaseAuth`, `FireabaseFirestore`
        * Descargar el archivo`GoogleService-Info.plist` de Firebase para agregarlo al proyecto. Esto al crear el proyecto en la consola de FB.


- **Core Animation Swift:**
    - **Title:** Introduction to Core Animation (iOS/Swift)
    - **Link video:** [Video](https://youtu.be/93bfh3GK79s)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/Core%20Animation/AnimationFun)
    - **Description:** Core Animation is the library mostly in charge of every animation you see that happens in the iPhone. Normally it is used in UIKit. Core Animation works on the `CALayer`. This is under every `UIView` in the app. For example: `cornerRadius`, `shadows` or `animations` happens in the CALayer.
    - **Swift Arcade github repository:** [Source](https://github.com/jrasmusson/swift-arcade)
    - **Example:** It is used to scale a `UIView`, rotate it by animation or shake a `textField` when the input is wrong.
    - **General:** In the function `viewDidAppear`, the View is layed out. So here we know what is the size of the screen. It can be used to center a view in the screen with no hard coded values.
    - **Propiedaes:**
        * Model layer: Track the configuration of the view (position, attributes, round corner, etc).
        * Presentation layer: What the shape looks like while animating.


- **Navigation Stack SwiftUI:**
    - **Title:** How to use NavigationStack in SwiftUI | Bootcamp #62
    - **Link video:** [Video](https://youtu.be/GZ-hQWMjT0s)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/ComponentsSwiftUI/SwiftUIBootcamps)
    - **Description:** A.


- **Firebase SwiftUI: Complete Login/register with Models:**
    - **Title:** COMPLETE User Login / Sign Up App | Swift UI + Firebase | Async / Await
    - **Link video:** [Video](https://youtu.be/QJHmhLGv-_0?si=iywXzn_jHts0rFJ6)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/Firebase/FirebaseAppStuff)
    - **Description:** A.
    - **Notes:**
        * Firebase Storage: For images.


- **Swift Data SwiftUI:**
    - **Title:** Los fundamentos de SwiftData: Introducción con Xcode 15
    - **Link video:** [Video](https://youtu.be/e0WorWOu2HY?si=h8ZimoF6Za8DEmnC)
    - **Code:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/Youtube/VictorRoldanDev/SwiftDataTutorial)
    - **Notes:**
        * Swift Data oficial documentation: [WebPage](https://developer.apple.com/documentation/swiftdata)
        * Pasos para iniciar:
            1. Creacion del Model
            2. Configuracion Model Container
            3. @Query y Context en la vista.


- **Core Data Basics:**
    - **Title:** Building TodoList App in SwiftUI Using Core Data
    - **Link video:** [Video](https://www.youtube.com/watch?v=CZ79PpB7HIo&list=PLUtfZ6nWgIt0YagZuZS6NVdFw7R-lV7qb)
    - **Code:** [Source]()
    - **Description:** In this video, Mohammad Azam will demonstrate how to build a complete TodoList app using SwiftUI and Core Data.


- **Core Data Relationships:**
    - **Title:** Core Data relationships, predicates, and delete rules in Xcode | Continued Learning #16
    - **Link video:** [Video](https://youtu.be/huRKU-TAD3g?si=5uxWMCWcc31twRp4)
    - **Code:** [Source]()
    - **Description:** In this video, we take a deep dive into Core Data and learn how to create and manage multiple Core Data entities that have relationships between them.
    - **NOTES:**

