//
//  DetailView.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

/**
 
 sums all layout settings to be passed to viewController
 
 */

class DetailView: UIView {
    enum Values {
        static let primaryFontSize: CGFloat = 28
        static let secondaryFontSize: CGFloat = 24
        
        static let primaryDarkModeFontColor: UIColor = .white
        static let secondaryDarkModeFontColor: UIColor = .lightGray
        
        static let primaryLightModeFontColor: UIColor = .black
        static let secondaryLightModeFontColor: UIColor = .darkGray
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var userNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = MagaluGist.darkMode ? Values.primaryDarkModeFontColor : Values.primaryLightModeFontColor
        return lbl
    }()
    
    private var userProjectNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = MagaluGist.darkMode ? Values.primaryDarkModeFontColor : Values.primaryLightModeFontColor
        lbl.numberOfLines = 2
        return lbl
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(userName: String, userProjectName: String) {
        userNameLabel.text = userName
        userProjectNameLabel.text = userProjectName
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    private func setupLayout() {
        self.backgroundColor = MagaluGist.darkMode ? Values.primaryLightModeFontColor : Values.primaryDarkModeFontColor
        let margins = self.layoutMarginsGuide
        self.addSubview(imageView)
        imageView.anchor(left: self.leftAnchor, right: self.rightAnchor)
        imageView.anchor(top: margins.topAnchor)
        imageView.anchor(height: UIScreen.main.bounds.width)
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        
        self.addSubview(userNameLabel)
        userNameLabel.anchor(left: margins.leftAnchor, right: margins.rightAnchor, paddingLeft: 5, paddingRight: 5)
        userNameLabel.anchor(top: self.imageView.bottomAnchor, paddingTop: 10)
        
        self.addSubview(userProjectNameLabel)
        userProjectNameLabel.anchor(left: margins.leftAnchor, right: margins.rightAnchor, paddingLeft: 5, paddingRight: 5)
        userProjectNameLabel.anchor(top: userNameLabel.bottomAnchor, paddingTop: 24)
        userProjectNameLabel.sizeToFit()
    }
}
