//
//  Tweet.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/31/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import AFNetworking

class Tweet: NSObject {
    
    var tweetId: NSString!
    var text: NSString!
    var timestamp: NSDate!
    var processedTimestamp: NSString!
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageURL: NSString!
    var profileName: NSString!
    var profileScreenName: NSString!
    var tweetImageURL: NSString!
    
    
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
            
            let timeInterval = -Int(timestamp.timeIntervalSinceNow)
            
            if timeInterval < 60 {
                processedTimestamp = "\(timeInterval)s ago"
            } else if timeInterval < 3600 {
                let mins = timeInterval / 60
                processedTimestamp = "\(mins)m ago"
            } else if timeInterval < 86400 {
                let hours = (timeInterval / 60) / 60
                processedTimestamp = "\(hours)h ago"
            } else {
                let days = ((timeInterval / 60) / 60) / 24
                processedTimestamp = "\(days)d ago"
            }
            
        }
        
        

        
        
        
        let user = dict[Constants.USER] as! NSDictionary
        
        profileName = user[Constants.NAME] as! NSString
        profileScreenName = user[Constants.SNAME] as! NSString
        profileImageURL = user[Constants.IMAGE_URL] as! NSString
        
        
        let entities = dict["entities"] as! NSDictionary
        
        if  entities["media"] != nil {
            let media = entities["media"] as! NSArray
            
            let m = media.firstObject as! NSDictionary
            
            print ("https URL: \(m["media_url_https"])")
            
            tweetImageURL = m["media_url_https"] as! NSString
        }
        
        
        
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
