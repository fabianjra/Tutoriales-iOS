
// Persintence Controller:
// Este es el que enlaza el Modelo de Core Data con el codigo.
// Aqui se inicializa todo lo que tiene que ver con Core Data.
// Desde el Persintence Controller se accede a Core Data.

import CoreData

class PersistenceController {
    
    // Solo debe existir una sola instancia del contenedor.
    static let shared = PersistenceController()
    
    //Contenedor de Core Data.
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MemoraModel") //Debe ser el mismo nombre del archivo del modelo.
        
        // Inicializa el contenedor y carga el contenido de Core Data
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error {
                fatalError("Unable to load persistent stores: \(error.localizedDescription)")
            }
        }
        
        // Cuando se crea un Core Data Model y se crea un Persistence Container enlazado al modelo,
        // Se va a crear una propiedad llamada viewContext.
        // Este viewContext es la propiedad con la que se va a interactuar en toda la aplicacion para usar para manejar datos.
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // NOTA:
        // automaticallyMergesChangesFromParent:
        // Cada vez que el viewContext cambia desde el "parent context", cada "Child Context" va a cambiar tambien.
        // Esto indica que no importa sobre que "context" se realicen cambios, siempre se realizaran por el merge.
        
        // NOTA 2:
        // El ViewContext es lo unico a lo que se necesita acceder dentro de las pantallas de la aplicacion,
        // para hacer uso de los datos con Core Data.
    }
}
