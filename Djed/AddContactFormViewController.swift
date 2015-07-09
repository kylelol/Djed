//
//  AddContactFormViewController.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/8/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit

class AddContactFormViewController: UIViewController {

    @IBOutlet weak var contentView: DesignableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailAddressTextField: MKTextField!
    @IBOutlet weak var phoneNumberTextField: MKTextField!
    @IBOutlet weak var wayToRememberTextField: MKTextField!
    @IBOutlet weak var lastNameTextField: MKTextField!
    @IBOutlet weak var firstNameTextField: MKTextField!
    @IBOutlet weak var profilePictureButton: DesignableButton!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    
    @IBOutlet weak var dropButton2: UIButton!
    @IBOutlet weak var dropButton1: UIButton!
    
    var textFields: [MKTextField]!
    var dropButtons: [UIButton]!
    var actionButtons: [UIButton]!
    
    var keyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textFields = [self.emailAddressTextField, self.phoneNumberTextField, wayToRememberTextField, lastNameTextField, firstNameTextField]
        dropButtons = [dropButton1, dropButton2]
        actionButtons = [cancelButton, saveButton]
        self.configureView()
        
        self.contentView.userInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTapBackground:"))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardShown {
        self.scrollView.contentOffset.y += 75
            keyboardShown = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if keyboardShown {
            self.scrollView.contentOffset.y -= 75
            keyboardShown = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.scrollView.alpha = 1.0
            
            for button in self.actionButtons {
                button.alpha = 1.0
            }
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().postNotificationName("DidDismissAddContactVCNotification", object: nil)
    }
    
    func configureView() {
        self.configureProfilePhotoButton()
        self.configureTextFields()
        //self.configureDropButtons()
        self.configureActionButtons()
        
        //self.scrollView.alpha = 0.0
    }
    
    func configureProfilePhotoButton() {
        self.profilePictureButton.addDashedBorder()
    }
    
    func configureTextFields() {
        for textField in textFields {
            textField.layer.borderColor = UIColor.clearColor().CGColor
            textField.floatingPlaceholderEnabled = true
            textField.rippleLocation = .Right
            textField.cornerRadius = 0
            textField.bottomBorderEnabled = true
            textField.delegate = self
        }
    }
    
    func configureDropButtons() {
        
        for button in dropButtons {
            button.layer.cornerRadius = 4.0
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 1
            button.layer.shadowColor = UIColor.blackColor().CGColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        }
    }
    
    func configureActionButtons() {
        
        for button in actionButtons {
            button.layer.cornerRadius = 5.0
            
            var attrString = NSMutableAttributedString(string: button.titleLabel!.text!)
            attrString.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, attrString.length))
            button.setAttributedTitle(attrString, forState: .Normal)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 1
            button.layer.shadowColor = UIColor.blackColor().CGColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            
            button.alpha = 0.0
            
        }
    }
    
    func didTapBackground(tap: UITapGestureRecognizer) {
        for field in textFields {
            field.resignFirstResponder()
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

extension AddContactFormViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.firstNameTextField {
            self.lastNameTextField.becomeFirstResponder()
        } else if textField == self.lastNameTextField {
            self.wayToRememberTextField.becomeFirstResponder()
        } else if textField == self.wayToRememberTextField {
            self.phoneNumberTextField.becomeFirstResponder()
        } else if textField == self.phoneNumberTextField {
            self.emailAddressTextField.becomeFirstResponder()
        } else if textField == self.emailAddressTextField {
            self.firstNameTextField.becomeFirstResponder()
        }
        
        return true
    }
}
