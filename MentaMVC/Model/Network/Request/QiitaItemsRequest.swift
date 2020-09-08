//
//  QiitaItemsRequest.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Alamofire

struct QiitaItemsRequest: QiitaAPIRequest {
    typealias Response = [QiitaItem]
    
    let page: Int
    
    var path: String {
        return "/items"
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var parameters: Parameters? {
        return [
            "page": page
        ]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var headers: HTTPHeaders? {
        return HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Bearer " + qiitaAccessToken)
        ])
    }
}
