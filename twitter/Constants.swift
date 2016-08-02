//
//  Constants.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/30/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import Foundation

struct Constants {
    
    static let NAME = "name"
    static let DESCRIPTION = "description"
    static let SCREEN_NAME = "screen_name"
    static let IMAGE_URL = "profile_image_url_https"
    
    static let TEXT = "text"
    static let RETWEET_COUNT = "retweet_count"
    static let FAVOURITES_COUNT = "favourites_count"
    static let CREATED_AT = "created_at"
    static let ID = "id_str"
    static let USER = "user"
    static let SNAME = "screen_name"
    
    
    //Twitter API 
    static let TWITTER_API_URL = NSURL(string: "https://api.twitter.com")
    static let CONSUMER_KEY = "PirLYxB2L9U5sN9OGhcIelgA0"
    static let CONSUMER_SECRET = "ko9VCyJ8F2HeB42sLoLP6II9OAObticMXk6L7fgmvQ5oi90rtT"
    
    static let VERIFY_CREDENTIAL_URL = "1.1/account/verify_credentials.json"
    static let HOME_TIMELINE_URL = "1.1/statuses/home_timeline.json"
    static let REQUEST_TOKEN = "oauth/request_token"
    static let ACCESS_TOKEN = "oauth/access_token"
    static let AUTHORIZE_URL = "https://api.twitter.com/oauth/authorize"
    
    
    static let GET = "GET"
    static let POST = "POST"

}
