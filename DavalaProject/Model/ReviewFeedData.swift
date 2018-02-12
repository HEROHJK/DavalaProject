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
    var index         : Int?
    var title         : String?
    var updatedtime   : String?
    var content      : String?
//    var imageurl         : UIImage?
    var writer        : String?
//    var like          : Bool?   //Todo : 계정 연동 후 작업 예정
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        index = json["index"].intValue
        title = json["title"].stringValue
        updatedtime = json["updatedtime"].stringValue
        content = json["content"].stringValue
        writer = json["writer"].stringValue

    }
    
//    static func initFromObject(json: JSON!)-> Void/*ReviewFeedData*/ {
//        if json.isEmpty {
//            print("json is Empty")
//        }
//
//        print("json is \(json.object)")
//
//    }
    
    static func initFromArray(json: JSON!)-> [ReviewFeedData] {
        if json.isEmpty {
            return []
        }
        
        var reviewFeedDatas = [ReviewFeedData]()
//        let reviewFeedDataArray = json["reviewFeeds"].arrayValue
        let reviewFeedDataArray = json.arrayValue
        for reviewFeedJson in reviewFeedDataArray {
            let value = ReviewFeedData(fromJson: reviewFeedJson)
            reviewFeedDatas.append(value)
        }
        
        return reviewFeedDatas
    }
    
}
