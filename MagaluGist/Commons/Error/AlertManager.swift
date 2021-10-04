//
//  AlertHandler.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

class AlertHandler {
    public static var shared: AlertHandler = {
        let manager = AlertHandler()
        return manager
    }()
    
    private init() {}

    ///Get a UIAlertController for any case
    ///
    /// - Parameters:
    ///   - withTitle: alert tile
    ///   - description: alert description
    ///   - style: UIAlertController.Style @default value = .alert
    public func getGenericAlert(withTitle title: String, description: String, style: UIAlertController.Style = .alert) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: description, preferredStyle: style)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
    
    
}
