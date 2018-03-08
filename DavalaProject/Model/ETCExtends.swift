//
//  ETCExtends.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Swift

//정수 후위증가
postfix func ++(value: inout Int) -> Int{
    value+=1
    return value
}
