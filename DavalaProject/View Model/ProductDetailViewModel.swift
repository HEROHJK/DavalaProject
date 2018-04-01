//
//  ProductDetailViewModel.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 10..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductDetailViewModel {
    var item:Item {
        get {
            return self.item
        }
        set {
            self.item = newValue
        }
    }
    init() {
    
    }
    
    func getItemDetail(completion: @escaping (_ error: String?)->()) {
        let urlString = "\(AppURL.server_ip.rawValue)\(AppURL.reviewFeedList.rawValue)"
        print("urlString \(urlString)")
        Alamofire
            .request(urlString, method: .get).responseData {
                response in
                guard response.result.isSuccess else {
                    completion(ErrorMessages.connectionError.rawValue)
                    return
                }
                completion(nil)
        }
    }
}
