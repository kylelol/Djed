//
//  AddContactViewController.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/2/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit
import QuartzCore

class AddContactViewController: UIViewController {

    @IBOutlet weak var containerView: SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 3.5
        containerView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        containerView.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapCloseButton(sender: AnyObject) {
        
        containerView.animation = "fall"
        containerView.animateNext { () -> () in
            self.dismissViewControllerAnimated(false, completion: nil)
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
