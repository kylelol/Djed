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

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addButton: KKFloatingActionButton!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        addButton.setUpViews()
        addButton.tableDelegate = self
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        var attributes = [NSFontAttributeName: UIFont(name: "MYRIADPRO-REGULAR", size: 17.0)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        var string = NSMutableAttributedString(string: "STREAM", attributes: attributes)
        //let string = NSMutableAttributedString(string: "STREAM")
        string.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, string.length))
        label.attributedText = string
        label.sizeToFit()
        self.navItem.titleView = label
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didDissmissAddContact:", name: "DidDismissAddContactVCNotification", object: nil)
        //self.tableView.rowHeight = UITableViewAutomaticDimension

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        if addButton.alpha == 0.0 {
            addButton.alpha = 1.0
        }
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

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: KKFloatingActionButtonDelegate {
    func didTapCellAtIndexPath(indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("AddContactSegue", sender: nil)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.addButton.alpha = 0.0
        })
    }
}

