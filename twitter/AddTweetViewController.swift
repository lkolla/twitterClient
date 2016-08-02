//
//  AddTweetViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/1/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import AFNetworking

class AddTweetViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var profileDisplayName: UILabel!
    
    
    @IBOutlet weak var profileScreenName: UILabel!
    
    
    @IBOutlet weak var tweetText: UITextView!
    
    
    @IBAction func onTweetAction(sender: AnyObject) {
        
        print("tweet text: \(tweetText.text)")
        
        TwitterClient.client.tweet(tweetText.text)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.client.currentUser({ (user: User) in
            self.profileImage.setImageWithURL(user.profileImageURL)
            self.profileDisplayName.text = user.name as String
            self.profileScreenName.text = user.screenName as String
        }, failure:  { (error: NSError) in
              print("error@AddTweetViewController \(error.localizedDescription)")
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
