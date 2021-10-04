//
//  File.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation

/**
 
 Padronization for Manager Protocols
 
*/

protocol ManagerProtocol {
    // Inicializador
    ///
    /// - Parameters:
    ///  - url: path da imagem
    ///  - completion: callback
    func loadImage(url: URL,
                   completion: @escaping LoadImageCompletion)
}

