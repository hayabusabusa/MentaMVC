//
//  ItemsModel.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

final class ItemsModel {
    
    // MARK: Dependency
    
    private let apiClient: QiitaAPIClientProtocol
    
    // MARK: Initializer
    
    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
}
