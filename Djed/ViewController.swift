//
//  ViewController.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/1/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var addButton: KKFloatingActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        addButton.setUpViews()
        addButton.tableDelegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didDissmissAddContact:", name: "DidDismissAddContactVCNotification", object: nil)
    }
    
    @IBAction func didTapAddButton(sender: AnyObject) {
        addButton.showMenu()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didDissmissAddContact(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.addButton.alpha = 1.0
        })
    }


}

extension ViewController: KKFloatingActionButtonDelegate {
    func didTapCellAtIndexPath(indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AddContactSegue", sender: nil)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.addButton.alpha = 0.0
        })
    }
}

