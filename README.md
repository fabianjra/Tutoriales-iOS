# Tutoriales iOS

Proyectos y codigo basado en cursos de Udemy, libros y tutoriales de Youtube.
Algunos codigos de ejemplos son ligeramente cambiados a sus videos originales para efectos de aprendizaje.

<p>&nbsp;</p>

## Proyectos:

- [Youtube: ComponentesSwiftUI](#ComponentesSwiftUI)
- [Youtube: Pruebas-UIKit](#Pruebas-UIKit)
- [Libro: MasteringSwiftUI](#MasteringSwiftUI)
- [Udemy: LevelUpInAutoLayout](#LevelUpInAutoLayout-UdemyCourse)
- [Udemy: RxSwift](#RxSwift)
- [Udemy: MVVM Design Pattern](#MVVM-DesignPattern-Udemy)


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
* Source code example (Stackview and CustomView): [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/Stacks/CustomViewChallenge/CustomViewChallenge/Challenge.swift)

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
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Constants.swift)

<p>&nbsp;</p>

- Enable / disable: `.leadingAnchorConstraint.isActive = true / false`. 
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Constraints.swift)
- Practice: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/Adaptive/NudgeTheLabel/NudgeTheLabel/BlueView.swift)

<p>&nbsp;</p>

- Toggle visibility: `label2.isHidden = true / false`. 
- Code example: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/Visibility.swift)
- Practice: [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/Examples/1-Examples/AdjustSpacersBlueView.swift)

<p>&nbsp;</p>

- Challenge practice (Rotation, CustomView, StackView, enable/disable constraints): [Source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/LevelUpInAutoLayout-UdemyCourse/DesignChallenges/SpotifyPlayer/SpotifyPlayer/SpotifiyPlayerRotation/SpotifiyPlayerRotation.swift)

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

### _Apps made up with MVVM:_

### GoodNews:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/MVVM-DesignPattern-Udemy/Apps/GoodNews)
- **Description:** This app consumes an API for news, get a title and description to show in a TableView by `URLSession.shared.dataTask` and map the JSON to a "article" model.
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/MVVM-DesignPattern-Udemy/Apps/GoodNews/GoodNews/Assets.xcassets/GoodNewsAppScreenshot.imageset/GoodNewsAppScreenshot.png" width="200">

### HotCoffe:

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/MVVM-DesignPattern-Udemy/Apps/HotCoffe)
- **Description:** This app get orders by a WebService by `GET` http method. Those orders are shown in the Main `TableView`. It casn also add orders by adding a new one, using `POST` http method. The app uses `Coding`, `Decoder` and `Cncoder` to manipulate the data and model.
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/MVVM-DesignPattern-Udemy/Apps/HotCoffe/HotCoffe/Assets.xcassets/HotCoffeeAppScreenshot.imageset/HotCoffeeAppScreenshot.png" width="200">

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

- **Project:** [Source](https://github.com/fabianjra/Tutoriales-iOS/tree/main/MVVM-DesignPattern-Udemy/Apps/GoodWeather)
- **Description:** This app get city names from an API and gets the weather temperature in celcius and farenheit. This app cosumes an API in this WEB: https://openweathermap.org/
- **Utilites:** There are some utilites like for example, show a global `UIAlertController` or validate if a `textField` is empty. This is the file: [Utils source](https://github.com/fabianjra/Tutoriales-iOS/blob/main/MVVM-DesignPattern-Udemy/Apps/GoodWeather/GoodWeather/Utils/Utils.swift)
- **Screenshot:** 
<img src="https://github.com/fabianjra/Tutoriales-iOS/blob/main/MVVM-DesignPattern-Udemy/Apps/GoodWeather/GoodWeather/Assets.xcassets/GoodWeatherAppScreenshot.imageset/GoodWeatherAppScreenshot.png" width="200">
