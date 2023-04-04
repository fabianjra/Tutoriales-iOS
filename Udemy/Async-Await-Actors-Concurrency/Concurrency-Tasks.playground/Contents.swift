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

func getAPR(userId: Int) async throws -> Double {
    
    guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
          let experianUrl = Constants.Urls.experian(userId: userId) else {
        throw NetworkError.badUrl
    }
    
    do{
        let (equifaxData, _) = try await URLSession.shared.data(from: equifaxUrl)
        let (experianData, _) = try await URLSession.shared.data(from: experianUrl)
        
    }catch {
        
    }
    
    
    return 0.0
}
