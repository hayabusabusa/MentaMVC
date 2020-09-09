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
    var isLoadingRelay: PublishRelay<Bool> { get }
    func fetchItems()
}

final class ItemsModel: ItemsModelProtocol {
    
    // MARK: Dependency
    
    private let apiClient: QiitaAPIClientProtocol
    
    // MARK: Properties
    
    var qiitaItemsRelay = BehaviorRelay<[QiitaItem]>(value: [])
    var isLoadingRelay = PublishRelay<Bool>()
    
    private let errorRelay = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    private var currentPage: Int = 1
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
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
