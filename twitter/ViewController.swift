//
//  ViewController.swift
//  twitter
//
//  Created by Rajesh Kolla on 7/27/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet var mainMenuView: UIView!
    

    @IBAction func menuGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        let point = sender.locationInView(menuView)
        
        if sender.state == UIGestureRecognizerState.Began {
            print ("begin.. \(point)")
        }else if sender.state == UIGestureRecognizerState.Changed {
            print ("changed.. \(point)")
        }else if sender.state == UIGestureRecognizerState.Ended {
            print ("ended.. \(point)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

