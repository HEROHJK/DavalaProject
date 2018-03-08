//
//  ItemList.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Swift

public struct Banner{
    public var url:String
    public var subject:String
    
    public init(imageURL: String, subject: String){
        self.url = imageURL
        self.subject = subject
    }
}

/*
 * JSON파싱을 통해 아이템인지, 배너지인지 파악을 한다.
 * 우선 배너인경우는 배열의 맨 처음밖에 없도록 설계되었다.
 */

public struct Item{
    public var url: String                  //URL 문자열(이미지)
    public var name: String                 //품명
    public var price: String                //금액
    public var discount: Bool               //할인유무
    public var percentage: String           //할인율
    public var discountPrice: String        //할인가
    public var isBanner: Bool               //배너목록유무
    public var BannerList:[Banner]          //배너목록
    
    //디폴트 생성자.
    public init(){
        self.url = ""
        self.name = ""
        self.isBanner = true
        
        self.price=""
        self.discount=false
        self.percentage=""
        self.discountPrice=""
        self.BannerList=[Banner]()
    }
    
    //매개변수 생성자. 배너가 아닌 아이템을 추가할때 사용된다.
    public init(imageURL: String, productName: String, price: String, discount: String, percentage: String, discountPrice: String){
        self.url = imageURL//UIImage(url: URL(string: imageURL))! -> 이방식으로하면 로딩할때 시간이 너무 할애된다.
        self.name = productName
        self.price = price
        if discount == "T"{
            self.discount = true
        }
        else {
            self.discount = false
        }
        self.percentage = percentage
        self.discountPrice = discountPrice
        self.isBanner = false
        self.BannerList=[Banner]()
    }
}
