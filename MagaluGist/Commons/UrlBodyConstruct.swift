//
//  UrlModel.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 01/10/21.
//

import Foundation
import UIKit

/**
 
 This class is response to save commons path parameters
 
 */

public enum Scheme: String {
    case https = "https"
}

public enum Host: String {
    case api_guthub = "api.github.com"
}

public enum Path: String {
    case gist_public = "/gists/public"
}
