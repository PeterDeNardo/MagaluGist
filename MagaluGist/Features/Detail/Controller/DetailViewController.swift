//
//  DetailViewController.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 04/10/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    enum Values {
        static let title: String = "Details"
    }
    
    private let detailView: DetailView = {
        let view = DetailView()
        return view
    }()
    
    private var viewModel: DetailViewModel?
    
    init(viewModel: DetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        setupLayout()
        self.title = Values.title
    }
    
    private func bindElements() {
        self.viewModel?.model.bind({ [weak self] value in
            guard let self = self else { return }
            self.setupView()
        })
    }
    
    private func setupView() {
        detailView.setup(userName:  self.viewModel?.model.value?.owner.login ?? "",
                         userProjectName: self.viewModel?.model.value?.files.randomId?.filename ?? "")
        if let urlString = self.viewModel?.model.value?.owner.avatarUrl,  let url = URL(string: urlString) {
            self.viewModel?.loadImage(url, completion: { [weak self]value in
                self?.detailView.setImage(image: value)
            })
        }
    }
    
    private func setupLayout() {
        self.view = detailView
    }
}
