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

<p>&nbsp;</p>

### ComponentesSwiftUI

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

### Pruebas-UIKit

Ejemplos de codigo para UIKit y generalidades como

**Codigos sobre:**
- High Order Functions
- Constraints
- Fases de los view en un ViewController

Se agregó un Playground para codigo de ejemplo sobre `Grand Central Dispatch`.

<p>&nbsp;</p>

### MasteringSwiftUI

Componentes generales.

Libro sobre SwiftUI por Simon NG (almacenado en mediafire, link web + /file/chrmfh0cxvhrs1m/Mastering_swiftUI_Simon_NG.pdf/file).

<p>&nbsp;</p>

### LevelUpInAutoLayout-UdemyCourse

Curso de Udemy sobre Auto Layout.

Workspace compuesto por proyectos: 
- LevelUpInAutoLayout: Proyecto general.
- DesignChallenges (Basic anchors): Challenges para crear vistas.

## Intrinsic Content Size:

Its the natural size of an iOS control wants to be (default size of a control).

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

<p>&nbsp;</p>

### RxSwift

Curso de Udemy sobre RxSwfit.
