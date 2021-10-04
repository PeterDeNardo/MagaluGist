//
//  FavoritesViewController.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    enum Values {
        static let title: String = "Favorites"
        static let alerTitle = "Problens Deleting Favorites"
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DashGistCell.self, forCellReuseIdentifier: "dashGistCell")
        return tableView
    }()
    
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        let label = UILabel()
        label.text = "Favorite More!❤️"
        label.textAlignment = .center
        view.addAttrachedSubView(view: label)
        return view
    }()
    
    var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    private var models: [DashGistModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindElements()
        self.title = Values.title
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFavorites()
    }
    
    private func bindElements() {
        viewModel.model.bind { [weak self] value in
            guard let model = value else { return }
            self?.models = model
            self?.tableView.reloadData()
        }
        viewModel.error.bind { [weak self] value in
            self?.errorHandler(state: value)
        }
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
    

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DashGistCell.self, forCellReuseIdentifier: DashGistCell.description())
    }

}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = models[indexPath.row]
        let cell = DashGistCell()
        cell.setup(model: cellModel,
                   indexPath: indexPath,
                   delegate: self)
    
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
        } else {
            self.tableView.tableFooterView = nil
        }
    }
}

extension FavoritesViewController: DashGistCellDelegate {
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
            viewModel.loadFavorites()
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        } catch let error {
            let alert = AlertHandler.shared.getGenericAlert(withTitle: Values.alerTitle, description: error.localizedDescription)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension FavoritesViewController: GenericErrorViewDelegate {
    func pressButton() {
        viewModel.loadFavorites()
    }
}
