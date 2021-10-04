//
//  DashBussiness.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 30/09/21.
//

import Foundation
import UIKit

typealias DashCompletion = (@escaping () throws -> [DashGistModel]) -> Void
typealias DashApiResponse = () throws -> CompletionData

protocol DashBusinessProtocol {
    
    func handleResult(response: DashApiResponse, completion: @escaping DashCompletion)
}

class DashBusiness: DashBusinessProtocol {
    func handleResult(response: () throws -> CompletionData, completion: @escaping DashCompletion) {
        do {
            let result = try response()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([DashGistModel].self, from: result.data)
            return completion { response }
        } catch {
            completion {
                throw AppliationError.parser
            }
        }
    }
}

enum AppliationError: Error {
    case none
    case server
    case connection
    case parser
    case unknown
}
