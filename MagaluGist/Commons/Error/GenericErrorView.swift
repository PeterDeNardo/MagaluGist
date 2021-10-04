//
//  GenericErrorView.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

protocol GenericErrorViewDelegate {
    func pressButton()
}

class GenericErrorView: UIView {
    
    enum Values {
        static let fontSize: CGFloat = 24
        static let title: String = "Something is Wrong"
        static let buttonTitle: String = "try again"
    }
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Values.fontSize)
        return label
    }()
    
    private var tryAgainButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textColor = .darkGray
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return btn
    }()
    
    private var delegate: GenericErrorViewDelegate?
    
    func setup(errorTitle: String = Values.title, errorButtonText: String = Values.buttonTitle, delegate: GenericErrorViewDelegate?) {
        errorLabel.text = errorTitle
        tryAgainButton.setTitle(errorButtonText, for: .normal)
        self.delegate = delegate
        setupLayout()
    }
    
    @objc
    private func pressButton() {
        delegate?.pressButton()
    }
    
    private func setupLayout() {
        self.addSubview(errorLabel)
        errorLabel.anchor(horizontal: self.centerXAnchor, vertical: self.centerYAnchor)
        
        self.addSubview(tryAgainButton)
        tryAgainButton.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 25, paddingRight: 25)
        tryAgainButton.anchor(bottom: self.bottomAnchor, paddingBottom: 40)
        tryAgainButton.anchor(height: 150)
        self.layoutIfNeeded()
    }
}
