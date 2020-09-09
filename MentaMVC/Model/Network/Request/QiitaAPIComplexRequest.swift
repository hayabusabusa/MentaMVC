//
//  QiitaAPIComplexRequest.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/09.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Alamofire

protocol QiitaAPIComplexRequest {
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var parameters: Alamofire.Parameters? { get }
    var headers: Alamofire.HTTPHeaders? { get }
    
    func decode(from response: Alamofire.AFDataResponse<Any>) throws -> Response
}

extension QiitaAPIComplexRequest {
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
