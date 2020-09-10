//
//  Mock.swift
//  MentaMVCTests
//
//  Created by 山田隼也 on 2020/09/10.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
@testable import MentaMVC

enum Mock {
    static func createQiitaItem(with index: Int) -> QiitaItem {
        return QiitaItem(id: "\(index)", title: "TEST", body: "TEST", url: "TEST", likesCount: index, commentsCount: index, user: QiitaUser(profileImageURL: "TEST"), tags: [QiitaItemTag(name: "TEST")])
    }
}
