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

class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var categoryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let json: CategoryListJSONParser = CategoryListJSONParser()
        json.onDecodeJSON()
        
        self.categoryTable.register(UITableViewCell.self , forCellReuseIdentifier: CELL_IDENTIFIER)
        
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
        AppDelegate().sharedAppDelegate().categoryListMgr .selectItemWithCategoryIndex(categoryIndex: item.index)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate().sharedAppDelegate().categoryListMgr.getNumberOfDisplayedList();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER)!
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: CELL_IDENTIFIER)
            //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
        }
        
        let row: Int = indexPath.row
        var categoryList: Array = AppDelegate().sharedAppDelegate().categoryListMgr .getDisplayedCategoryList()
        let item: CategoryListItem = categoryList[row] as! CategoryListItem
        
        if item.categoryType == CategoryType.CATEGORY_TYPE_BIG {
            cell.backgroundColor = UIColor.gray
        } else if item.categoryType == CategoryType.CATEGORY_TYPE_MIDEUM {
            cell.backgroundColor = UIColor.blue
        } else if item.categoryType == CategoryType.CATEGORY_TYPE_SMALL {
            cell.backgroundColor = UIColor.yellow
        }
        
        cell.textLabel?.text = item.name;
        
        
        return cell
    }
}

