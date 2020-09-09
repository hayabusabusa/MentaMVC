//
//  ItemsModel.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import RxSwift
import RxRelay

protocol ItemsModelProtocol {
    var qiitaItemsRelay: BehaviorRelay<[QiitaItem]> { get }
    var isReachLastPageRelay: BehaviorRelay<Bool> { get }
    var isLoadingRelay: PublishRelay<Bool> { get }
    func fetchItems()
}

final class ItemsModel: ItemsModelProtocol {
    
    // MARK: Dependency
    
    private let apiClient: QiitaAPIClientProtocol
    
    // MARK: Properties
    
    var qiitaItemsRelay = BehaviorRelay<[QiitaItem]>(value: [])
    var isReachLastPageRelay = BehaviorRelay<Bool>(value: false)
    var isLoadingRelay = PublishRelay<Bool>()
    
    private let errorRelay = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    private var currentPage: Int = 1
    private var isLoadingNextPage: Bool = false
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchItems() {
        isLoadingRelay.accept(true)
        apiClient.call(with: QiitaItemsRequest(page: currentPage))
            .subscribe(onSuccess: { [weak self] response in
                self?.isLoadingRelay.accept(false)
                self?.isReachLastPageRelay.accept(false)
                self?.qiitaItemsRelay.accept(response)
            }, onError: { [weak self] error in
                self?.isLoadingRelay.accept(false)
                self?.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchNextPageItems() {
        guard !isLoadingNextPage && !isReachLastPageRelay.value else {
            return
        }
        
        let nextPage = currentPage + 1
        isLoadingNextPage = true
        
        apiClient.call(with: QiitaItemsPaginationRequest(page: nextPage))
            .subscribe(onSuccess: { [weak self] response in
                self?.currentPage = nextPage
                self?.isReachLastPageRelay.accept(response.totalCount <= nextPage)
                self?.qiitaItemsRelay.accept(response.items)
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
}
