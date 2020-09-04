//
//  QiitaItems.swift
//  MentaMVC
//
//  Created by 吉本和史 on 2020/09/04.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct QiitaItems: Decodable {
  let user: User
  let title: String
  let body: String
  let tags: String
  let likesCount: Int
  let commentsCount: Int
  let url: String
  
  private enum CodingKeys: String, CodingKey {
    case user
    case title
    case body
    case tags
    case likesCount = "likes_count"
    case commentsCount = "comments_count"
    case url
  }

}
