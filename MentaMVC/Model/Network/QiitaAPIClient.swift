//
//  QiitaAPIClient.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Alamofire

final class QiitaAPIClient {
    
    // MARK: Singleton
    
    static let shared = QiitaAPIClient()
    
    // MARK: Initializer
    
    private init() {}
    
    // MARK: API
    
    func call<T: QiitaAPIRequest>(with request: T, completion: @escaping ((Result<T.Response, Error>) -> Void)) {
        let url = request.baseURL + request.path
        AF.request(url,
                   method: request.method,
                   parameters: request.parameters,
                   encoding: request.encoding,
                   headers: request.headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let entity = try JSONDecoder().decode(T.Response.self, from: data)
                        completion(.success(entity))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
