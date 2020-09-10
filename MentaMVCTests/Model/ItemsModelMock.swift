//
//  ItemsModelMock.swift
//  MentaMVCTests
//
//  Created by 山田隼也 on 2020/09/10.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import RxSwift
import RxRelay
@testable import MentaMVC

class ItemsModelMock: ItemsModelProtocol {
    
    // MARK: Properties
    
    var qiitaItemsRelay: BehaviorRelay<[QiitaItem]>
    var isReachLastPageRelay: BehaviorRelay<Bool>
    var isLoadingRelay: PublishRelay<Bool>
    
    // MARK: Initializer
    
    init() {
        self.qiitaItemsRelay = BehaviorRelay<[QiitaItem]>(value: [])
        self.isReachLastPageRelay = BehaviorRelay<Bool>(value: false)
        self.isLoadingRelay = PublishRelay<Bool>()
    }
    
    // MARK: Output
    
    func fetchItems() {
        isReachLastPageRelay.accept(false)
        qiitaItemsRelay.accept([
            Mock.createQiitaItem(with: 1)
        ])
    }
    
    func fetchNextPageItems() {
        isReachLastPageRelay.accept(true)
        qiitaItemsRelay.accept(qiitaItemsRelay.value + [Mock.createQiitaItem(with: qiitaItemsRelay.value.count + 1)])
    }
}
