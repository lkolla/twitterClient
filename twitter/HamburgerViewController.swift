//
//  HamburgerViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 8/7/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var original: CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftMarginConstraint.constant = self.view.frame.size.width - 630
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMenuGesture(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        let velocity = sender.velocityInView(view)
        
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
