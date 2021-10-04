//
//  DashManager.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import Foundation

typealias dashCompletion = (@escaping () throws -> DashGistModel) -> Void

protocol DashManagerProtocol: ManagerProtocol {
    /// Inicializador
    ///
    /// - Parameters:
    ///  - sinceDate: Data de inicio da pesquisa
    ///  - quantityPerPage: Quantidade por pesquisa
    ///  - page: pagina
    ///  - completion: callback
    func fetchGists(sinceDate: String,
                    quantityPerPage: Int,
                    page: Int,
                    completion: @escaping DashCompletion)

}

class DashManager {
    
    private let provider: ApiProvider
    private let business: DashBusinessProtocol
    
    /// Inicializador
    ///
    /// - Parameters:
    ///  - provider: camada de request
    ///  - business: Business Protocol
    required init(provider: ApiProvider = ApiProvider(),
                  business: DashBusinessProtocol = DashBusiness()) {
        self.provider = provider
        self.business = business
    }
}

extension DashManager: DashManagerProtocol {
    func fetchGists(sinceDate: String,
                    quantityPerPage: Int,
                    page: Int,
                    completion: @escaping DashCompletion) {
        let operation = DashOperation(provider: provider,
                                      sinceDate: sinceDate,
                                      quantityPerPage: quantityPerPage,
                                      page: page,
                                      completion: completion)
        operation.start()
    }
    
    func loadImage(url: URL,
                   completion: @escaping LoadImageCompletion) {
        let operation = LoadImageOperation(url: url,
                                           completion: completion)
        operation.start()
    }
}
