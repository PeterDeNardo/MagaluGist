//
//  DashViewModel.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import Foundation
import UIKit

typealias loadImageCompletion = (UIImage) -> Void

protocol DashViewModelProtocol {
    func fetch(completion: (() -> Void)?) throws
    func loadImage(_ url: URL, completion: @escaping loadImageCompletion) throws
}

class DashViewModel: DashViewModelProtocol {
    
    private enum Values {
        static let sinceDate: String = "2021-01-01T00:00:00Z"
        static let quantityPerPage: Int = 15
    }
    
    var model = Bindable<[DashGistModel]?>([])
    var error = Bindable<Bool?>(false)
    private var manager: DashManagerProtocol
    private var page: Int
    private var isPaginating: Bool
    
    init(manager: DashManagerProtocol = DashManager()) {
        self.manager = manager
        self.page = 0
        self.isPaginating = false
    }
    
    func fetch(completion: (() -> Void)?) {
        self.error.value = false
        if !isPaginating {
            self.isPaginating = true
            manager.fetchGists(sinceDate: Values.sinceDate, quantityPerPage: Values.quantityPerPage, page: page)  { [weak self] result in
                guard let self = self else { return }
                self.isPaginating = false
                do {
                    let result = try result()
                    var models: [DashGistModel] = []
                    for model in result {
                        var obj = model
                        obj.favorited = false
                        models.append(obj)
                        
                    }
                    self.model.value?.append(contentsOf: models)
                    self.page += 1
                } catch {
                    self.error.value = true
                }
            } 
        }
    }
    
    func loadImage(_ url: URL, completion: @escaping loadImageCompletion) {
        manager.loadImage(url: url) { result in
            do {
                let result = try result()
                completion(result)
            } catch {
                completion(UIImage(systemName: SystemImages.interrogation.rawValue)!)
            }
        }
    }
}
