import UIKit

//*************************************************
// EJEMPLO DE COMO CONCURRENCY PUEDE AFECTAR A UNA APLICACION:
//*************************************************

class BankAccount {
    
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withDraw(_ amount: Double) {
        if balance >= amount {
            
            let proccesingTime = UInt32.random(in: 0...3)
            debugPrint("[Withdraw] Processing for: $\(amount) in: \(proccesingTime) seconds")
            sleep(proccesingTime)
            
            debugPrint("Withdrawing $\(amount) from account")
            
            balance -= amount
            
            debugPrint("Balance is now: \(balance)")
        } else {
            debugPrint("No se pudo hacer el Withdrawing porque el balance es menor a lo que se requiere retirar.")
        }
    }
}


let bankAccount = BankAccount(balance: 500)

/*
bankAccount.withDraw(300)
*/


//Que pasa si 2 personas intentan sacar dinero al mismo tiempo?:
//Ambos procesos se realizan porque comenzaron al mismo tiempo, por lo tanto no se cumple la validacion de que el balance sea mayor al monto a sacar.

/*
//La principal razon por la que la validacion no se hace correctamente, es porque el Dispatch es Concurrente. Una solucion, es pasarlo a Serial:
let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
 */

let queue = DispatchQueue(label: "SerialQueue")

queue.async {
    bankAccount.withDraw(300)
}

queue.async {
    bankAccount.withDraw(500)
}

debugPrint("Proceso finalizado. Balance: \(bankAccount.balance)")
