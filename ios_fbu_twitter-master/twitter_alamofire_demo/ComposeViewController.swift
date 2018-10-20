//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mely Bohlman on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    weak var delegate: ComposeViewControllerDelegate?
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    var user: User!
    var profilePicUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicUrl = user.profilePic
        self.profilePicImage.af_setImage(withURL: profilePicUrl!)
        self.screenNameLabel.text = user.screenName
        self.userNameLabel.text = user.name
        tweetTextField.text = ""
        charCountLabel.text = ""
        tweetTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        charCountLabel.text = String(newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    

    @IBAction func onTapTweet(_ sender: Any) {
        APIManager.shared.compose(with: tweetTextField.text) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error tweeting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully posted the following Tweet: \n\(tweet.text)")
                self.delegate?.did(post: tweet)
                self.performSegue(withIdentifier: "ComposedTweetSegue", sender: self)
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

protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
}


