//
//  LoadImageBusiness.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 01/10/21.
//

import Foundation
import UIKit

typealias LoadImageCompletion = (@escaping () throws -> UIImage) -> Void
typealias LoadImageApiResponse = () throws -> CompletionData

protocol LoadImageBusinessProtocol {
    func handleResult(response: LoadImageApiResponse, completion: @escaping LoadImageCompletion)
}

class LoadImageBusiness: LoadImageBusinessProtocol {
    func handleResult(response: () throws -> CompletionData, completion: @escaping LoadImageCompletion) {
        do {
            let result = try response()
            if let response = UIImage(data: result.data) {
                return completion { response }
            }
            completion { throw AppliationError.parser }
        } catch {
            completion {
                throw AppliationError.parser
            }
        }
    }
}
