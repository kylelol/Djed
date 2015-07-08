//
//  AddContactViewController.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/2/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {
    func addDashedBorder() {
        let color = UIColor(hex: "C0C0BC").CGColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 75.0).CGPath
        
        self.layer.addSublayer(shapeLayer)
        
    }
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var rememberTextField: MKTextField!
    @IBOutlet weak var bgOverlay: SpringView!
    @IBOutlet weak var edgeView: UIView!
    @IBOutlet weak var contactImageButton: UIButton!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var addButton: MKButton!
    @IBOutlet weak var numberTextField: MKTextField!
    @IBOutlet weak var nameTextField: MKTextField!
    @IBOutlet weak var containerView: SpringView!
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.cardView.layer.cornerRadius = 5.0
        self.cardView.layer.shadowOpacity = 0.7
        self.cardView.layer.shadowRadius = 3.5
        self.cardView.layer.shadowColor = UIColor.blackColor().CGColor
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.cardView.userInteractionEnabled = true
        self.cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedContainerView:"))
        
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
        
        rememberTextField.layer.borderColor = UIColor.clearColor().CGColor
        rememberTextField.floatingPlaceholderEnabled = true
        rememberTextField.placeholder = "Enter a way to remember"
        //nameTextField.tintColor = UIColor(hex: 0x12767E, alpha: 1.0)
        rememberTextField.rippleLocation = .Right
        rememberTextField.cornerRadius = 0
        rememberTextField.bottomBorderEnabled = true
        
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSpaceForKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSpaceForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        
    
        
        self.contactImageButton.layer.cornerRadius = 75.0
        self.contactImageButton.addDashedBorder()
        
        self.bgOverlay.alpha = 0.0

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

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
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bgOverlay.alpha = 0.7
            
            
        })
        
        self.containerView.animateNext { () -> () in
            var shapePath = UIBezierPath(roundedRect: self.edgeView.bounds, byRoundingCorners: .TopRight | .BottomRight, cornerRadii: CGSizeMake(5.0, 5.0))
            
            let cornerLayer = CAShapeLayer()
            cornerLayer.frame = self.edgeView.bounds
            cornerLayer.path = shapePath.CGPath
            self.edgeView.layer.mask = cornerLayer

        }




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedContainerView(tap: UITapGestureRecognizer) {
        self.nameTextField.resignFirstResponder()
        self.numberTextField.resignFirstResponder()
        self.rememberTextField.resignFirstResponder()
    }
    
    @IBAction func didTappAddButton(sender: AnyObject) {
        
        containerView.animation = "fadeOut"
        containerView.duration = 1.0
    NSNotificationCenter.defaultCenter().postNotificationName("DidDismissAddContactVCNotification", object: nil)
        containerView.animateNext { () -> () in
            self.dismissViewControllerAnimated(false, completion: nil)

        }

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
