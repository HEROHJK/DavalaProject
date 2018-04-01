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
    var imageurl         : String?
    var writer        : String?
    //    var like          : Bool?   //Todo : 계정 연동 후 작업 예정
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        index = json["ProductKey"].intValue
        title = json["ProductName"].stringValue
        updatedtime = json["date"].stringValue
        content = json["comment"].stringValue
        writer = json["nickname"].stringValue
        imageurl = json["url"].stringValue
    }
    
    static func initFromArray(json: JSON!)-> [ReviewFeedData] {
        if json.isEmpty {
            return []
        }
        
        var reviewFeedDatas = [ReviewFeedData]()
        let reviewFeedDataArray = json.arrayValue
        for reviewFeedJson in reviewFeedDataArray {
            let value = ReviewFeedData(fromJson: reviewFeedJson)
            reviewFeedDatas.append(value)
        }
        
        return reviewFeedDatas
    }
    
}

