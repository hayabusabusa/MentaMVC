//
//  QiitaItemsPaginationRequest.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/09.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Alamofire

struct QiitaItemsPaginationRequest: QiitaAPIComplexRequest {
    typealias Response = QiitaItemsResponse
    
    let page: Int
    let perPage: Int = 20
    
    var path: String {
        return "/items"
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var parameters: Parameters? {
        return [
            "page": page,
            "per_page": perPage
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
    
    func decode(from response: AFDataResponse<Any>) throws -> QiitaItemsResponse {
        guard let totalCountString = response.response?.value(forHTTPHeaderField: "total-count"),
            let totalCount = Int(totalCountString),
            let data = response.data else {
                throw AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil)
        }
        
        do {
            let items = try JSONDecoder().decode([QiitaItem].self, from: data)
            return QiitaItemsResponse(items: items, totalCount: totalCount)
        } catch {
            throw error
        }
    }
}
