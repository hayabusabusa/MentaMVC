//
//  QiitaAPIRequest.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Alamofire

protocol QiitaAPIRequest {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var parameters: Alamofire.Parameters? { get }
    var headers: Alamofire.HTTPHeaders? { get }
}

extension QiitaAPIRequest {
    var baseURL: String {
        return "https://qiita.com/api/v2"
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
}
