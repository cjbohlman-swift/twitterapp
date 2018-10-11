//
//  TweetCellTableViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Mely Bohlman on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicImage: UIImageView!
    var profilePicUrl: URL?
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet {
            if (tweet?.retweeted == true) {
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            }
            self.profilePicUrl = tweet?.user.profilePic
            self.screenNameLabel.text = tweet?.user.screenName
            self.usernameLabel.text = tweet?.user.name
            self.timestampLabel.text = tweet?.createdAtString
            self.tweetText.text = tweet?.text
            self.profilePicImage.af_setImage(withURL: profilePicUrl!)
            self.favoriteLabel.text = String(tweet!.favoriteCount!)
            if (tweet?.favorited == true) {                favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            }
            self.retweetLabel.text = String(tweet!.retweetCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateFavoriteCount() {
        tweet?.favorited = true
        //tweet!.favoriteCount! += 1
        favoriteLabel.text = String(tweet!.favoriteCount!)
    }
    
    func updateRetweetCount() {
        tweet?.retweeted = true
        //tweet!.retweetCount += 1
        retweetLabel.text = String(tweet!.retweetCount)
    }
    
    @IBAction func onTapFavorite(_ sender: Any) {
        if (tweet?.favorited == false) {
            updateFavoriteCount()
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                }
            }
        }
    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        if (tweet?.retweeted == false) {
            updateRetweetCount()
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
                    self.retweetLabel.text = String(tweet.retweetCount)
                }
            }
        }
    }
    

}
