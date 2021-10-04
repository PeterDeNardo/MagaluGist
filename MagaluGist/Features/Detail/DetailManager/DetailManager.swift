//
//  DeatilManager.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation

class DetailManager: ManagerProtocol {
    
    func loadImage(url: URL,
                   completion: @escaping LoadImageCompletion) {
        let operation = LoadImageOperation(url: url,
                                           completion: completion)
        operation.start()
    }
}

