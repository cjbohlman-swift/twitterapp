//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCellTableViewCell", for: indexPath) as! TweetCellTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
