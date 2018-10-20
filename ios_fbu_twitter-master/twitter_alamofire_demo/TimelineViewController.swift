//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate {
    
    func did(post: Tweet) {
        completeNetworkRequest()
    }
    
    var tweets: [Tweet] = []
    var refreshControl:UIRefreshControl!

    @IBOutlet weak var tweetTableView: UITableView!
    
    override func viewDidLoad() {
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 120
        super.viewDidLoad()
        completeNetworkRequest()
        tweetTableView.reloadData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_:)), for: .valueChanged)
        tweetTableView.insertSubview(refreshControl, at: 0)

        // Do any additional setup after loading the view
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        completeNetworkRequest()
            tweetTableView.reloadData()
            refreshControl.endRefreshing()
        }
    
    func completeNetworkRequest() {
        APIManager.shared.getHomeTimeLine { (tweet, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweet!
                self.tweetTableView.reloadData()
            }
        }
        
        // stop refreshing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.homeTimeline = self as TimelineViewController
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailSegue") {
            let cell = sender as! TweetCell
            let detailViewController = segue.destination as! DetailViewController
            if let indexPath = tweetTableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                detailViewController.tweet = tweet
            }
        } else if (segue.identifier == "ComposeSegue") {
            let composeVC = segue.destination as! ComposeViewController
            composeVC.delegate = self
            composeVC.user = User.current
        }
        
    }
    

}
