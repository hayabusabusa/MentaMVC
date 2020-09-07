//
//  GetQiita.swift
//  MentaMVC
//
//  Created by 吉本和史 on 2020/09/05.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Alamofire

protocol ItemsModelDelegate: AnyObject {
    func getQiitaData(qiitaItems: [QiitaItems])
}

final class ItemsModel {
    
    weak var delegate: ItemsModelDelegate?
    
    func getQiitaData() {
        // ViewDidLoad でする処理
        let urlString = "https://qiita.com/api/v2/items?page=1&per_page=20"
        let url = URL(string: urlString)
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .success:
                    // JSON からの変換
                    do {
                        guard let data = response.data else { return }
                        let qiitaItems = try JSONDecoder().decode([QiitaItems].self, from: data)
                        print(qiitaItems)
                        self.delegate?.getQiitaData(qiitaItems: qiitaItems)
                    } catch {
                        // デコードのエラー
                        print(error)
                    }
                case .failure:
                  print("failure")
            }
        }
    }
}

