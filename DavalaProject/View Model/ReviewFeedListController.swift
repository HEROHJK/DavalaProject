//
//  ReviewFeedListController.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 2. 2..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ReviewFeedListController {
    
    var reviewFeeds: [ReviewFeedData] = []
    
    //MARK:- API CALLS
    func getReviewFeedList(completion: @escaping (_ error: String?)->()) {
        let urlString = "\(AppURL.server_ip.rawValue)\(AppURL.reviewFeedList.rawValue)"
        print("urlString \(urlString)")
        Alamofire
            .request(urlString, method: .get)
            //            .responseJSON { response in
            //                if let JSON = response.result.value {
            //                    print("JSON: \(JSON)")
            //                }
            .responseData {
                response in
                guard response.result.isSuccess else {
                    completion(ErrorMessages.connectionError.rawValue)
                    return
                }
                print("reviewfeed response \(String(describing: response))")
                self.reviewFeeds = try! ReviewFeedData.initFromArray(json: JSON(data: response.data!))
                print("reviewfeed reviewFeeds \(self.reviewFeeds)")
                completion(nil)
        }
    }
    
}
