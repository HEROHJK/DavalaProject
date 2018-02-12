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
        print("configureTableView")
        tableDS = TableDataSource(cellID: ReviewFeedCell.CELL_ID, data: listCtrl.reviewFeeds) {
            cell, model in
            cell.reviewTitle.text = model.title
            cell.reviewRegistedDate.text = model.updatedtime
            cell.reviewContent.text = model.content
            cell.reviewWriter.text = model.writer
        }
        
        tableDelegate = TableDelegate(listDelegate: self)
        
        reviewFeedTable.dataSource = tableDS
        reviewFeedTable.delegate = tableDelegate
        reviewFeedTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass selected athlete object to details page
        if segue.identifier == DETAILS_SEQUE {
            let index = sender as! Int
            let detailsVC = segue.destination as! ReviewFeedDetailViewController
//            detailsVC.stateCtrl = AthleteDetailsStateController(athlete: stateCtrl.athletes[index])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- List Views Delegate Methods
extension ReviewFeedViewController: ListViewsDelegate {
    func didSelectItemAt(index: Int) {
        self.performSegue(withIdentifier: DETAILS_SEQUE, sender: index)
    }
}
