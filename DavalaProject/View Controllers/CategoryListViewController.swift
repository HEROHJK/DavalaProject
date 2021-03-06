//
//  CategoryListViewController.swift
//  DavalaProject
//
//  Created by HwanYong Kim on 2018. 3. 5..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import Foundation
import UIKit

let CELL_IDENTIFIER: String = "cell_identifier"
let ITEM_LIST_VIEW_CONTROLLER: String = "ItemListViewController"

class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var categoryTable: UITableView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.categoryTable.register(UITableViewCell.self , forCellReuseIdentifier: CELL_IDENTIFIER)
        NotificationCenter.default.addObserver(self, selector: #selector(onReceivedFinishedParsing), name: NSNotification.Name(rawValue: NOTIFICATION_FINISH_CATEGORY_PARSING), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.categoryTable .reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.stopLoading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopLoading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row: Int = indexPath.row
        var cateroryList: Array = AppDelegate().sharedAppDelegate().categoryListMgr .getDisplayedCategoryList()
        let item: CategoryListItem = cateroryList[row] as! CategoryListItem
        
        let subcategoryItems: Array = AppDelegate().sharedAppDelegate().categoryListMgr.getItemsWithSubCategoryIndex(categoryIndex: item.index)
        
        if subcategoryItems.count == 0 {
            let itemListStoryBoard: UIStoryboard = UIStoryboard(name: "ItemList", bundle: nil)
            let privateViewController:ItemListViewController = itemListStoryBoard.instantiateViewController(withIdentifier: ITEM_LIST_VIEW_CONTROLLER) as! ItemListViewController
            if privateViewController != nil {
                self.startLoading()
                privateViewController.SetCategory(categoryIndex:String(item.index))
                self.navigationController?.pushViewController(privateViewController, animated: true)
            }
        } else {
            let temp: Bool = AppDelegate().sharedAppDelegate().categoryListMgr .selectItemWithCategoryIndex(categoryIndex: item.index)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate().sharedAppDelegate().categoryListMgr.getNumberOfDisplayedList();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER)!
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: CELL_IDENTIFIER)
        }
        
        let row: Int = indexPath.row
        var categoryList: Array = AppDelegate().sharedAppDelegate().categoryListMgr .getDisplayedCategoryList()
        let item: CategoryListItem = categoryList[row] as! CategoryListItem
        
        let bottomLine: UIView = UIView()
        cell.addSubview(bottomLine)
        bottomLine.frame = CGRect(x:0, y:cell.frame.size.height - 1 , width:cell.frame.size.width, height:1)
        bottomLine.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.85)
        
        let textInset = 20 * (self.view.frame.size.width/360.0)
        var cellLabelFrame = cell.textLabel?.frame
        if item.categoryType == CategoryType.CATEGORY_TYPE_BIG {
            cell.backgroundColor = UIColor.white
        } else if item.categoryType == CategoryType.CATEGORY_TYPE_MIDEUM {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)
            cellLabelFrame?.origin.x += textInset
            cell.textLabel?.frame = cellLabelFrame!
        } else if item.categoryType == CategoryType.CATEGORY_TYPE_SMALL {
            cell.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.7)
            cellLabelFrame?.origin.x += textInset*2
            cell.textLabel?.frame = cellLabelFrame!
        }
        
        cell.textLabel?.text = item.name;
        
        return cell
    }
    
    @objc func onReceivedFinishedParsing() {
        self.categoryTable .reloadData()
    }
    
    func stopLoading() {
        self.loadingView.isHidden = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func startLoading() {
        self.loadingView.isHidden = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
}

