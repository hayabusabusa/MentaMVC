//
//  QiitaAPIClient.swift
//  MentaMVC
//
//  Created by 山田隼也 on 2020/09/08.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Alamofire
import RxSwift

protocol QiitaAPIClientProtocol {
    func call<T: QiitaAPIRequest>(with request: T) -> Single<T.Response>
}

final class QiitaAPIClient: QiitaAPIClientProtocol {
    
    // MARK: Singleton
    
    static let shared = QiitaAPIClient()
    
    // MARK: Initializer
    
    private init() {}
    
    // MARK: API
    
    func call<T: QiitaAPIRequest>(with request: T) -> Single<T.Response> {
        return Single.create { observer in
            let url     = request.baseURL + request.path
            let request = AF.request(url,
                                     method: request.method,
                                     parameters: request.parameters,
                                     encoding: request.encoding,
                                     headers: request.headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do {
                            guard let data = response.data else { return }
                            let entity = try JSONDecoder().decode(T.Response.self, from: data)
                            observer(.success(entity))
                        } catch {
                            observer(.error(error))
                        }
                    case .failure(let error):
                        observer(.error(error))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
