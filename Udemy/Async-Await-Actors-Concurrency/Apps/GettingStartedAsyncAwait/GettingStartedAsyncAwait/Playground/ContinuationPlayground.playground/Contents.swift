import UIKit

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

struct Post: Decodable {
    let title: String
}

func getPost(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NetworkError.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in // _ = reponse
        
        //Unwrap a data, solamente cuando error sea nil (o sea, que no exista un error.
        guard let data = data, error == nil else {
            completion(.failure(.noData)) //Caso contrario a que no exista data o haya error. se ejecuta failure.
            return
        }
        
        //Decode data:
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        
        completion(.success(posts ?? []))
        
    }.resume()
}

getPost { result in
    
    switch result {

    case .success(let posts):
        var num = 0
        for post in posts {
            num += 1
            print("\(num): \(post.title)")
        }
        
    case .failure(let error):
        print(error)
    }
}

//Continuation:
func getPosts() async throws -> [Post] {
    
    //"withCheckedThrowingContinuation": Este es un Callback que llama a otro Callback.
    return try await withCheckedThrowingContinuation { continuation in
        
        getPost { result in
            switch result {
            case .success(let posts):
                //print(posts)
                continuation.resume(returning: posts) //Continuation logic:
                
            case .failure(let error):
                //print(error)
                continuation.resume(throwing: error) //Continuation logic:
            }
        }
    }
}

Task {
    do {
        let posts = try await getPosts()
        
        var num = 0
        for post in posts {
            num += 1
            print("\(num): \(post.title)")
        }
    }catch {
        print(error)
    }
}
