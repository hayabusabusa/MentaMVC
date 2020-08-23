//
//  ItemsViewController.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class ItemsViewController: UIViewController, StateViewable {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    
    let stateView: StateView = StateView(frame: .zero, errorTitle: "エラーが発生しました.")
    
    private let model: ItemsModel = ItemsModel()
    private var dataSource: [ItemsViewControllerCellType] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        configureStateView()
        configureModel()
    }
}

// MARK: - Configurations

extension ItemsViewController {
    
    private func configureNavigation() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "img_mvc"))
    }
    
    private func configureTableView() {
        // NOTE: ロードが完了するまで TableView を隠す.
        tableView.alpha = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = ItemsViewControllerCell.estimatedRowHeight
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
        tableView.register(ItemsViewControllerIndicatorCell.nib, forCellReuseIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier)
    }
    
    private func configureStateView() {
        setupStateView()
        stateView.setState(of: .loading)
    }
    
    private func configureModel() {
        model.delegate = self
        model.onViewDidLoad()
    }
}

// MARK: - Animation

extension ItemsViewController {
    
    private func animateTableView(isHidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = isHidden ? 0 : 1
        }
    }
}

// MARK: - Model Delegate

extension ItemsViewController: ItemsModelDelegate {
    
    func onSuccess(with items: [QiitaItem], isReachLastPage: Bool) {
        dataSource = items.map { .item(with: $0) } + (isReachLastPage ? [] : [.indicator])
        stateView.setState(of: .none)
        animateTableView(isHidden: false)
        tableView.reloadData()
    }
    
    func onError(with error: Error) {
        let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        stateView.setState(of: .error)
    }
}

// MARK: - TableView DataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
        
        switch cellType {
        case .item(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerCell
            cell.configureCell(
                profileImageURL: item.user.profileImageURL,
                title: item.title,
                body: item.body,
                tags: item.tags.reduce("") { $0 + "#\($1.name) " },
                likesCount: item.likesCount,
                commentsCount: item.commentsCount)
            return cell
        case .indicator:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerIndicatorCell
            cell.configureCell()
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension ItemsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height - 24 && tableView.isDragging {
            model.onReachBottom()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellType = dataSource[indexPath.row]
        
        switch cellType {
        case .item(let item):
            guard let url = URL(string: item.url ?? "") else { return }
            let vc = SafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
}
