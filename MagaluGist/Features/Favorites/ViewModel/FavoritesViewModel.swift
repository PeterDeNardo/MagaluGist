//
//  FavoritesViewModel.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import Foundation
import UIKit

class FavoritesViewModel {
    
    enum Values {
        static let favoritesUserDefaultsKey: String = "favorites"
    }
    
    var model = Bindable<[DashGistModel]?>([])
    var error = Bindable<Bool>(false)
    private var manager: ManagerProtocol
    
    /// init
    ///
    /// - Parameters:
    ///  - manager: ManagerProtocol, default value = FavoritesManager()
    init(manager: ManagerProtocol = FavoritesManager()) {
        self.manager = manager

    }
    
    /// load Favorites from userDefaults
    ///
    func loadFavorites() {
        do {
            let array = try AccessUserDefaultManager.shared.getDashGistModelArrayWithKey(Values.favoritesUserDefaultsKey)
            self.model.value = array
        } catch {
            self.error.value = true
        }
    }
    
    /// loadImage
    ///
    /// - Parameters:
    ///  - url: data url
    ///  - completion: callback
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
