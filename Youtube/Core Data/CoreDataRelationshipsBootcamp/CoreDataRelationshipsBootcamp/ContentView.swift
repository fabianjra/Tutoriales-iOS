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
    @Published var deparments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDeparments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity") //Debe ser exactamente el mismo nombre de la entidad en el modelo.
        
        // Ordenar el query request:
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        //Filtro para la consulta:
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", "Apple") //Filtra por contenido de texto.
        //request.predicate = NSPredicate(format: "name == %@", "Microsoft") //Filtra por texto exacto.
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func getDeparments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity") //Debe ser exactamente el mismo nombre de la entidad en el modelo.
        
        do {
            deparments = try manager.context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity") //Debe ser exactamente el mismo nombre de la entidad en el modelo.
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity") //Debe ser exactamente el mismo nombre de la entidad en el modelo.
        
        //Filtra por Business:
        //Este filtro solamente aplica cuando la propiedad "Business" es "To One", y no a "To Many", porque debe buscar por nombre de Business exacto.
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        
        // Se debe agregar un context, asi que se pasa el de manager (la instancia Singleton)
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Microsoft"
        
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
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 99
        newEmployee.name = "Angelica PG"
        newEmployee.dateJoined = .now
        
        newEmployee.business = businesses[0]
        newEmployee.deparment = deparments[0]
        
        save()
    }
    
    // Para poder eliminar a todos los Deparments, debe tener el "Delete Rule" en el archivo de container a "Nullify".
    
    // Nullify: Permite que se elimine el departamento, pero no el Employee que esta dentro.
    // Cascade: Cuando se elimina el departamento, tambien se eliminaran todos los Employee que esten dentro del departamento.
    // Deny: No permite remover departamentos hasta que no hayan Employees asociados al departamento que se quiere eliminar.
    func deleteDeparment() {
        let deparment = deparments[0]
        manager.context.delete(deparment)
        save()
    }
    
    func save() {
        
        businesses.removeAll()
        deparments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.manager.save()
            self.getBusinesses()
            self.getDeparments()
            self.getEmployees()
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
                    
                    Button("Add employee") {
                        vm.addEmployee()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Delete first Deparment") {
                        vm.deleteDeparment()
                    }
                    .buttonStyle(.bordered)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.deparments) { deparment in
                                DeparmentView(entity: deparment)
                            }
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
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
                    .bold()
                
                ForEach(departments) { deparment in
                    Text(deparment.name ?? "NO DEPARMENT NAME")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "NO EMPLOYEE NAME")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


// DEPARMENT VIEW

struct DeparmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(entity.name ?? "NO DEPARMENT NAME")")
                .bold()
            
            // Deparments es un NSSet, por lo que debe castearse
            if let businesses = entity.businesses?.allObjects as? [DepartmentEntity] {
                
                Text("Businesses:")
                    .bold()
                
                ForEach(businesses) { business in
                    Text(business.name ?? "NO BUSINESS NAME")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "NO EMPLOYEE NAME")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


// EMPLOYEE VIEW

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(entity.name ?? "NO EMPLOYEE NAME")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")
            
            Text("Businesses:")
                .bold()
            
            Text("\(entity.business?.name ?? "NO BUSSINES NAME")")
            
            
            Text("Deparment:")
                .bold()
            
            Text("\(entity.deparment?.name ?? "NO DEPARMENT NAME")")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
