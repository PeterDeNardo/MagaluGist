//
//  LoadImageOperation.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 01/10/21.
//

import Foundation
import PersonalApiProvider

class LoadImageOperation: AsyncOperation {
    
    private let provider: ApiProvider
    
    private let bussiness: LoadImageBusinessProtocol
    private let url: URL
    private let completion: LoadImageCompletion
    
    required init(dashBussiness: LoadImageBusinessProtocol = LoadImageBusiness(),
                  provider: ApiProvider = ApiProvider(),
                  url: URL,
                  completion: @escaping LoadImageCompletion) {
        self.bussiness = dashBussiness
        self.provider = provider
        self.url = url
        self.completion = completion
    }
    
    override func main() {
        super.main()
        
        provider.loadData(
            url: url,
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
}
