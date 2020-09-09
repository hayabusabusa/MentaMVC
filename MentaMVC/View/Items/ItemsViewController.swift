//
//  ItemsViewController.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ItemsViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    
    private var viewModel: ItemsViewModel!
    private var dataSource: [ItemsViewControllerCellType] = []
    
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        bindViewModel()
        viewModel.input.viewDidLoad()
    }
}

// MARK: - Configurations

extension ItemsViewController {
    
    private func configureNavigation() {
        navigationItem.title = "記事一覧"
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = ItemsViewControllerCell.estimatedRowHeight
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
        tableView.register(ItemsViewControllerIndicatorCell.nib, forCellReuseIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier)
    }
}

// MARK: - ViewModel

extension ItemsViewController {
    
    private func bindViewModel() {
        let viewModel = ItemsViewModel()
        self.viewModel = viewModel
        
        tableView.rx.reachedBottom.asSignal()
            .emit(onNext: {
                viewModel.reachedBottom()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.dataSourceDriver
            .drive(tableView.rx.items) { tableView, row, element in
                switch element {
                case .item(let item):
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! ItemsViewControllerCell
                    cell.configureCell(profileImageURL: item.user.profileImageURL, title: item.title, body: item.body, tags: item.tags.reduce("") { $0 + "#\($1.name) " }, likesCount: item.likesCount, commentsCount: item.commentsCount)
                    return cell
                case .indicator:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! ItemsViewControllerIndicatorCell
                    cell.configureCell()
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}
