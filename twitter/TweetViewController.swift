//
//  TweetViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/1/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import AFNetworking

class TweetViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var profileImageURL: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileScreenName: UILabel!
    
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoritesCount: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    let retweetUnselect = UIImage(named: "retweet-unselected") as UIImage!
    
    @IBOutlet weak var tweetImageURL: UIImageView!
    
    ///trainings/ios/twitter/twitter/Assets.xcassets/retweet-selected.imageset/retweet-selected.png
    ///trainings/ios/twitter/twitter/Assets.xcassets/retweet-unselected.imageset/retweet-unselected.jpeg
    
    @IBOutlet weak var replyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //retweetButton.setImage(retweetUnselect, forState: UIControlState.Normal)
        //retweetButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFill

        
        profileImageURL.setImageWithURL(NSURL(string: tweet.profileImageURL as String)!)
        profileName.text = tweet.profileName as String
        profileScreenName.text = tweet.profileScreenName as String
        tweetText.text = tweet.text as String
        retweetCount.text = String (tweet.retweetCount)
        favoritesCount.text = String(tweet.favoritesCount)
        if tweet.tweetImageURL != nil {
            tweetImageURL.setImageWithURL(NSURL(string: tweet.tweetImageURL as String)!)
        }else{
            tweetImageURL.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.client.retweet(tweet.tweetId)
    }
    

    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.client.favoriteTweet(tweet.tweetId)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
