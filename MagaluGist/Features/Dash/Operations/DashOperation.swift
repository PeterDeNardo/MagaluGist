//
//  DashOperation.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import Foundation

class DashOperation: AsyncOperation {
    
    private let provider: ApiProvider
    
    private enum Values {
        static let accept = "application/vnd.github.v3+json"
        static let url = UrlBody(scheme: Scheme.https,
                                 host: Host.api_guthub,
                                 path: Path.gist_public)
    }
    
    private let bussiness: DashBusinessProtocol
    private let sinceDate: String
    private let quantityPerPage: Int
    private let page: Int
    private let completion: DashCompletion
    
    required init(dashBussiness: DashBusinessProtocol = DashBusiness(),
                  provider: ApiProvider = ApiProvider(),
                  sinceDate: String,
                  quantityPerPage: Int,
                  page: Int,
                  completion: @escaping DashCompletion) {
        self.bussiness = dashBussiness
        self.provider = provider
        self.sinceDate = sinceDate
        self.quantityPerPage = quantityPerPage
        self.page = page
        self.completion = completion
    }
    
    override func main() {
        super.main()
        
        let params = createParams()
        
        provider.request(
            params: params,
            url: Values.url,
            success: { result in
                self.bussiness.handleResult(response: result, completion: self.completion)
                self.finish()
            },
            failure: { result in
                self.bussiness.handleResult(response: result, completion: self.completion)
                self.finish()
            }
        )
    }
    
    private func createParams() -> [String: Any] {
        let parameters: [String: Any] = [
            OperationsEnum.header.rawValue: [
                OperationsEnum.accept.rawValue: Values.accept
            ],
            OperationsEnum.query.rawValue: [
                OperationsEnum.since.rawValue: sinceDate,
                OperationsEnum.per_page.rawValue: quantityPerPage,
                OperationsEnum.page.rawValue: page
            ]
        ]
        return parameters
    }
}
