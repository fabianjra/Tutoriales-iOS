//
//  ContentView.swift
//  LearnActors
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/4/23.
//

import SwiftUI

//MainActor fuerza la ejecucion en el Main Thread.
//En este caso se utiliza MainActor porque 2 variables son @Published, entonces no siempre se espeera que el 100% de las veces se ejecuten en el main thread por defecto y podrian setearse en threads diferentes.
@MainActor
class BankAccountViewModel: ObservableObject {
    
    private var bankAccount: BankAccount
    @Published var currentBalance: Double?
    @Published var transactions: [String] = []
    
    init(balance: Double) {
        bankAccount = BankAccount(balance: balance)
    }
    
    //ERROR: Actor-isolated instance method 'withDraw' can not be referenced from a non-isolated context
    //Para solucionar el problema con actor y el llamado desde afuera de esa clase por ser insolated, se puede modificar el metodo agregando async y await. y luego quitando el Dispatchqueue.
    func withDraw(_ amount: Double) async {
        await bankAccount.withDraw(amount)
        
        //DispatchQueue.main.async {
            self.currentBalance = await self.bankAccount.getBalance()
            self.transactions = await self.bankAccount.transactions
        //}
    }
}

//si se usa actor para la clase, no va a funcionar porque se esta accediendo desde afuera de la clase, para cmabiar sus valores. Es "insolated", de la siguiente manera: "actor BankAccount {"
actor BankAccount {
    
    private(set) var balance: Double
    private(set) var transactions: [String] = []
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func getBalance() -> Double {
        return self.balance
    }
    
    func withDraw(_ amount: Double) {

        if balance >= amount {
            
            let processingTime = UInt32.random(in: 0...3)
            
            print("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            transactions.append("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            
            sleep(processingTime)
            
            print("Withdrawing \(amount) from account")
            transactions.append("Withdrawing \(amount) from account")
            
            self.balance -= amount
            
            print("Balance is \(balance)")
            transactions.append("Balance is \(balance)")
            
        } else {
            transactions.append("No se pudo hacer el Withdrawing porque el balance es menor a lo que se requiere retirar."
            )
            debugPrint("No se pudo hacer el Withdrawing porque el balance es menor a lo que se requiere retirar.")
        }
    }
}

struct ContentView: View {
    
    @StateObject private var bankAccountVM = BankAccountViewModel(balance: 500)
    
    let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
    
    var body: some View {
        VStack{
            
            Button("Withdraw") {
                
                // Ya no se usa DispatchQueue para el llamado, ahora es async entonces se usa Task:
                //queue.async {
                
                //Estos llamados no garantizan que siempre se hagan en este orden, puede ir el segundo llamado "500" de primero en algunos casos.
                Task.detached {
                    await bankAccountVM.withDraw(200)
                }
                
                Task.detached {
                //queue.async {
                    await bankAccountVM.withDraw(500)
                }
            }
            
            Text("\(bankAccountVM.currentBalance ?? 0.0)")
            
            List(bankAccountVM.transactions, id: \.self) { trans in
                Text(trans)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
