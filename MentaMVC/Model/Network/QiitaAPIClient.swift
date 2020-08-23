//
//  QiitaAPIClient.swift
//  MentaMVC
//
//  Created by Shunya Yamada on 2020/08/23.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Alamofire

protocol QiitaAPIClientProtocol {
    func getItems(page: Int, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void)
}

final class QiitaAPIClient: QiitaAPIClientProtocol {
    
    // MARK: Singleton
    
    static let shared: QiitaAPIClient = .init()
    
    // MARK: Properties
    
    private let baseURL: String = "https://qiita.com/api/v2"
    
    // MARK: Initializer
    
    private init() {}
    
    // MARK: Requests
    
    func getItems(page: Int, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void) {
        let url = baseURL + "/items?page=\(page)"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data,
                        let totalCountString = response.response?.headers["total-count"],
                        let totalCount = Int(totalCountString) else { return }
                    
                    let items = try JSONDecoder().decode([QiitaItem].self, from: data)
                    completion(.success(QiitaItemsResponse(items: items, totalCount: totalCount)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
