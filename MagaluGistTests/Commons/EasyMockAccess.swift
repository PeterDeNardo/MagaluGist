//
//  EasyMockAccess.swift
//  MagaluGistTests
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
@testable import MagaluGist

class EasyMockAccess {
    public static let shared = EasyMockAccess()
    
    private init() { }
    
    public func getOneDashGistModel() throws -> DashGistModel {
        let file = FileRepresentation(withFileName: "gistExample", fileExtension: .json,fileBundle: Bundle(for: DashBusinessTests.self))
        
        do {
            let model = try file.decoded(to: DashGistModel.self)
            return model
        } catch {
            throw error
        }
    }
}
