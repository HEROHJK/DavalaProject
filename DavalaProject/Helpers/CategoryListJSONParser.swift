//
//  JSONParser.swift
//  CategoryList
//
//  Created by HwanYong Kim on 2018. 2. 26..
//  Copyright © 2018년 HwanYong Kim. All rights reserved.
//

import Foundation

let KEY_PARENT_INDEX = "parentIndex"
let KEY_NAME = "name"
let KEY_INDEX = "index"
let KEY_CHILD_LIST = "childList"
let KEY_MOST_TOP_CATEGORY = "카테고리"

class CategoryListJSONParser: NSObject {
    var JSONText: String = ""
    
    
    func onDecodeJSON(){
        
        //        let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
        //        let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        //
        //        do {
        //            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
        //            if let names = json["names"] as? [String] {
        //                print(names)
        //            }
        //        } catch let error as NSError {
        //            print("Failed to load: \(error.localizedDescription)")
        //        }
        
        JSONText = "{ \"index\" : \"-1\" , \"name\" : \"카테고리\" ,  \"parentIndex\" : \"-2\" , \"childList\" : [ { \"index\" : \"15\", \"name\" : \"화장품\", \"parentIndex\" : \"-1\", \"childList\" : [{ \"index\" : \"20\", \"name\" : \"립스틱\", \"parentIndex\" : \"15\", \"childList\" : [{\"index\" : \"100\" , \"name\" : \"빨간립스틱\", \"parentIndex\" : \"20\", \"childList\" : []} , { \"index\" : \"110\", \"name\" : \"파란립스틱\", \"parentIndex\" : \"20\", \"childList\" : [] }] } , { \"index\" : \"29\", \"name\" : \"샴푸\", \"parentIndex\" : \"15\" , \"childList\": [ { \"index\" : \"120\" , \"name\" : \"파란샴푸\", \"parentIndex\": \"29\", \"childList\":[] } , { \"index\" : \"130\" , \"name\" : \"빨간샴푸\" , \"parentIndex\" : \"29\" , \"childList\" : []  } ] }  ]  } ] }"
        
        //        JSONText = "{\"names\" : [\"Bob\", \"Tim\", \"Tina\"]}"
        
        let src: String = JSONText
        var json = self.parseJSONResults(JSONdata: src)
        
        var bigCaterogyList: Array<Any> = json![KEY_CHILD_LIST] as! Array<Any>
        for i in 0 ..< bigCaterogyList.count {
            var bigDic: Dictionary<String, AnyObject> = bigCaterogyList[i] as! Dictionary<String, AnyObject>
            var indexStr: String = bigDic[KEY_INDEX] as! String
            var parentIndexStr: String = bigDic[KEY_PARENT_INDEX] as! String
            
            AppDelegate().sharedAppDelegate().categoryListMgr.addItem(withIndex: Int(indexStr)! , name: bigDic[KEY_NAME] as! String, parentIndex:Int(parentIndexStr)! , categoryType: CategoryType.CATEGORY_TYPE_BIG)
            
            var middleCategoryList: Array<Any> = bigDic[KEY_CHILD_LIST] as! Array<Any>
            for j in 0 ..< middleCategoryList.count {
                var middleDic: Dictionary<String, AnyObject> = middleCategoryList[j] as! Dictionary<String, AnyObject>
                indexStr = middleDic[KEY_INDEX] as! String
                parentIndexStr = middleDic[KEY_PARENT_INDEX] as! String
                AppDelegate().sharedAppDelegate().categoryListMgr .addItem(withIndex: Int(indexStr)!, name: middleDic[KEY_NAME] as! String, parentIndex: Int(parentIndexStr)!, categoryType: CategoryType.CATEGORY_TYPE_MIDEUM)
                
                var smallCategoryList: Array<Any> = middleDic[KEY_CHILD_LIST] as! Array<Any>
                for k in 0 ..< smallCategoryList.count {
                    var smallDic: Dictionary<String, AnyObject> = smallCategoryList[k] as! Dictionary<String, AnyObject>
                    indexStr = smallDic[KEY_INDEX] as! String
                    parentIndexStr = smallDic[KEY_PARENT_INDEX] as! String
                    AppDelegate().sharedAppDelegate().categoryListMgr.addItem(withIndex: Int(indexStr)!, name: smallDic[KEY_NAME] as! String, parentIndex: Int(parentIndexStr)!, categoryType: CategoryType.CATEGORY_TYPE_SMALL)
                }
            }
        }
        
    }
    
    
    
    func parseJSONResults(JSONdata: String) -> [String: AnyObject]? {
        //        let tempData = JSONdata.data(using: String.Encoding.utf8, allowLossyConversion: false)
        //        do {
        //            if let data = tempData,
        //                let json: Dictionary<String, Array<Any>> = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: Array<Any>] {
        //                return json
        //            } else {
        //                print("No Data :/")
        //            }
        //        } catch {
        //            // 실패한 경우, 오류 메시지를 출력합니다.
        //            print("Error, Could not parse the JSON request")
        //        }
        
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


