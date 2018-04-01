//
//  ReviewFeedViewController.swift
//  DavalaProject
//
//  Created by 이승철 on 2018. 1. 25..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

class ReviewFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reviewFeedTable: UITableView!
    
    var listCtrl: ReviewFeedListController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listCtrl = ReviewFeedListController()
        self.reviewFeedTable.delegate = self
        self.reviewFeedTable.dataSource = self
        listCtrl.getReviewFeedList { (error: String?) in
            guard error != nil else {
                print("getReviewFeedList")
                self.reviewFeedTable.reloadData()
                return
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ReviewFeedDetail", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        
        self.present(nextView!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return listCtrl.reviewFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewFeedCell") as! ReviewFeedCell
        let model = listCtrl.reviewFeeds[indexPath.row]
        cell.reviewTitle.text = model.title
        cell.reviewRegistedDate.text = model.updatedtime
        cell.reviewContent.text = model.content
        cell.reviewWriter.text = model.writer
        let url = URL(string: model.imageurl!)
        let data = try? Data(contentsOf: url!)
        cell.reviewThumbnail.image = UIImage(data: data!)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


