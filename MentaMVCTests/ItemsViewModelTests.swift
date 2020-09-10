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
    
    private var viewModel: ItemsViewModel!
    
    override func setUp() {
        super.setUp()
        let model = ItemsModelMock()
        viewModel = ItemsViewModel(model: model)
    }
    
    func test_画面初回表示時にはロード中のインジケーターが表示されていることを確認() {
        let scheduler           = TestScheduler(initialClock: 0)
        let disposeBag          = DisposeBag()
        let testableObserver    = scheduler.createObserver([ItemsViewControllerCellType].self)
        
        scheduler.scheduleAt(100) { [unowned self] in
            self.viewModel.output.dataSourceDriver
                .drive(testableObserver)
                .disposed(by: disposeBag)
        }
        
        scheduler.start()
        
        let expression = Recorded.events([
            .next(100, [ItemsViewControllerCellType.indicator])
        ])
        XCTAssertEqual(testableObserver.events, expression)
    }
    
    func test_viewDidLoad実行後に記事のデータとインジケーターが表示されていることを確認() {
        let scheduler           = TestScheduler(initialClock: 0)
        let disposeBag          = DisposeBag()
        let testableObserver    = scheduler.createObserver([ItemsViewControllerCellType].self)
        
        scheduler.scheduleAt(100) { [unowned self] in
            self.viewModel.output.dataSourceDriver
                .drive(testableObserver)
                .disposed(by: disposeBag)
        }
        
        scheduler.scheduleAt(200) { [unowned self] in
            self.viewModel.input.viewDidLoad()
        }
        
        scheduler.start()
        
        let expression = Recorded.events([
            .next(100, [ItemsViewControllerCellType.indicator]),
            .next(200, [ItemsViewControllerCellType.item(with: Mock.createQiitaItem(with: 1)), ItemsViewControllerCellType.indicator]),
        ])
        XCTAssertEqual(testableObserver.events, expression)
    }
    
    func test_最終ページを追加で読み込んだ後にはインジケーターが表示されていないことを確認() {
        let scheduler           = TestScheduler(initialClock: 0)
        let disposeBag          = DisposeBag()
        let testableObserver    = scheduler.createObserver([ItemsViewControllerCellType].self)
        
        scheduler.scheduleAt(100) { [unowned self] in
            self.viewModel.output.dataSourceDriver
                .drive(testableObserver)
                .disposed(by: disposeBag)
        }
        
        scheduler.scheduleAt(200) { [unowned self] in
            self.viewModel.input.viewDidLoad()
        }
        
        scheduler.scheduleAt(300) { [unowned self] in
            self.viewModel.input.reachedBottom()
        }
        
        scheduler.start()
        
        let expression = Recorded.events([
            .next(100, [ItemsViewControllerCellType.indicator]),
            .next(200, [ItemsViewControllerCellType.item(with: Mock.createQiitaItem(with: 1)), ItemsViewControllerCellType.indicator]),
            .next(300, [ItemsViewControllerCellType.item(with: Mock.createQiitaItem(with: 1)), ItemsViewControllerCellType.item(with: Mock.createQiitaItem(with: 2))])
        ])
        XCTAssertEqual(testableObserver.events, expression)
    }
}
