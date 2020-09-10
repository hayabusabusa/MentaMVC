//
//  ItemsViewModelTests.swift
//  MentaMVCTests
//
//  Created by 山田隼也 on 2020/09/10.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import MentaMVC

class ItemsViewModelTests: XCTestCase {
    
    func test_画面初回表示時にはロード中のインジケーターが表示されていることを確認() {
        let scheduler   = TestScheduler(initialClock: 0)
        let disposeBag  = DisposeBag()
        let model       = ItemsModelMock()
        let viewModel   = ItemsViewModel(model: model)
        let testableObserver  = scheduler.createObserver([ItemsViewControllerCellType].self)
        
        scheduler.scheduleAt(100) {
            viewModel.output.dataSourceDriver
                .drive(testableObserver)
                .disposed(by: disposeBag)
        }
        
        scheduler.start()
        
        let expression = Recorded.events([
            .next(100, [ItemsViewControllerCellType.indicator])
        ])
        
        XCTAssertEqual(testableObserver.events, expression)
    }
}
