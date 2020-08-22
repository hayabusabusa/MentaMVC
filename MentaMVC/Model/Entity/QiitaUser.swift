//
//  QiitaUser.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/23.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct QiitaUser: Decodable {
    let profileImageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
    }
}
