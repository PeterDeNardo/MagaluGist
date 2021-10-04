//
//  File.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

/**
 
 This class is response to save commons request parameters
 
 */

import Foundation

public enum OperationsEnum: String {
///More commons
    case header = "header"
    case query = "query"

///less commons
    case accept = "accept"
    case since = "since"
    case per_page = "per_page"
    case page = "page"
}
