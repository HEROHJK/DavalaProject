//
//  ProductDetailViewController+TableView.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 8..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import UIKit

extension ProductDetailViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        var numberOfRow = 0
        switch section {
        case 0:
            numberOfRow = 3
            break
        case 1:
            numberOfRow = 1
            break
        case 2:
            numberOfRow = 3
            break
        case 3:
            numberOfRow = 1
            break
        case 4:
            numberOfRow = 1
            break
        case 5:
            numberOfRow = 1
        default:
            break
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        var cell:ProductDetailTableViewCell!
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTimeCell") as! ProductDetailTableViewCell
                
                break
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailImageCell") as! ProductDetailTableViewCell
                break
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleCell") as! ProductDetailTableViewCell
                break
            default :
                break
            }
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBrandCell") as! ProductDetailTableViewCell
            break
        case 2:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailGradeCell") as! ProductDetailTableViewCell
                break
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailReviewImagesCell") as! ProductDetailTableViewCell
                break
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBestReviewCell") as! ProductDetailTableViewCell
                break
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailAllReviewCell") as! ProductDetailTableViewCell
                break
            default :
                break
            }
            break
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInforCell") as! ProductDetailTableViewCell
            
            break
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailShipInforCell") as! ProductDetailTableViewCell
            break
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailOtherCell") as! ProductDetailTableViewCell
            break
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow:CGFloat = 0
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                heightForRow = 44
                break
            case 1:
                heightForRow = 300
                break
            case 2:
                heightForRow = 160
                break
            default :
                break
            }
            break
        case 1:
            heightForRow = 44
            break
        case 2:
            switch indexPath.row {
            case 0:
                heightForRow = 44
                break
            case 1:
                heightForRow = 160
                break
            case 2:
                heightForRow = 150
                break
            case 3:
                heightForRow = 44
                break
            default :
                break
            }
            break
        case 3:
            heightForRow = 300
            break
        case 4:
            heightForRow = 44
            break
        case 5:
            heightForRow = 220
            break
        default:
            break
        }
        
        return heightForRow
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let width:CGFloat = tableView.frame.width
        let height:CGFloat = 1
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}
