//
//  QiitaUser.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/04.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct QiitaUser: Decodable {
    let profileImageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
    }
}
