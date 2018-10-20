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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
