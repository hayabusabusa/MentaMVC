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
    
    // MARK: Properties
    
    private var dataSource: [ItemsViewControllerCellType] = [
        .item,
        .item,
        .item,
        .item,
        .item,
        .item,
        .indicator
    ]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
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
        case .item:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerCell
            
            // TODO: Model オブジェクト作成後に修正する.
            cell.configureCell(
                profileImageURL: "https://qiita-user-profile-images.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F202306%2Fprofile-images%2F1566547186?ixlib=rb-1.2.2&auto=compress%2Cformat&lossless=0&w=48&s=6949bc566d9b66c71fcddd7af98dda73",
                title: "RxSwiftとRxCocoaを使ってストップウォッチを作る",
                body: "去年からRxSwiftをしっかり使い始めて、ようやく慣れてきたので今回はRxSwiftとRxCocoaを使ってストップウォッチのようなタイマーを作ってみます。",
                tags: ["iOS", "Swift", "RxSwift", "RxCocoa"].reduce("") { $0 + "#\($1) " },
                likesCount: 2,
                commentsCount: 0)
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
