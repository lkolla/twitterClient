//
//  User.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/31/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString!
    var screenName: NSString!
    var profileImageURL: NSURL!
    var desc: NSString!
    var retweetCount: NSNumber!
    var favoriteCount: NSNumber!
    
    init(user:NSDictionary) {
        
        name = user[Constants.NAME] as! NSString
        screenName = user[Constants.SCREEN_NAME] as! NSString
        desc = user[Constants.DESCRIPTION] as! NSString
        retweetCount = user["favourites_count"] as! NSNumber
        favoriteCount = user["favourites_count"] as! NSNumber
        let imageURL = user[Constants.IMAGE_URL] as? NSString
        if let imageURL = imageURL {
            profileImageURL = NSURL(string: imageURL as String)
        }
        
        
    }
    
}
