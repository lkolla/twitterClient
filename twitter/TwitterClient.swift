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
        
        let params: NSDictionary = ["count":200]
        
        GET(Constants.HOME_TIMELINE_URL,
            parameters: params,
            progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                print("response from home timeline \(response)")
                
                let dictionaries = response as! [NSDictionary]
                
                let tweeets = Tweet.tweets(dictionaries)
                
                success(tweeets)
                
                
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("error @ homeTimeline \(error.localizedDescription)")
                
                failure(error)
        })
    
    }
    
    func currentUser(success: (User) -> (), failure: (NSError) -> ()){
        
        print("Inside.. current user")
        
        
        GET(Constants.VERIFY_CREDENTIAL_URL,
            parameters: nil,
            progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                let userDict = response as! NSDictionary
                
                let user = User(user: userDict)
                
                success(user)
                
                
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("error @ currentUser \(error.localizedDescription)")
                
                failure(error)
        })
        
    }
   
    func tweet(tweet: NSString){
        
        print("tweet text in tweet: \(tweet)")
        
        let params: NSDictionary = ["status":tweet]
        
        POST("1.1/statuses/update.json",
             parameters: params,
             success: { (task: NSURLSessionDataTask, response: AnyObject?) in
                print("retweet response: \(response)")
            }, failure:  { (task: NSURLSessionDataTask?, error: NSError) in
                print("error while retweet \(error.localizedDescription)")
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
