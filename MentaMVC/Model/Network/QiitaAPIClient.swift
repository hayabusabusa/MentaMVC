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
    func getItems(completion: @escaping (Result<[QiitaItem], Error>) -> Void)
}

final class QiitaAPIClient {
    
    // MARK: Singleton
    
    static let shared: QiitaAPIClient = .init()
    
    // MARK: Properties
    
    private let baseURL: String = "https://qiita.com/api/v2"
    
    // MARK: Initializer
    
    private init() {
        
    }
    
    // MARK: Requests
    
    func getItems(completion: @escaping (Result<[QiitaItem], Error>) -> Void) {
        let url = baseURL + "/items"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else { return }
                    let items = try JSONDecoder().decode([QiitaItem].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
