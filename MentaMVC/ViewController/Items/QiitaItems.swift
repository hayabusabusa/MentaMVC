//
//  QiitaItems.swift
//  MentaMVC
//
//  Created by 吉本和史 on 2020/09/04.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct User: Decodable {
  var profileImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case profileImageURL = "profile_image_url"
  }
}

struct QiitaItems: Decodable {
  var user: User
  var title: String
  var body: String
  var tags: String
  var likesCount: Int
  var commentsCount: Int
  var url: String
  
  enum CodingKeys: String, CodingKey {
    case user
    case title
    case body
    case tags
    case likesCount = "likes_count"
    case commentsCount = "comments_count"
    case url
  }

}
