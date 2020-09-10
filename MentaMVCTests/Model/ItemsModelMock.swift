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
        qiitaItemsRelay.accept([
            QiitaItem(id: "TEST", title: "TEST", body: "TEST", url: "https://qiita.com/", likesCount: 0, commentsCount: 0, user: QiitaUser(profileImageURL: "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/202306/profile-images/1566547186"), tags: [QiitaItemTag(name: "TEST")])
        ])
    }
    
    func fetchNextPageItems() {
        
    }
}
