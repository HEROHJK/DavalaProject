//
//  WebServiceManager.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 31..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit
import Alamofire

class WebServiceManager: NSObject {
    let server_ip = "http://hjknas.asuscomm.com:3000" // main server
    
    let bannerList = "banner/list"// 배너리스트
    let itemList = "item/list"// 상품리스트
    let itemDetail = "item/detail" // 상품정보
    let itemImageList = "item/imageList" // 제품이미지들
    let itemSameCategory = "item/sameCategory" // 같이본 상품 목록
    
    static let sharedInstance = WebServiceManager()
    
    override init() {
        super.init()
    }
    
    // With Alamofire
    func getBannerList(success: @escaping(_ data: NSMutableArray?)-> Void, fail: @escaping (_ error: Error?)-> Void) {
        let url = "\(server_ip)/\(bannerList)"
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"]) .validate(statusCode: 200..<300) .responseJSON { (response) in
            if let JSON = response.result.value {
                
                switch response.result {
                case .success(_) :
                    print("success : \(response)")
                    var array = NSMutableArray.init()
                    
                    
                    success(array)
                    break
                    
                case .failure(_):
                    print("success : \(response)")
                    fail(response.result.error)
                    break
                }
                
            }
        }
    }
    
    //
    //http://hjknas.asuscomm.com:3000/banner/list #배너리스트
    //http://hjknas.asuscomm.com:3000/item/list #상품리스트
    //http://hjknas.asuscomm.com:3000/item/detail?productIndex=94 #상품정보
    //http://hjknas.asuscomm.com:3000/item/imageList?productIndex=94 #제품이미지들
    //http://hjknas.asuscomm.com:3000/item/sameCategory?categoryName=%ED%81%B4%EB%A0%8C%EC%A7%95%ED%8F%BC #같이본 상품 목록(=같은 카테고리의 상품들)
    
}
