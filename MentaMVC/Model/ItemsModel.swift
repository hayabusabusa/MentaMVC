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
    var qiitaItems: Observable<[QiitaItem]> { get }
    var isLoading: Observable<Bool> { get }
    func fetchItems()
}

final class ItemsModel {
    
    // MARK: Dependency
    
    private let apiClient: QiitaAPIClientProtocol
    
    // MARK: Properties
    
    private let qiitaItemsRelay = BehaviorRelay<[QiitaItem]>(value: [])
    private let isLoadingRelay = PublishRelay<Bool>()
    private let errorRelay = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    private var currentPage: Int = 0
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
}

extension ItemsModel: ItemsModelProtocol {
    
    var qiitaItems: Observable<[QiitaItem]> {
        return qiitaItemsRelay.asObservable()
    }
    
    var isLoading: Observable<Bool> {
        return isLoadingRelay.asObservable()
    }
    
    func fetchItems() {
        isLoadingRelay.accept(true)
        apiClient.call(with: QiitaItemsRequest(page: currentPage))
            .subscribe(onSuccess: { [weak self] response in
                self?.isLoadingRelay.accept(false)
                self?.qiitaItemsRelay.accept(response)
            }, onError: { [weak self] error in
                self?.isLoadingRelay.accept(false)
                self?.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
