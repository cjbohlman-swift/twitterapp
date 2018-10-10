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
    
    var tweet: Tweet? {
        didSet {
            self.profilePicUrl = tweet?.user.profilePic
            self.screenNameLabel.text = tweet?.user.screenName
            self.usernameLabel.text = tweet?.user.name
            self.timestampLabel.text = tweet?.createdAtString
            self.tweetText.text = tweet?.text
            self.profilePicImage.af_setImage(withURL: profilePicUrl!)
        
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

}
