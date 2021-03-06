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
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var refc: UIRefreshControl!
    
    var loading:Bool = false
    
    var isFirst:Bool = true
    
    var categoryName = ""
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refc = UIRefreshControl()
        refc.attributedTitle = NSAttributedString(string: "새로고침 중...")
        refc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refc
        
    }
    
    func SetCategory(categoryIndex:String){
        self.appDelegate.itemList = [Item]()//아이템리스트 생성
        
        //배너 불러오기
        Alamofire.request("http://hjknas.asuscomm.com:3000/banner/list").responseSwiftyJSON { dataResponse in
            print(dataResponse.request!)
            if dataResponse != nil{
                self.appDelegate.itemList.append(MakeBannerList(Json: dataResponse.value!))
            }
        }
        
        //카테고리 URL구분
        var urlStr = ""
        if categoryIndex == ""{
            urlStr = "http://hjknas.asuscomm.com:3000/item/list"
        }
        else{
            categoryName = categoryIndex
            urlStr = "http://hjknas.asuscomm.com:3000/item/sameCategory?categoryIndex=" + categoryIndex
        }
        
        //URL불러오기
        Alamofire.request(urlStr).responseSwiftyJSON { dataResponse in
            if dataResponse.request != nil{
                self.appDelegate.itemList = MakeItemList(itemList: self.appDelegate.itemList, Json: (dataResponse.value)!)
            }
        }
        sleep(2)
        loadMoreData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func refresh(sender: AnyObject){
        loadMoreData()
        refc.endRefreshing()
        loading=false
    }
    
    //MARK: TableView
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return 250//높이 설정
        }
        else {
            return 100
        }
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
        let nextView:ProductDetailViewController = storyboard.instantiateInitialViewController() as!  ProductDetailViewController
        nextView.index = indexPath.row
        nextView.hidesBottomBarWhenPushed = true;
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func loadMoreData(){
        if isFirst{
            isFirst=false
            self.tableView.reloadData()
        }
        if categoryName == ""{
        Alamofire.request("http://hjknas.asuscomm.com:3000/item/list").responseSwiftyJSON { dataResponse in
            self.appDelegate.itemList = AddItemList(Json: dataResponse.value!, list: &self.appDelegate.itemList)
            print(dataResponse.request!)
            self.tableView.reloadData()
        }
        }
        else{
            Alamofire.request("http://hjknas.asuscomm.com:3000/item/sameCategory?categoryIndex="+categoryName).responseSwiftyJSON { dataResponse in
                if dataResponse.request != nil{
                self.appDelegate.itemList = AddItemList(Json: dataResponse.value!, list: &self.appDelegate.itemList)
                self.tableView.reloadData()
                }
        }
        
    }
        loading=false
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
}
