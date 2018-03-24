//
//  ItemListViewController.swift
//  DavalaProject
//
//  Created by 300만원 on 2018. 3. 6..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class ItemListViewController: UITableViewController {

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var refc: UIRefreshControl!
    
    var loading:Bool = false
    
    var isFirst:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refc = UIRefreshControl()
        refc.attributedTitle = NSAttributedString(string: "새로고침 중...")
        refc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refc
        
        Alamofire.request("http://hjknas.asuscomm.com:2323/itemlist2.php").responseSwiftyJSON { dataResponse in
            print(dataResponse.request!)
            self.appDelegate.itemList = MakeItemList(Json: dataResponse.value!)
        }
        sleep(2)
        loadMoreData()
        
    }
    
    @objc func refresh(sender: AnyObject){
        loadMoreData()
        refc.endRefreshing()
        loading=false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int)->Int{
        let count = self.appDelegate.itemList.count
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell{
        //print(self.tableView.numberOfRows(inSection: 0))
        
        if(appDelegate.itemList[indexPath.row].isBanner){
            return MakeBannerCell(index: indexPath.row)
        }
        else{
            return MakeCell(index: indexPath.row)
        }
    }
    
    func MakeCell(index:Int) -> ItemListBigCell{
        let row = self.appDelegate.itemList[index]
        let cellId = "bigCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ItemListBigCell
        
        cell.caption.text = row.name
        cell.caption.lineBreakMode = NSLineBreakMode.byWordWrapping
        if row.discount{
            cell.discountPercentage.text = row.percentage+" %"
            let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: row.price + "원")
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle,value: 2, range: NSMakeRange(0, attributedString.length))
            cell.previousDiscountPrice.attributedText=attributedString
        }
        else{
            cell.discountPercentage.text = "다발라 가격"
            cell.previousDiscountPrice.text = ""
        }
        cell.thumbNailView.image = UIImage(url: URL(string: row.url))//row.url
        cell.price.text = row.discountPrice+" 원"
        
        return cell
        
    }
    
    func MakeBannerCell(index:Int) -> ItemListBannerCell{
        
        let row = self.appDelegate.itemList[index]
        let cellId = "bannerCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ItemListBannerCell
        
        for i in 0 ..< row.BannerList.count{
            let imageView = UIImageView()
            imageView.image = UIImage(url: URL(string: row.BannerList[i].url))
            imageView.contentMode = .scaleAspectFill
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y:0, width: cell.GetWidth(), height: cell.GetHeight())
            cell.SetWidthContentSize(value: i)
            cell.AddSubViewMyScrollView(imageView: imageView)
        }
        
        cell.TimerStart()
        
        return cell
    }
    
    @IBOutlet weak var myScrollView: UIScrollView!
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return 250//높이 설정
        }
        else {
            return 100
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let lastItem = self.appDelegate.itemList.count-1
        
        if lastItem<=0 || loading { return }
        
        if(indexPath.row >= itemLoadCount-1 && indexPath.row == lastItem){
            loading=true
            loadMoreData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        
        self.present(nextView!, animated: true, completion: nil)
    }
    
    func loadMoreData(){
        if isFirst{
            isFirst=false
            self.tableView.reloadData()
        }
        
        Alamofire.request("http://hjknas.asuscomm.com:2323/itemlist2.php").responseSwiftyJSON { dataResponse in
            self.appDelegate.itemList = AddItemList(Json: dataResponse.value!, list: &self.appDelegate.itemList)
            print(dataResponse.request!)
            self.tableView.reloadData()
        }
        loading=false
    }

}
