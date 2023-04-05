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
    
    /*
    //Forma basica:
     //Esta forma permite descargar las imagenes, pero las muestra en pantalla solamente cuando ya se descargaron todas y se completaron los llamados.
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
    */
    
    //Este metodo sirve para ir mostrando las imagenes a conforme se van descargando, gracias a TaskGroup, porque se hace de manera concurrente.
    func getRandomImages(ids: [Int]) async {
        
        let webservice = WebService()
        
        do {
            try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
                
                for id in ids {
                    group.addTask {
                        
                        //No se puede llamar "@Published randomImages" dentro de esta logica porque es un group Task. Se debe hacer return.
                        return (id, try await webservice.getRandomImage(id: id))
                    }
                }
                
                //se ignora el ID, pero se obtiene randomImage de group.
                //Aqui si se puede obtener el valor de @Published, porque está fuera de group.addTask
                for try await (_, randomImage) in group {
                    randomImages.append(RandomImageViewModel(randomImage: randomImage))
                }
            })
            
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
