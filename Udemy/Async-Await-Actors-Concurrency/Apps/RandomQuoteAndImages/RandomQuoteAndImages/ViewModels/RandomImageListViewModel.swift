//
//  RandomImageListViewModel.swift
//  RandomQuoteAndImages
//
//  Created by Fabian Josue Rodriguez Alvarez on 4/4/23.
//

import Foundation
import UIKit

//MainActor: Todas las propiedade y funciones dentro de esta clase, van a ejecutarse en el Main Thread.
@MainActor
class RandomImageListViewModel: ObservableObject {
    
    @Published var randomImages: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async {
        
        do {
            let randomImages = try await WebService().getRandomImages(ids: ids)
            
            //No hace falta hacer un DispatchQueue.main, porque ya se está utilizando MainActor.
            //Se mapea la respuesta a la entidad del ViewModel, para no utilizar directamente la del Model.
            self.randomImages = randomImages.map(RandomImageViewModel.init)
            
        } catch {
            debugPrint("ERROR CATCH getRandomImages: \(error)")
        }
    }
}

struct RandomImageViewModel: Identifiable {
    
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
