//
//  FileRepresentation.swift
//  MagaluGistTests
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import MagaluGist

public struct FileRepresentation {
    enum FileRepresentationError: Error {
        case invalidData
    }
    
    public enum Extension: String {
        case json
    }
    
    private var fileName: String?
    private var fileExtension: Extension?
    private var fileBundle: Bundle?
    private var fileData: Data?
    var path: String {
        guard let url = fileBundle?.url(forResource: fileName ?? String(), withExtension: fileExtension?.rawValue ?? String()) else { return String() }
        return url.absoluteString
    }
    
    var data: Data? {
        if let data = fileData {
            return data
        }
        guard let url = fileBundle?.url(forResource: fileName ?? String(), withExtension: fileExtension?.rawValue ?? String()) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
    
    ///Initializer
    ///
    /// - Parameters:
    ///   - FileName: file name
    ///   - FileExtension: file extension
    ///   - fileBundle: file path / bundle
    public init(withFileName fileName: String, fileExtension: Extension, fileBundle: Bundle = MagaluGist.bundle) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.fileBundle = fileBundle
    }
    
    ///Initializer
    ///
    /// - Parameters:
    ///   - fileData: file data
    public init(withFileData fileData: Data) {
        self.fileData = fileData
    }
    
    ///Return file model
    ///
    /// - Parameters:
    ///   - type: type for decoder
    ///   - decoder: custom JSONDecoder
    /// - returns: file model
    /// - throws: exceptions in error cases
    func decoded<T: Decodable>(to type: T.Type, using decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let data = data else { throw FileRepresentationError.invalidData }
        return try decoder.decode(type, from: data)
    }
}
