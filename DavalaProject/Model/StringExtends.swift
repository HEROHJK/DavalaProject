//
//  StringExtends.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import Swift

extension String{
    /*
     * 문자열중 해당 문자가 존재하는지 확인하는 함수
     */
    func exist(at char: Character) -> Bool{
        let arr = Array(self)
        
        for i in arr{
            if i==char{
                return true
            }
        }
        return false
    }
    
    /*
     * 소수과 소수를 버리는 함수객체
     */
    var DeleteDot: String{
        let str = self
        var strArr = Array(str)
        
        if str.exist(at: "."){
            while strArr[strArr.count-1] != "." {
                strArr.remove(at: strArr.count-1)
            }
            strArr.remove(at: strArr.count-1)
        }
        
        return String(strArr)
    }
}
