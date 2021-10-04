//
//  UIView+Extensions.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 30/09/21.
//

import Foundation
import UIKit

extension UIView {
    func addAttrachedSubView(view: UIView) {
        self.addSubview(view)
        view.anchor(left: self.leftAnchor, right: self.rightAnchor)
        view.anchor(top: self.topAnchor, bottom: self.bottomAnchor)
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0.0, paddingBottom: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
    }
    
    func anchor(left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0.0, paddingRight: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
    }
    
    func anchor(horizontal: NSLayoutXAxisAnchor? = nil, vertical: NSLayoutYAxisAnchor? = nil, paddingHorizontal: CGFloat = 0.0, paddingVertical: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let horizontal = horizontal {
            centerXAnchor.constraint(equalTo: horizontal, constant: paddingHorizontal).isActive = true
        }
        if let vertical = vertical {
            centerYAnchor.constraint(equalTo: vertical, constant: paddingVertical).isActive = true
        }
    }
    
    func anchor(width: CGFloat = 0.0, height: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
