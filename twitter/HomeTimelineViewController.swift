//
//  HomeTimelineViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/1/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    let uiRefreshControl: UIRefreshControl = UIRefreshControl()

    @IBOutlet weak var menuView: UIView!
    
    var tweets: [Tweet]!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var original: CGFloat!
    
    @IBAction func onMenu(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(tableView)
        
        let velocity = sender.velocityInView(tableView)
        
        
        
        if(sender.state == UIGestureRecognizerState.Began){
        
            original = leftMarginConstraint.constant
            
        }else if (sender.state == UIGestureRecognizerState.Changed){
            
            leftMarginConstraint.constant = original + translation.x
        
        }else if (sender.state == UIGestureRecognizerState.Ended){
            
            UIView.animateWithDuration(1, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 380
                }else {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 630
                }
                self.view.layoutIfNeeded()
            })
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.leftMarginConstraint.constant = self.view.frame.size.width - 630
        
        uiRefreshControl.attributedTitle = Constants.HOME_TIMELINE_REFRESH_CONTROL_TITLE
        uiRefreshControl.addTarget(self, action:#selector(HomeTimelineViewController.reloadTweets), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(uiRefreshControl)
        
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
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destinationViewController as UIViewController;
        if( controller.isKindOfClass(TweetViewController)){
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)
            let tweet = tweets[indexPath!.row]
            let tweetViewController = segue.destinationViewController as? TweetViewController
            tweetViewController?.tweet = tweet
        }

    }
 

}
