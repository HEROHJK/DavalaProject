//
//  ItemListBannerCell.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ItemListBannerCell: UITableViewCell {
    
    var scrollTimer:Timer?
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    public func GetWidth() -> CGFloat{
        return bannerScrollView.frame.width
    }
    
    public func GetHeight() -> CGFloat{
        return bannerScrollView.frame.height
    }
    
    public func SetWidthContentSize(value: Int){
        bannerScrollView.contentSize.width = bannerScrollView.frame.width * CGFloat(value + 1)
    }
    
    public func AddSubViewMyScrollView(imageView: UIImageView){
        bannerScrollView.addSubview(imageView)
    }
    
    @objc func RightScroll(){
        var widthSize = bannerScrollView.frame.width
        var currentOffset = bannerScrollView.contentOffset
        let maxXSize = bannerScrollView.contentSize.width
        if(currentOffset.x >= maxXSize-widthSize){
            currentOffset.x = 0
        }
        else{
            let remainder = Int(currentOffset.x) % Int(widthSize)
            if remainder != 0{
                widthSize-=CGFloat(remainder)
            }
            
            currentOffset.x += widthSize
        }
        
        bannerScrollView.contentOffset = currentOffset
    }
    
    public func TimerStart(){
        if let timer = scrollTimer {
            //timer 객체가 nil 이 아닌경우에는 invalid 상태에만 시작한다
            if !timer.isValid {
                /** 5초마다 Right함수를 호출하는 타이머 */
                scrollTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(RightScroll), userInfo: nil, repeats: true)
            }
        }else{
            //timer 객체가 nil 인 경우에 객체를 생성하고 타이머를 시작한다
            /** 5초마다 Right함수를 호출하는 타이머 */
            scrollTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(RightScroll), userInfo: nil, repeats: true)
        }
    }
    
    public func TimerEnd(){
        if let timer = scrollTimer {
            if(timer.isValid){
                timer.invalidate()
            }
        }
    }

}
