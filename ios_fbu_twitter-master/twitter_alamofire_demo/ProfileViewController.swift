//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mely Bohlman on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    var user: User?
    var profilePicUrl: URL?
    var bannerPicUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.current
        self.profilePicUrl = user!.profilePic
        self.bannerPicUrl = user!.bannerPic
        self.screenNameLabel.text = user!.screenName
        self.userNameLabel.text = user!.name
        self.profileImageView.af_setImage(withURL: profilePicUrl!)
        self.bannerImageView.af_setImage(withURL: bannerPicUrl!)
        self.numTweetsLabel.text = String(user!.statusCount!)+" Tweets"
        self.numFollowersLabel.text = String(user!.followerCount!)+" Followers"
        self.numFollowingLabel.text = String(user!.friendCount!)+" Following"
        profileImageView.superview?.bringSubview(toFront: profileImageView)
        
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
