//
//  FooView.swift
//  LearnActors
//
//  Created by Fabian Josue Rodriguez Alvarez on 11/4/23.
//

import SwiftUI

enum BankError: Error {
    case insufficientFunds(Double)
}

actor BankAccountFoo {
    
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    //nonisolated: Se utiliza cuando se llama una funcion que no va a cambiar el estado de una clase o alguna de sus propiedades. Ademas permite que se llame a esta funcion sin async, porque no va a cambiar nada.
    nonisolated func getCurrentAPR() -> Double {
        
        //al set noninsolated, no permite cambiar valores de la clase.
        //balance += 10 //ERROR
        
        return 0.2
    }
    
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    func transfer(amount: Double, to other: BankAccountFoo) async throws {
        
        if amount > balance {
            throw BankError.insufficientFunds(amount)
        }
        
        balance -= amount
        //other.balance += amount
        await other.deposit(amount)
        
        //AccountNumber no necesita await porque es una constante, asi que nunca va a cambiar su valor.
        print(other.accountNumber)
        
        //a diferencia de "accountNumber" que es let. La variable balance es var, entonces puede cambiar y sí necesita await para obtener su valor.
        print("Current Account: \(balance), Other Account: \(await other.balance)")
    }
}

struct FooView: View {
    
    var body: some View {
        Button {
            
            let bankAccount = BankAccountFoo(accountNumber: 123, balance: 500)
            let otherAccount = BankAccountFoo(accountNumber: 456, balance: 100)
            
            //Ya no se necesita Task con await para llamar a esta funcion, porque es noninsolated
            let _ = bankAccount.getCurrentAPR()
            
            DispatchQueue.concurrentPerform(iterations: 100) { _ in
                
                //se requiere Task cada vez que se usa un await:
                Task {
                    try? await bankAccount.transfer(amount: 300, to: otherAccount)
                }
            }
            
        } label: {
            Text("Transfer")
        }
        
    }
}

struct FooView_Previews: PreviewProvider {
    static var previews: some View {
        FooView()
    }
}
