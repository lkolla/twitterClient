//
//  TwitterLoginViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/1/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class TwitterLoginViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginAction(sender: AnyObject) {
        
        print("inside onlogin action")
        
        TwitterClient.client.login({
            
            print("login success.. moving to home timeline")
            
            self.performSegueWithIdentifier("loginToHomeTimeline", sender: self)
            
        }, failure:  { (error: NSError) in
            
            print("error@onLoginAction \(error.localizedDescription)")
            
        })
        
        
        
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
