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
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = ItemsViewControllerCell.estimatedRowHeight
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
    }
}

// MARK: - TableView DataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerCell
        return cell
    }
}

// MARK: - TableView Delegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
