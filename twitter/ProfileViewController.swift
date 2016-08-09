//
//  ProfileViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/8/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileScreenName: UILabel!
    
    @IBOutlet weak var profileCaption: UILabel!
    
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let uiRefreshControl: UIRefreshControl = UIRefreshControl()
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        uiRefreshControl.attributedTitle = Constants.HOME_TIMELINE_REFRESH_CONTROL_TITLE
        uiRefreshControl.addTarget(self, action:#selector(ProfileViewController.reloadTweets), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(uiRefreshControl)
        
        TwitterClient.client.currentUser({ (user: User) in
            self.profileImage.setImageWithURL(user.profileImageURL)
            self.profileName.text = user.name as String
            self.profileScreenName.text = user.screenName as String
            self.profileCaption.text = user.desc as String
            self.tweetCount.text = user.retweetCount.stringValue
            self.favoriteCount.text = user.favoriteCount.stringValue
            
            }, failure:  { (error: NSError) in
                print("error@AddTweetViewController \(error.localizedDescription)")
        })
        
        loadTweets()

    }
    
    func reloadTweets(){
        
        print ("inside re-load tweets.")
        
        loadTweets()
        
        self.uiRefreshControl.endRefreshing()
    }
    
    func loadTweets () {
        
        TwitterClient.client.homeTimeline({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) in
            print("error: \(error.localizedDescription)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.tweets != nil){
            return self.tweets.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
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
