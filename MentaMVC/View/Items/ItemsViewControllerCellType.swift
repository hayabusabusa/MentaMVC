//
//  ItemsViewControllerCellType.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/22.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

enum ItemsViewControllerCellType: Equatable {
    case item(with: QiitaItem)
    case indicator
    
    static func == (lhs: ItemsViewControllerCellType, rhs: ItemsViewControllerCellType) -> Bool {
        switch (lhs, rhs) {
        case let (.item(l), item(r)):
            return l.id == r.id
        case (.indicator, .indicator):
            return true
        default:
            return false
        }
    }
}
