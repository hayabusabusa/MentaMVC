//
//  QiitaAPIResponseTests.swift
//  MentaMVCTests
//
//  Created by 山田隼也 on 2020/09/10.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import XCTest
@testable import MentaMVC

class QiitaAPIResponseTests: XCTestCase {
    
    func test_Decodable準拠のモデルオブジェクトのテスト() {
        XCTContext.runActivity(named: "/items のレスポンスを正しくデコードできることを確認.") { _ in
            let data = resource(name: .response, resourceType: .json)
            let response = try? JSONDecoder().decode([QiitaItem].self, from: data)
            XCTAssertNotNil(response, "/items のレスポンスのデコードに失敗しました.")
        }
    }
}
