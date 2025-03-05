//
//  ContentView.swift
//  CoreDataRelationshipsBootcamp
//
//  Created by Fabian Rodriguez on 3/3/25.
//

import SwiftUI
import CoreData

// Se agregan 3 Entities para este ejemplo, ya que trata de Relaciones entre las entidades.
// 1: BusinessEntity
// 2: DepartmentEntity
// 3: EmployeeEntity

// Nota: No es necesario agregar la palabra entity al final de cada entidad,
// pero se puede agregar para saber que se esta trabajando con una entidad.


// UTILS:
class CoreDataManager {
    
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataContainer") // Debe ser exactamente igual al del archivo de modelo creado.
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved sucessfully")
        } catch {
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
}


// VIEW MODEL:
class CoreDataRelationShipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    
    init() {
        getBusinesses()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity") //Debe ser exactamente el mismo nombre de la entidad en el modelo.
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        
    }
    
    func addBusiness() {
        
        // Se debe agregar un context, asi que se pasa el de manager (la instancia Singleton)
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple Inc."
        
        // agregar los departamentos nuevos al Business
        //newBusiness.deparments = []
        
        // Agregar los empleados existentes al nuevo Business
        //newBusiness.employees = []
        
        // Agregar el nuevo Business a un departamento existente
        //newBusiness.addToDeparments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // Agregar el nuevo Business a un empleado existente
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDeparment() {
        
        let newDeparment = DepartmentEntity(context: manager.context)
        newDeparment.name = "Marketing"
        
        //El departamento esta relacionado a Business y Employee, ambos "to Many".
        
        // businesses es un NSset, debe ser casteado.
        newDeparment.businesses = [businesses[0]]
        
        save()
    }
    
    func save() {
        
        businesses.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.manager.save()
            self.getBusinesses()
        }
    }
}


// VIEW MAIN:
struct ContentView: View {
    
    @StateObject var vm = CoreDataRelationShipViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    Button("Add business") {
                        vm.addBusiness()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Add deparment") {
                        vm.addDeparment()
                    }
                    .buttonStyle(.bordered)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


// VIEW LISTA DE BUSINESS:

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Business name: \(entity.name ?? "NO BUSINESS NAME")")
                .bold()
            
            // Deparments es un NSSet, por lo que debe castearse
            if let departments = entity.deparments?.allObjects as? [DepartmentEntity] {
                
                Text("Deparments:")
                ForEach(departments) { deparment in
                    Text(deparment.name ?? "NO DEPARMENT NAME")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                
                Text("Employees:")
                ForEach(employees) { employee in
                    Text(employee.name ?? "NO EMPLOYEE NAME")
                }
            }
        }
        .padding()
    }
}
