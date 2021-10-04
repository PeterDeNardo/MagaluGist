//
//  DetailViewModel.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    func loadImage(_ url: URL, completion: @escaping loadImageCompletion)
}

class DetailViewModel: DetailViewModelProtocol {
    
    var model = Bindable<DashGistModel?>(nil)
    
    private let manager: ManagerProtocol?
    
    init(manager: ManagerProtocol = DetailManager(), model: DashGistModel) {
        self.manager = manager
        self.model.value = model
    }
    
    func loadImage(_ url: URL, completion: @escaping loadImageCompletion) {
        manager?.loadImage(url: url, completion: { result in
            do {
                let result = try result()
                completion(result)
            } catch {
                completion(UIImage(systemName: SystemImages.interrogation.rawValue)!)
            }
        })
    }
}
