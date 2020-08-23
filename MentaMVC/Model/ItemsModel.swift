//
//  ItemsModel.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/23.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

protocol ItemsModelDelegate: AnyObject {
    func onSuccess(with dataSource: [QiitaItem], isReachLastPage: Bool)
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
    private var isReachLastPage: Bool = false
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: View Trigger
    
    func onViewDidLoad() {
        apiClient.getItems(page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems = response.items
                self?.delegate?.onSuccess(with: response.items, isReachLastPage: false)
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
    
    func onReachBottom() {
        guard !isLoading && !isReachLastPage else { return }
        
        let nextPage = currentPage + 1
        isLoading = true
        
        apiClient.getItems(page: nextPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems += response.items
                self?.currentPage = nextPage
                self?.isLoading = false
                self?.isReachLastPage = nextPage >= response.totalCount
                self?.delegate?.onSuccess(with: self?.currentItems ?? [], isReachLastPage: nextPage >= response.totalCount)
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
}
