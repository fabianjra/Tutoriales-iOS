import UIKit

//*************************************************
// EJEMPLO DE COMO CONCURRENCY PUEDE AFECTAR A UNA APLICACION:
//*************************************************

class BankAccount {
    
    var balance: Double
    
    //Permite bloquear una funcion para que no se ejecute. Sirve para Task concurrentes
    //Cuando se utilice Lock, se debe tomar en cuenta el Thread en donde se llama.
    //EJEM: Si se llama en el Main Thread, se debe desbloquear en el Main Thread igualmente. Lo mismo por ejemplo con Background Thread.
    let lock = NSLock()
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withDraw(_ amount: Double) {
        
        lock.lock() //Bloquea el scope para que no pueda ser accedido hasta que una tarea haya sido finalizada
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
        lock.unlock() //Desbloquea el scope
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

//Una tarea espera a que termine la anterior para continuar:
//let queue = DispatchQueue(label: "SerialQueue")

//las tareas se ejecutan al mismo tiempo:
let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

queue.async {
    bankAccount.withDraw(300)
}

queue.async {
    bankAccount.withDraw(500)
}

debugPrint("Proceso finalizado. Balance: \(bankAccount.balance)")
