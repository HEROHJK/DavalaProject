//
//  ProductDetailViewController.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 8..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ProductDetailViewModel?
    
    override func viewDidLoad() {
        print("ProductDetailViewController viewDidLoad")
        super.viewDidLoad()
        self.viewModel = ProductDetailViewModel()
    }
    
    
}
