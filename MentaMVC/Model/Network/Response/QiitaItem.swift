//
//  QiitaItem.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/04.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct QiitaItem: Decodable {
    let id: String
    let title: String?
    let body: String?
    let url: String?
    let likesCount: Int
    let commentsCount: Int
    let user: QiitaUser
    let tags: [QiitaItemTag]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case url
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
        case user
        case tags
    }
}
