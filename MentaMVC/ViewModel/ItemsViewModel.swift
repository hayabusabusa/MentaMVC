//
//  ItemsViewModel.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ItemsViewModelInput {
    func viewDidLoad()
}

protocol ItemsViewModelOutput {
    var qiitaItemsRelay: BehaviorRelay<[QiitaItem]> { get }
    var isLoadingRelay: PublishRelay<Bool> { get }
}

protocol ItemsViewModelType {
    var input: ItemsViewModelInput { get }
    var output: ItemsViewModelOutput { get }
}

final class ItemsViewModel: ItemsViewModelInput, ItemsViewModelOutput {
    
    // MARK: Dependency
    
    private let model: ItemsModelProtocol
    
    // MARK: Properties
    
    var qiitaItemsRelay: BehaviorRelay<[QiitaItem]>
    var isLoadingRelay: PublishRelay<Bool>
    
    // MARK: Initializer
    
    init(model: ItemsModelProtocol = ItemsModel()) {
        self.model = model
        self.qiitaItemsRelay = model.qiitaItemsRelay
        self.isLoadingRelay = model.isLoadingRelay
    }
    
    // MARK: Input
    
    func viewDidLoad() {
        model.fetchItems()
    }
}

extension ItemsViewModel: ItemsViewModelType {
    var input: ItemsViewModelInput { self }
    var output: ItemsViewModelOutput { self }
}
