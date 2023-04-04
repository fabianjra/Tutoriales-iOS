import UIKit

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
