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
    }
    
    @IBAction func didTapAddButton(sender: AnyObject) {
        addButton.showMenu()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

