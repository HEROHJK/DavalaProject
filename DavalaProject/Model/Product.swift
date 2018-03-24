//
//  Product.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 24..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation

class Product {
    var productImageUrl:String!//상품 url
    var subTitle:String!//상품 부가설명
    var title:String!//상품명
    var originPrice:Int!//원래상품가격
    var salePrice:Int!//할인 상품가격
    var salePercent:Int!//할인율
    var shipInfo:String!//무료배송인지 아닌지
    
    //이건 따로 받아오는걸로
    var reviewArray:NSMutableArray!//리뷰피드리스트
    
    var productDetailImageUrl:String! //상품 상세 설명
    
    //이것도 따로 받아와야함
    var productInfo:ShipProductInfo!//배송/상품정보
    
    //이것도 따로 받아오는걸로
    var relationProductArray:NSMutableArray!//같이 본 상품 목록
    
}
