//
//  ShipInfo.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 24..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation

class ShipProductInfo {
    var shipType:String!//배송 유형
    var shipMethod:String!//배송 방법
    var shipCompany:String!//배송사
    var shipPrice:String!//배송비
    var shipInfo:String!//배송정보
    var shipPack:String!//묶음배송
    var shipUnusualData:String!//특이사항
    
    var productSaleInfo:String!//상품판매정보안내
    
    var exchangeInfo:String!//교환/반품/환불 안내
    
    var exchangeLimit:String!//교환/반품기간
    var exchangePrice:String!//교환/반품 배송비
    var exchangeDisaloowReason:String!//교환/반품 불가사유
}
