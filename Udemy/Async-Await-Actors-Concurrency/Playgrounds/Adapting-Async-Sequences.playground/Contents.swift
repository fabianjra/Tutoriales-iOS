import UIKit

class BitcoinPriceMonitor {
    
    var price: Double = 0.0
    var timer: Timer?
    
    //Close que va a recibir un double, retorna Void. Y se inicializa con un body vacio.
    var priceHandler: (Double) -> Void = { _ in }
    
    //Funcion en Objective-C porque se usa en el #Selector:
    @objc func getPrice() {
        priceHandler(Double.random(in: 20000...40000))
    }
    
    func startUpdating() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getPrice), userInfo: nil, repeats: true)
    }
    
    func stopUpdating() {
        timer?.invalidate()
    }
}

//*************************************************
// SIN UTILIZAR ASYNC SEQUENCE:
//*************************************************
/*
let bitcoinPriceMonitor = BitcoinPriceMonitor()
bitcoinPriceMonitor.priceHandler = {
        debugPrint("Precio del bitcoin: \($0)")
}
bitcoinPriceMonitor.startUpdating()
*/


//*************************************************************************
// UTILIZANDO ASYNC SEQUENCE, UTILIZANDO CONTINUATION PARA MIGRAR UN API VIEJO:
//*************************************************************************

let bitcoinPriceStream = AsyncStream(Double.self) { continuation in
    
    let bitcoinPriceMonitor = BitcoinPriceMonitor()
    bitcoinPriceMonitor.priceHandler = {
        
        //Se accede al valor con yield
        continuation.yield($0)
    }
    
    //continuation.onTermination = { _ in }
    
    bitcoinPriceMonitor.startUpdating()
}

Task {
    for await bitcoinPrice in bitcoinPriceStream {
        debugPrint("Precio del bitcoin: \(bitcoinPrice)")
    }
}
