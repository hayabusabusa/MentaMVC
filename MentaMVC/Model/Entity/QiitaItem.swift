//
//  QiitaItem.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/23.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct QiitaItem: Decodable {
    let title: String?
    let body: String?
    let url: String?
    let likesCount: Int
    let commentsCount: Int
    let user: QiitaUser
    let tags: [QiitaItemTag]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case body
        case url
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
        case user
        case tags
    }
}
