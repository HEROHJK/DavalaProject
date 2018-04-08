//
//  ProductDetailViewController.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 8..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ProductDetailViewModel = ProductDetailViewModel()
    var index: Int = -1
    
    override func viewDidLoad() {
        print("ProductDetailViewController viewDidLoad")
        super.viewDidLoad()
        
        self.index = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var array:NSMutableArray = NSMutableArray()
        var error:Error?
        WebServiceManager.sharedInstance.getBannerList(success: { (array) in
            
        }) { (error) in
            
        }
        //WebServiceManager.sharedInstance.getBannerList(success: { (data: Dictionary) in debugPrint(data) }, fail: { (error: Error?) in print(error) })
    }
}
