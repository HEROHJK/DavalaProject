//
//  ReviewFeedCell.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 1. 25..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ReviewFeedCell: UITableViewCell {
    static let CELL_ID: String = "reviewFeedCell"
    @IBOutlet var reviewTitle: UILabel!         // 리뷰 제목
    @IBOutlet var reviewRegistedDate: UILabel!  // 리뷰 등록일
    @IBOutlet var reviewThumbnail: UIImageView! // 리뷰 썸네일
    @IBOutlet var reviewContent: UILabel!       // 리뷰 내용
    @IBOutlet var reviewWriter: UILabel!        // 리뷰 작성자
    @IBOutlet var reviewLike: UILabel!          // 리뷰 좋아요
    

}
