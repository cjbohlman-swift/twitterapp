//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mely Bohlman on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var profilePicUrl: URL?
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (tweet?.retweeted == true) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        } else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
        if (tweet!.favorited == true) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        self.profilePicUrl = tweet!.user.profilePic
        self.screenNameLabel.text = tweet!.user.screenName
        self.userNameLabel.text = tweet!.user.name
        self.timestampLabel.text = tweet!.createdAtString
        self.tweetTextLabel.text = tweet!.text
        self.profilePicImage.af_setImage(withURL: profilePicUrl!)
        self.favoriteButton.setTitle(String(tweet!.favoriteCount!), for: .normal)
        self.retweetButton.setTitle(String(tweet!.retweetCount), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapFavorite(_ sender: Any) {
        if (tweet?.favorited == false) {
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    //self.homeTimeline?.completeNetworkRequest()
                }
            }
        } else {
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    //self.homeTimeline?.completeNetworkRequest()
                }
            }
        }
    }
    

    @IBAction func onTapRetweet(_ sender: Any) {
        if (tweet?.retweeted == false) {
            // tweet?.retweeted = true
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    //self.homeTimeline?.completeNetworkRequest()
                }
            }
        } else {
            tweet?.retweeted = false
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    //self.homeTimeline?.completeNetworkRequest()
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
