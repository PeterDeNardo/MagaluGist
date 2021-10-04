//
//  FavButton.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import Foundation
import UIKit

class FavButton: UIButton {
    
    private var filled: Bool = true
    private var strokeWidth: CGFloat = 2.0
    private var strokeColor: UIColor?
    
    func setup(filled: Bool, strokeWidth: CGFloat, strokeColor: UIColor) {
        self.filled = filled
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
    }
    
    func setFilledState(state: Bool) {
        filled = state
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath(heartIn: self.bounds)

        if self.strokeColor != nil {
            self.strokeColor!.setStroke()
        } else {
            self.tintColor.setStroke()
        }

        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()

        if self.filled {
            self.tintColor.setFill()
            bezierPath.fill()
        }
    }
}
