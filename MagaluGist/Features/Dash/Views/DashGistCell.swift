//
//  TableViewCeTableViewCell.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import UIKit

protocol DashGistCellDelegate {
    func onFavButtonClick(model: DashGistModel, state: Bool, indexPath: IndexPath, closure: @escaping () -> Void)
}

class DashGistCell: UITableViewCell {
    
    enum Values {
        static let primaryFontSize: CGFloat = 18
        static let secondaryFontSize: CGFloat = 16
        
        static let primaryDarkModeFontColor: UIColor = .white
        static let secondaryDarkModeFontColor: UIColor = .lightGray
        
        static let primaryLightModeFontColor: UIColor = .black
        static let secondaryLightModeFontColor: UIColor = .darkGray
    }
    
    private let userNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = MagaluGist.darkMode ? Values.primaryDarkModeFontColor : Values.primaryLightModeFontColor
        return lbl
    }()
    
    private let userProjectNameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.primaryFontSize, weight: .regular)
        lbl.textColor = MagaluGist.darkMode ? Values.primaryDarkModeFontColor : Values.primaryLightModeFontColor
        return lbl
    }()
    
    private let userProjectTypeLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: Values.secondaryFontSize, weight: .regular)
        lbl.textColor = MagaluGist.darkMode ? Values.secondaryDarkModeFontColor : Values.secondaryLightModeFontColor
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let userImageView: UIImageView = {
        var img = UIImageView()
        return img
    }()
    
    private let favButton: FavButton = {
        var btn = FavButton()
        btn.setup(filled: true, strokeWidth: 2, strokeColor: .red)
        btn.addTarget(self, action: #selector(onFavButtonClick), for: .touchUpInside)
        btn.tintColor = .red
        return btn
    }()
    
    private var id: String?
    private var delegate: DashGistCellDelegate?
    private var model: DashGistModel?
    private var indexPath: IndexPath?
    
    public func setup(model: DashGistModel, indexPath: IndexPath, delegate: DashGistCellDelegate) {
        self.model = model
        userNameLabel.text = model.owner.login
        userProjectNameLabel.text = model.files.randomId?.filename
        userProjectTypeLabel.text = model.files.randomId?.type
        id = model.id
        handleButtonClick(state: model.favorited ?? false)
        self.indexPath = indexPath
        self.delegate = delegate
        setupLayout()
    }
    
    public func setImage(image: UIImage) {
        userImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    private func onFavButtonClick() {
        guard var model = model, let index = indexPath else { return }
        model.favorited = !(model.favorited ?? false)
        self.delegate?.onFavButtonClick(model: model, state: model.favorited ?? false, indexPath: index) {
            self.handleButtonClick(state: model.favorited ?? false)
            self.model = model
        }
    }
    
    private func handleButtonClick(state: Bool) {
        favButton.setFilledState(state: state)
        favButton.setNeedsDisplay()
    }
    
    private func setupLayout() {
        let margins = self.layoutMarginsGuide
        self.contentView.addSubview(userImageView)
        userImageView.anchor(top: self.contentView.topAnchor, paddingTop: 5)
        userImageView.anchor(left: margins.leftAnchor)
        userImageView.anchor(width: 60, height: 60)
        userImageView.layer.cornerRadius = 60/2
        userImageView.clipsToBounds = true
        
        self.contentView.addSubview(userNameLabel)
        userNameLabel.anchor(left: userImageView.rightAnchor, paddingLeft: 10)
        userNameLabel.anchor(top: self.contentView.topAnchor, paddingTop: 5)
        userNameLabel.anchor(height: 24)
        
        self.contentView.addSubview(userProjectNameLabel)
        userProjectNameLabel.anchor(left: userImageView.rightAnchor, right: self.contentView.rightAnchor, paddingLeft: 10, paddingRight: 50)
        userProjectNameLabel.anchor(top: userNameLabel.bottomAnchor, paddingTop: 5)
        userProjectNameLabel.anchor(height: 24)
        
        self.contentView.addSubview(userProjectTypeLabel)
        userProjectTypeLabel.anchor(left: margins.leftAnchor)
        userProjectTypeLabel.anchor(top: userImageView.bottomAnchor, paddingTop: 10)
        userProjectTypeLabel.anchor(height: 22)
        
        self.contentView.addSubview(favButton)
        favButton.anchor(width: 25, height: 25)
        _ = UIBezierPath(heartIn: favButton.bounds)
        favButton.anchor(right: margins.rightAnchor)
        favButton.anchor(vertical: self.contentView.centerYAnchor)
        handleButtonClick(state: model?.favorited ?? false)
    }
}
