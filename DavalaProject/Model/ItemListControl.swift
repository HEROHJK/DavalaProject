//
//  ItemListControl.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON


func MakeBannerList(Json:JSON)->Item{
    var bannerItem:Item = Item()
    
    for json in Json{
        let data = json.1.dictionary!
        
        bannerItem.BannerList.append(Banner(
            imageURL:(data["url"]?.stringValue)!,
            subject: (data["subject"]?.stringValue)!
        ))
    }
    
    return bannerItem
}

/*
 * 리스트를 처음 만들때.
 * 처음만들때는 배너를 가져온 후 먼저 첫번째에 배너목록을 집어넣고, 그 후에 아이템 목록을 집어넣는다
 */
func MakeItemList(itemList: [Item], Json: JSON) -> [Item]{
    var newItemList:[Item] = itemList
    
    var count = 0
    for json in Json{
        let data = json.1
        
        newItemList.append(Item(
            imageURL: (data["URL"].stringValue),
            productName: (data["name"].stringValue),
            price: (data["price"].stringValue).DeleteDot,
            discount: (data["discount"].stringValue),
            percentage: (data["percentage"].stringValue),
            discountPrice : (data["discountPrice"].stringValue).DeleteDot
        ))
        count+=1
        if count >= itemLoadCount {
            break//처음 만들기때문에 지정한 개수만큼만 받아온다
        }
    }
    
    return newItemList
}

/*
 * 아이템들을 추가 할때.
 */
func AddItemList(Json: JSON, list: inout [Item]) -> [Item]{
    var itemList = list
    
    let newJson = Json
    let maxCount = list.count+itemLoadCount//최대카운트는 현재 개수 + 지정한 개수단위를 더한다
    var currentCount = 0
    
    for json in newJson{
        if currentCount++ <= list.count{
            continue//매번 0번부터 끝까지 호출하므로, 0번부터 현재까지는 생략.(안하면 중복추가됨)
        }
        let data = json.1
        
        itemList.append(Item(
            imageURL: (data["URL"].stringValue),
            productName: (data["name"].stringValue),
            price: (data["price"].stringValue).DeleteDot,
            discount: (data["discount"].stringValue),
            percentage: (data["percentage"].stringValue),
            discountPrice : (data["discountPrice"].stringValue).DeleteDot
        ))
        
        if currentCount >= maxCount{
            break//필요한만큼 구했으면 반복을 끝낸다
        }
    }
    
    return itemList
}
