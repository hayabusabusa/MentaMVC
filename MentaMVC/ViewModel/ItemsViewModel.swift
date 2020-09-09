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
    var dataSourceDriver: Driver<[ItemsViewControllerCellType]> { get }
    var isLoadingSignal: Signal<Bool> { get }
}

protocol ItemsViewModelType {
    var input: ItemsViewModelInput { get }
    var output: ItemsViewModelOutput { get }
}

final class ItemsViewModel: ItemsViewModelInput, ItemsViewModelOutput {
    
    // MARK: Dependency
    
    private let model: ItemsModelProtocol
    
    // MARK: Properties
    
    var dataSourceDriver: Driver<[ItemsViewControllerCellType]>
    var isLoadingSignal: Signal<Bool>
    
    // MARK: Initializer
    
    init(model: ItemsModelProtocol = ItemsModel()) {
        self.model = model
        self.dataSourceDriver = model.qiitaItemsRelay
            .map { $0.map { ItemsViewControllerCellType.item(with: $0) } }
            .asDriver(onErrorDriveWith: .empty())
        self.isLoadingSignal = model.isLoadingRelay.asSignal()
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
