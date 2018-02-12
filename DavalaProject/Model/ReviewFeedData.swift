//
//  ReviewFeedData.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 1. 25..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import SwiftyJSON

class ReviewFeedData {
    var reviewFeedIdx : Int?
    var subject       : String?
    var contents      : String?
    var image         : UIImage?
    var writer        : String?
    var like          : Bool?   //Todo : 계정 연동 후 작업 예정
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        subject = json["subject"].stringValue
//        contents = json["contents"].stringValue
        
    }
    
    static func initFromObject(json: JSON!)-> Void/*ReviewFeedData*/ {
        if json.isEmpty {
            print("json is Empty")
        }
        
        print("json is \(json.object)")
        
    }
    
    static func initFromArray(json: JSON!)-> [ReviewFeedData] {
        if json.isEmpty {
            return []
        }
        
        var reviewFeedDatas = [ReviewFeedData]()
        let reviewFeedDataArray = json["reviewFeeds"].arrayValue
        for reviewFeedJson in reviewFeedDataArray {
            let value = ReviewFeedData(fromJson: reviewFeedJson)
            reviewFeedDatas.append(value)
        }
        
        return reviewFeedDatas
    }
    
}
