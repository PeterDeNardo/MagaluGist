//
//  FavoritesManager.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import Foundation

class FavoritesManager: ManagerProtocol {
    
    /// loadImage sets operation
    ///
    /// - Parameters:
    ///  - url: data url
    ///  - completion: callback
    func loadImage(url: URL,
                   completion: @escaping LoadImageCompletion) {
        let operation = LoadImageOperation(url: url,
                                           completion: completion)
        operation.start()
    }
}
