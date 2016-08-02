//
//  Tweet.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/31/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var tweetId: NSString!
    var text: NSString!
    var timestamp: NSDate!
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageURL: NSString!
    var profileName: NSString!
    var profileScreenName: NSString!
    
    init(dict:NSDictionary) {
        
        text = dict[Constants.TEXT] as! NSString
        
        retweetCount = (dict[Constants.RETWEET_COUNT] as? Int) ?? 0
        favoritesCount = (dict[Constants.FAVOURITES_COUNT] as? Int) ?? 0
        tweetId = dict[Constants.ID] as! NSString
        
        let timestampString = dict[Constants.CREATED_AT] as? String
        if let timestampString = timestampString{
            
            let formatter = NSDateFormatter()
            //Tue Aug 28 19:59:34 +0000 2012
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        let user = dict[Constants.USER] as! NSDictionary
        
        profileName = user[Constants.NAME] as! NSString
        profileScreenName = user[Constants.SNAME] as! NSString
        profileImageURL = user[Constants.IMAGE_URL] as! NSString
        
    }
    
    class func tweets(dictionaries: [NSDictionary]) -> [Tweet]{
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            
            let tweet = Tweet(dict: dictionary)
            
            tweets.append(tweet)
            
        }
        
        return tweets;
    }
    
    
}
