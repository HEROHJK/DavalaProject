//
//  ProductDetailTableViewCell.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 10..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    // MARK: ProductDetailTimeCell
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: ProductDetailImageCell
    
    // MARK: ProductDetailTitleCell
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var ShipConditionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: ProductDetailBrandCell
    
    // MARK: ProductDetailGradeCell
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeCountLabel: UILabel!
    
    // MARK: ProductDetailReviewImagesCell
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    // MARK: ProductDetailBestReviewCell
    @IBOutlet weak var bRWriterLabel: UILabel!
    @IBOutlet weak var bRDateLabel: UILabel!
    @IBOutlet weak var bRrecommendCountLabel: UILabel!
    @IBOutlet weak var bRProductLabel: UILabel!
    @IBOutlet weak var bRContentLabel: UILabel!
    
    
    // MARK: ProductDetailAllReviewCell
    
    // MARK: ProductDetailInforCell
    
    // MARK: ProductDetailShipInforCell
    
    // MARK: ProductDetailOtherCell
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
