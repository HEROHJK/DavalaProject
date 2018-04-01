//
//  ReviewFeedViewController.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 1. 25..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ReviewFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ReviewFeedDetail", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        self.present(nextView!, animated: true, completion: nil)
    }
    
    
    func configureTableView() {
        print("configureTableView")
        tableDS = TableDataSource(cellID: ReviewFeedCell.CELL_ID, data: listCtrl.reviewFeeds) {
            cell, model in
            cell.reviewTitle.text = model.title
            cell.reviewRegistedDate.text = model.updatedtime
            cell.reviewContent.text = model.content
            cell.reviewWriter.text = model.writer
            let url = URL(string: model.imageurl!)
            let data = try? Data(contentsOf: url!)
            cell.reviewThumbnail.image = UIImage(data: data!)
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

