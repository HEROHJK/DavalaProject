//
//  ReviewFeedViewController.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 1. 25..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ReviewFeedViewController: UIViewController {
    
    @IBOutlet weak var reviewFeedTable: UITableView!
    
    var listCtrl: ReviewFeedListController!
    var tableDS: TableDataSource<ReviewFeedCell, ReviewFeedData>!
    var tableDelegate: TableDelegate!
    
    let DETAILS_SEQUE = "fromHomeToDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listCtrl = ReviewFeedListController()
        
        listCtrl.getReviewFeedList { (error: String?) in
            
            guard let errorMsg = error else {
                print("getReviewFeedList")
                self.configureTableView()
                return
            }
            
        }
    }
    
    func configureTableView() {
        tableDS = TableDataSource(cellID: ReviewFeedCell.CELL_ID, data: listCtrl.reviewFeeds) {
            cell, model in
            
            cell.reviewTitle.text = model.subject
        }
        
        tableDelegate = TableDelegate(listDelegate: self)
        
        reviewFeedTable.dataSource = tableDS
        reviewFeedTable.delegate = tableDelegate
        reviewFeedTable.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- List Views Delegate Methods
extension ReviewFeedViewController: ListViewsDelegate{
    func didSelectItemAt(index: Int) {
        self.performSegue(withIdentifier: DETAILS_SEQUE, sender: index)
    }
}
