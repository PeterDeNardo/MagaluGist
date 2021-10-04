//
//  ViewController.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import UIKit

class DashViewController: UIViewController {
    
    enum Values {
        static let title: String = "Gists Dash"
        static let alerTitle = "Problens Saving Favorites"
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DashGistCell.self, forCellReuseIdentifier: DashGistCell.description())
        return tableView
    }()
    
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }()
    
    var viewModel: DashViewModel = DashViewModel()
    
    private var models: [DashGistModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindElements()
        viewModel.fetch(completion: nil)
        
        self.title = Values.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    init(viewModel: DashViewModel = DashViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func bindElements() {
        viewModel.model.bind { [weak self] value in
            guard let model = value else { return }
            self?.models = model
            self?.tableView.reloadData()
        }
        
        viewModel.error.bind { [weak self] value in
            guard let self = self else { return }
            self.errorHandler(state: value ?? false)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DashGistCell.self, forCellReuseIdentifier: DashGistCell.description())
    }
    
    private func errorHandler(state: Bool) {
        let errorView = GenericErrorView()
        if state {
            errorView.setup(delegate: self)
            self.view.addAttrachedSubView(view: errorView)
            self.tableView.tableFooterView = nil
        } else {
            for view in self.view.subviews where ((view as? GenericErrorView) != nil) {
                view.removeFromSuperview()
            }
            self.tableView.tableFooterView = footerView
        }
    }
}

extension DashViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

extension DashViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellModel = models[indexPath.row]
        let cell = DashGistCell()
        cellModel.favorited = false
        cell.setup(model: cellModel,
                   indexPath: indexPath,
                   delegate: self)
        cell.selectionStyle = .default
        if let imagePath = cellModel.owner.avatarUrl, let url = URL(string: imagePath) {
            viewModel.loadImage(url) { result in
                cell.setImage(image: result)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let viewModel = DetailViewModel(model: model)
        let viewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            self.tableView.tableFooterView = footerView
            viewModel.fetch() {
                self.tableView.tableFooterView = nil
            }
        }
    }
}

extension DashViewController: DashGistCellDelegate {
    func onFavButtonClick(model: DashGistModel, state: Bool, indexPath: IndexPath, closure: @escaping () -> Void) {
        do {
            var array = try AccessUserDefaultManager.shared.getDashGistModelArrayWithKey(UserDefaultsKeys.favoritesUserDefaultsKey.rawValue)
            if state {
                array.append(model)
            } else {
                array = array.filter { !($0.id == model.id) }
            }
            try AccessUserDefaultManager.shared.saveDashGistModelArray(array, forKey: UserDefaultsKeys.favoritesUserDefaultsKey.rawValue)
            closure()
        } catch let error {
            let alert = AlertHandler.shared.getGenericAlert(withTitle: Values.alerTitle, description: error.localizedDescription)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DashViewController: GenericErrorViewDelegate {
    func pressButton() {
        viewModel.fetch(completion: nil)
    }
}
