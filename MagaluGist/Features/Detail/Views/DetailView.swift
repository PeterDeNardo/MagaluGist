//
//  DetailView.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

class DetailView: UIView {
    enum Values {
        static let primaryFontSize: CGFloat = 18
        static let secondaryFontSize: CGFloat = 16
        
        static let whiteFontColor: UIColor = .white
        static let blackFontColor: UIColor = .black
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var userNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = Values.whiteFontColor
        return lbl
    }()
    
    private var userProjectNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = Values.blackFontColor
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
        let margins = self.layoutMarginsGuide
        self.backgroundColor = .white
        self.addSubview(imageView)
        imageView.anchor(left: self.leftAnchor, right: self.rightAnchor)
        imageView.anchor(top: margins.topAnchor)
        imageView.anchor(height: UIScreen.main.bounds.width)
        let grandient = CAGradientLayer()
        grandient.colors = [UIColor.black, UIColor.clear]
        grandient.locations = [1.0, 0.0]
        grandient.frame = imageView.bounds
        imageView.layer.insertSublayer(grandient, at: 0)
        
        imageView.addSubview(userNameLabel)
        userNameLabel.anchor(left: imageView.leftAnchor, right: imageView.rightAnchor, paddingLeft: 24, paddingRight: 24)
        userNameLabel.anchor(bottom: imageView.bottomAnchor, paddingBottom: 10)
        
        self.addSubview(userProjectNameLabel)
        userProjectNameLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 24, paddingRight: 24)
        userProjectNameLabel.anchor(top: imageView.bottomAnchor, paddingTop: 24)
        userProjectNameLabel.anchor(height: 60)
    }
}
