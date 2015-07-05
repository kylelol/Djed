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

    @IBOutlet weak var addButton: MKButton!
    @IBOutlet weak var numberTextField: MKTextField!
    @IBOutlet weak var nameTextField: MKTextField!
    @IBOutlet weak var containerView: SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 3.5
        containerView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.userInteractionEnabled = true
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedContainerView:"))
        
        nameTextField.layer.borderColor = UIColor.clearColor().CGColor
        nameTextField.floatingPlaceholderEnabled = true
        nameTextField.placeholder = "Name"
        //nameTextField.tintColor = UIColor(hex: 0x12767E, alpha: 1.0)
        nameTextField.rippleLocation = .Right
        nameTextField.cornerRadius = 0
        nameTextField.bottomBorderEnabled = true
        
        numberTextField.layer.borderColor = UIColor.clearColor().CGColor
        numberTextField.floatingPlaceholderEnabled = true
        numberTextField.placeholder = "Number"
        //nameTextField.tintColor = UIColor(hex: 0x12767E, alpha: 1.0)
        numberTextField.rippleLocation = .Right
        numberTextField.cornerRadius = 0
        numberTextField.bottomBorderEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSpaceForKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSpaceForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        
        addButton.layer.shadowOpacity = 0.55
        addButton.layer.shadowRadius = 3.0
        addButton.layer.shadowColor = UIColor.grayColor().CGColor
        addButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        var attrString = NSMutableAttributedString(string: "ADD")
        attrString.addAttribute(NSKernAttributeName, value: 4.0, range: NSMakeRange(0, attrString.length))
        addButton.tintColor = UIColor.whiteColor()
        addButton.setAttributedTitle(attrString, forState: .Normal)
    }
    
    func makeSpaceForKeyboard(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardHeight:CGFloat = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height - 30
        let duration:Double = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        if notification.name == UIKeyboardWillShowNotification {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                var frame = self.view.frame
                frame.size.height = frame.size.height - keyboardHeight
                self.view.frame = frame
            })
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                var frame = self.view.frame
                frame.size.height = frame.size.height + keyboardHeight
                self.view.frame = frame
            })
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        containerView.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedContainerView(tap: UITapGestureRecognizer) {
        self.nameTextField.resignFirstResponder()
        self.numberTextField.resignFirstResponder()
    }
    
    @IBAction func didTappAddButton(sender: AnyObject) {
        
        delay(0.2, { () -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("DidDismissAddContactVCNotification", object: nil)

        })
    
    }

    @IBAction func didTapCloseButton(sender: AnyObject) {
        
        containerView.animation = "fall"
        
        containerView.animateNext { () -> () in
            self.dismissViewControllerAnimated(false, completion: nil)

            
        }
        NSNotificationCenter.defaultCenter().postNotificationName("DidDismissAddContactVCNotification", object: nil)
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
