//
//  ItemsModel.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/23.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

protocol ItemsModelDelegate: AnyObject {
    func onSuccess(with items: [QiitaItem])
    func onError(with error: Error)
}

final class ItemsModel {
    
    // MARK: Delegate
    
    weak var delegate: ItemsModelDelegate?
    
    // MARK: Dependency
    
    private let apiClient: QiitaAPIClientProtocol
    
    // MARK: Properties
    
    private var currentPage: Int = 1
    private var currentItems: [QiitaItem] = []
    private var isLoading: Bool = false
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: View Trigger
    
    func onViewDidLoad() {
        apiClient.getItems(page: currentPage) { [weak self] result in
            switch result {
            case .success(let items):
                self?.currentItems = items
                self?.delegate?.onSuccess(with: items)
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
    
    func onReachBottom() {
        guard !isLoading else { return }
        
        let nextPage = currentPage + 1
        isLoading = true
        
        apiClient.getItems(page: nextPage) { [weak self] result in
            switch result {
            case .success(let items):
                self?.currentItems += items
                self?.currentPage = nextPage
                self?.isLoading = false
                self?.delegate?.onSuccess(with: self?.currentItems ?? [])
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
}
