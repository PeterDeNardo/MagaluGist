//
//  AnyEncodable.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import Foundation

/**
 
  definition for use
 
*/

struct AnyEncodable: Encodable {

    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
