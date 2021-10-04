//
//  ApiProviderMock.swift
//  MagaluGistTests
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
@testable import MagaluGist

class ApiProviderMock: ApiProviderProtocol {
    
    func loadData(url: URL, success: @escaping CompletionCallBack, failure: @escaping CompletionCallBack) {
        
    }
    
    func request(params: [String : Any], url: UrlBody, success: @escaping CompletionCallBack, failure: @escaping CompletionCallBack) {
        
    }
    
}
