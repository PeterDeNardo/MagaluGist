//
//  MagaluGist.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

/**
 
 Keeps static system values ​​saved for use in the application
 
*/


public class MagaluGist {
    public static var bundle: Bundle {
        return Bundle(for: MagaluGist.self)
    }
    
    public static var trait: UITraitCollection = {
        return UITraitCollection()
    }()
    
    public static var darkMode: Bool = {
        switch trait.userInterfaceStyle {
        case .dark:
            return true
        case .light:
            return false
        case .unspecified:
            return false
        @unknown default:
            return false
        }
    }()
}
