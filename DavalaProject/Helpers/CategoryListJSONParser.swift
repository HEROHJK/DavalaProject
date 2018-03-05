//
//  JSONParser.swift
//  CategoryList
//
//  Created by HwanYong Kim on 2018. 2. 26..
//  Copyright © 2018년 HwanYong Kim. All rights reserved.
//

import Foundation
import Alamofire

let KEY_PARENT_INDEX = "parentIndex"
let KEY_NAME = "name"
let KEY_INDEX = "index"

class CategoryListJSONParser: NSObject {
    var JSONText: String = ""
    
    
    func onDecodeJSON(){
        
        Alamofire.request("http://hjknas.asuscomm.com:3000/category/list", method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"]) .validate(statusCode: 200..<300) .responseJSON { (response) in
            if let JSON = response.result.value {
                
                switch response.result {
                case .success(_) :
                    if let data = response.result.value {

                        let itemList: Array<AnyObject> = data as! Array<AnyObject>
                        var topItemIndexList: Array<Int> = Array()
                        
                        // 최상위 카테고리 저장
                        for i in 0 ..< itemList.count {
                            let dict: Dictionary<String, AnyObject> = itemList[i] as! Dictionary<String, AnyObject>
                            let parentIndex: Int = dict[KEY_PARENT_INDEX] as! Int
                            
                            if parentIndex == 0 {
                                let name: String = dict[KEY_NAME] as! String
                                let index: Int = dict[KEY_INDEX] as! Int
                                //최상위 카테고리 CategoryType.CATEGORY_TYPE_BIG
                                AppDelegate().sharedAppDelegate().categoryListMgr.addItem(withIndex: index, name: name, parentIndex: parentIndex, categoryType: CategoryType.CATEGORY_TYPE_BIG)
                                topItemIndexList.append(index)
                            }
                        }
                        
                        // 중위, 하위 카테고리 저장
                        for i in 0 ..< itemList.count {
                            let dict: Dictionary<String, AnyObject> = itemList[i] as! Dictionary<String, AnyObject>
                            let parentIndex: Int = dict[KEY_PARENT_INDEX] as! Int
                            let index: Int = dict[KEY_INDEX] as! Int
                            let name: String = dict[KEY_NAME] as! String
                            var isMiddleItem: Bool = false
                            
                            if parentIndex != 0 {
                                //중위나 하위 카테고리 일 때
                                
                                for i in 0 ..< topItemIndexList.count {
                                    let topItemIndex: Int = topItemIndexList[i]
                                    
                                    if topItemIndex == parentIndex {
                                        isMiddleItem = true //자신의 parentIndex가 최상위의 카테고리 아이템일때
                                    }
                                }
                                
                                if isMiddleItem {
                                    //middle
                                    AppDelegate().sharedAppDelegate().categoryListMgr.addItem(withIndex: index, name: name, parentIndex: parentIndex, categoryType: CategoryType.CATEGORY_TYPE_MIDEUM)
                                } else {
                                    //low
                                    AppDelegate().sharedAppDelegate().categoryListMgr.addItem(withIndex: index, name: name, parentIndex: parentIndex, categoryType: CategoryType.CATEGORY_TYPE_SMALL)
                                }
                            }
                        }
                        
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
                    break
                }
                
            }
        }
    }
    
    func parseJSONResults(JSONdata: String) -> [String: AnyObject]? {
        
        let data = JSONdata.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            return json
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return nil
    }
    
}


