//
//  UIImageExtends.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import UIKit
import Swift

extension UIImage{
    /*
    * URL로 이미지를 가져오는 생성자
    */
    convenience init?(url: URL?){
        guard let url = url else {return nil}
        do{
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch{
            return nil
        }
    }
}
