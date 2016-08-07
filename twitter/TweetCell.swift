//
//  TweetCell.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/1/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var tweetImage: UIImageView!
    
    @IBOutlet weak var userDisplayName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetTimestamp: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    
    var tweet: Tweet!{
        //following closure will be used to set the businesscell's properties.
        didSet{
            
            tweetImage.setImageWithURL(NSURL(string:tweet.profileImageURL as String)!)
            userDisplayName.text = tweet.profileName as String
            userName.text = tweet.profileScreenName as String
            tweetText.text = tweet.text as String
            tweetTimestamp.text = tweet.processedTimestamp as String
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
