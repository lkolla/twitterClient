//
//  TwitterClient.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/31/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {

    static let client = TwitterClient(baseURL: Constants.TWITTER_API_URL,
                               consumerKey: Constants.CONSUMER_KEY, consumerSecret: Constants.CONSUMER_SECRET)
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func handleOpenURL(url: NSURL){
        
        print("URL: \(url)")
    
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath(Constants.ACCESS_TOKEN,
                                 method: Constants.POST,
                                 requestToken: requestToken,
                                 success: { (accessToken: BDBOAuth1Credential!) -> Void in
                                    
                                    self.loginSuccess?()
                                    
                                 }, failure:  { (error: NSError!) -> Void in
                                    
                                    print("Error @ handleOpenURL \(error.localizedDescription)")
                                    self.loginFailure?(error)
                                 })
        
    
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        
        deauthorize()
        
        loginFailure = failure
        loginSuccess = success
        
        print("login initiated")
        
        fetchRequestTokenWithPath(Constants.REQUEST_TOKEN,
                                  method: Constants.GET,
                                  callbackURL: NSURL(string: "twitterdemo://oauth"),
                                  scope: nil,
                                  success: { (requestToken: BDBOAuth1Credential!) -> Void in
                                    
                                    print("Inside Login after request token..")
                                    
                                    let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                                    UIApplication.sharedApplication().openURL(url)
                                    
                                    print("Inside Login after authorization token")
                                    
                                 }, failure:  { (error: NSError!) in
                                    print("error @ login \(error.localizedDescription)")
                                    self.loginFailure?(error)
                                })
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        print("Inside.. Hometimeline")
        
        
        GET(Constants.HOME_TIMELINE_URL,
            parameters: nil,
            progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                let dictionaries = response as! [NSDictionary]
                
                let tweeets = Tweet.tweets(dictionaries)
                
                success(tweeets)
                
                
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("error @ homeTimeline \(error.localizedDescription)")
                
                failure(error)
        })
    
    }
    
    func retweet(tweetId: NSString){
        
        POST("1.1/statuses/retweet/\(tweetId).json",
             parameters: nil,
             success: { (task: NSURLSessionDataTask, response: AnyObject?) in
                print("retweet response: \(response)")
        }, failure:  { (task: NSURLSessionDataTask?, error: NSError) in
                print("error while retweet \(error.localizedDescription)")
        })
    
    }
    
    func favoriteTweet(tweetId: NSString){
        
        POST("1.1/favorites/create.json?id=\(tweetId)",
             parameters: nil,
             success: { (task: NSURLSessionDataTask, response: AnyObject?) in
                print("favoriteTweet response: \(response)")
            }, failure:  { (task: NSURLSessionDataTask?, error: NSError) in
                print("error while favoriteTweet \(error.localizedDescription)")
        })
        
    }
    
    
}
