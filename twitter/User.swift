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
    
    init(user:NSDictionary) {
        
        name = user[Constants.NAME] as! NSString
        screenName = user[Constants.SCREEN_NAME] as! NSString
        desc = user[Constants.DESCRIPTION] as! NSString
        
        let imageURL = user[Constants.IMAGE_URL] as? NSString
        if let imageURL = imageURL {
            profileImageURL = NSURL(string: imageURL as String)
        }
        
        
    }
    
}
