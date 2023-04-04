import UIKit

enum NetworkError: Error {
    case badUrl
    case decodingError
    case invalidId
}

struct CreditScore: Decodable {
    let score: Int
}

struct Constants {
    struct Urls {
        
        static func equifax(userId: Int) -> URL? {
            return URL(string: "http://ember-sparkly-rule.glitch.me/equifax/credit-score/\(userId)")
        }
        
        static func experian(userId: Int) -> URL? {
            return URL(string: "http://ember-sparkly-rule.glitch.me/experian/credit-score/\(userId)")
        }
    }
}

func calculateAPR(creditScores: [CreditScore]) -> Double {
    let sum = creditScores.reduce(0) { next, credit in
        return next + credit.score
    }
    return Double((sum/creditScores.count)/100)
}

func getAPR(userId: Int) async throws -> Double {
    
    guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
          let experianUrl = Constants.Urls.experian(userId: userId) else {
        throw NetworkError.badUrl
    }
    
    //Cuando se use "async let", no es necesario agregar "try await" al URL Session.
    async let (equifaxData, _) = URLSession.shared.data(from: equifaxUrl)
    async let (experianData, _) = URLSession.shared.data(from: experianUrl)
    
    //Concurrent Tasks:
    //Se usa await en data, porque la variable es async.
    //A demas se usa try, porque "URLSession.shared.data" es throws
    //En este punto es en donde la aplicacion va a esperar el llamado, porque aqui es donde tiene el await.
    //La idea de hacerlo de esta forma, es que cualquiera de las 2 pueden terminar primero porque se hacen independientes.
    let equifaxCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await equifaxData)
    let experianCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await experianData)
    
    //Wunwrap las respuestas porque usan try opcional:
    guard let equifaxCreditScore = equifaxCreditScore,
          let experianCreditScore = experianCreditScore else {
        throw NetworkError.decodingError
    }
    
    return calculateAPR(creditScores: [equifaxCreditScore, experianCreditScore])
}

Task {
   let apr = try await getAPR(userId: 1)
    
    print(apr)
}

//*******************************************************************************//
//  LOOP PARA RECORRER UN LLAMADO A UN API
//*******************************************************************************//

print("LOOP CALL STARTS:")

func getAPR_ConError(userId: Int) async throws -> Double {
    
    if userId % 2 == 0 {
        
        throw NetworkError.invalidId
    }
    
    guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
          let experianUrl = Constants.Urls.experian(userId: userId) else {
        throw NetworkError.badUrl
    }
    
    async let (equifaxData, _) = URLSession.shared.data(from: equifaxUrl)
    async let (experianData, _) = URLSession.shared.data(from: experianUrl)

    let equifaxCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await equifaxData)
    let experianCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await experianData)
    
    guard let equifaxCreditScore = equifaxCreditScore,
          let experianCreditScore = experianCreditScore else {
        throw NetworkError.decodingError
    }
    
    return calculateAPR(creditScores: [equifaxCreditScore, experianCreditScore])
}

//Loop:
let ids = [1, 2, 3, 4, 5]
var invalidIds: [Int] = []

Task {
    for id in ids {
        
        do {
            //"CheckCancellation": Permite saber si hay un throw y se produce un error en la funcion.
            try Task.checkCancellation()
            
            let apr = try await getAPR_ConError(userId: id)
            
            print(apr)
        } catch {
            print(error)
            invalidIds.append(id) //almacena los Id con error para saber cuales estan fallando
        }
    }
    
    //Array con los que contiene error:
    print(invalidIds)
}


//*******************************************************************************//
//  TASK GROUPS:
//*******************************************************************************//

print("TASK GROUP:")

func getAPRForAllUsers(ids: [Int]) async throws -> [Int: Double] {
    
    var userAPR: [Int: Double] = [:]

    //of: que va a hacer return.
    //body: logica de la funcion: lo que va a ejecutar.
    try await withThrowingTaskGroup(of: (Int, Double).self, body: { group in
        
        for id in ids {
            
            //Va a acrear un "concurrent group" para ejecutar las funciones asincronas.
            group.addTask {
                
                let apr = try await getAPR(userId: id)
                
                //No se puede cambiar una variable dentro de un ambiente asincrono. (concurrent)
                //userAPR[id] = apr
                
                //se hace de la siguiente manera, ya que no podemos cambiar una variable:
                return(id, try await getAPR(userId: id))
            }
        }
        
        //Async sequence (iOS 15):
        //Va uno por uno, esperando la respuesta de "group".
        for try await (id, apr) in group {
            userAPR[id] = apr
            print("apr added to the array [int: double]")
        }
    })
    
    return userAPR
}

Task{
    let userAPRs = try await getAPRForAllUsers(ids: ids)
    print("usersAPRs: \(userAPRs)")
}

//*******************************************************************************//
//  DETACHED TASKS:
//*******************************************************************************//

func fetchThumbnails() async -> [UIImage] {
    return [UIImage()]
}

func updateUI() async {
    
    //get thumbnails
    let thumbnails = await fetchThumbnails()
    
    //"Detached task" no deberia ser usado en lo posible.
    //No hereda nada de su padre. Por ejemplo si se llama desde un Task con un priority = .background, en este caso no hereda su prioridad.
    Task.detached(priority: .background) {
        writeToCache(images: thumbnails)
    }
}

private func writeToCache(images: [UIImage]) {
    //Write to cache
}

Task {
    await updateUI()
}
