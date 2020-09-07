//
//  ItemsViewController.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class ItemsViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    private let itemsModel = ItemsModel()
    
    // MARK: Properties
    
    private var dataSource: [ItemsViewControllerCellType] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        itemsModel.delegate = self
        itemsModel.getQiitaData()
    }
}

extension ItemsViewController: ItemsModelDelegate {
    func getQiitaData(with: [QiitaItems]) {
        //modelから[QiitaItems]型のデータを受け取った
        print(with)
    }
}

// MARK: - Configurations

extension ItemsViewController {
    
    private func configureNavigation() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "img_mvc"))
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = ItemsViewControllerCell.estimatedRowHeight
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
        tableView.register(ItemsViewControllerIndicatorCell.nib, forCellReuseIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier)
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
            
            // TODO: Model オブジェクト作成後に修正する.
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: "https://qiita.com/hayabusabusa/items/54838ab2d7862b5a04dd") else { return }
        let vc = SafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}
