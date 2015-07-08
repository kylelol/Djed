//
//  KKFloatingActionButton.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/1/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit

protocol KKFloatingActionButtonDelegate: class {
    func didTapCellAtIndexPath(indexPath: NSIndexPath)
}

class KKFloatingActionButton: UIView {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    @IBOutlet weak var button: MKButton!
    @IBOutlet weak var imageView: UIImageView!
    weak var scrollView: UIScrollView?
    weak var tableDelegate: KKFloatingActionButtonDelegate?
    var bgView: UIView?
    var windowView: UIView?
    var isMenuVisible = false
    var mainWindow: UIWindow? {
        return UIApplication.sharedApplication().keyWindow
    }
    var menuTable : UITableView?
    
    func setUpViews() {
        
        windowView = UIView(frame: UIScreen.mainScreen().bounds)
        
        bgView = UIView(frame: UIScreen.mainScreen().bounds)
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.userInteractionEnabled = true
        bgView?.alpha = 0
        bgView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTapBgView:"))
        
        menuTable = UITableView(frame: CGRect(x: screenWidth/4, y: screenHeight - (5*70), width: 0.75*screenWidth, height: 5*70))
        menuTable?.scrollEnabled = false
        menuTable?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth/2, height: 80))
        
        menuTable?.registerNib(UINib(nibName: "FloatingTableViewCell", bundle: nil), forCellReuseIdentifier: "FloatCell")
        menuTable?.dataSource = self
        menuTable?.delegate = self
        menuTable?.backgroundColor = UIColor.clearColor()
        menuTable?.separatorStyle = UITableViewCellSeparatorStyle.None
        menuTable!.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
        
        button.cornerRadius = 25.0
        button.backgroundLayerCornerRadius = 25.0
        button.maskEnabled = false
        button.ripplePercent = 1.75
        button.rippleLocation = .Center
        
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 7
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        
        //bgView?.addSubview(menuTable!)
        
        
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
        self.showMenu()
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        self.showMenu()
    }
    
    func didTapBgView(sender: AnyObject) {
        self.showMenu()
    }
    
    func dismissMenu() {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.menuTable?.alpha = 0.0
            //self.bgView?.alpha = 0
            self.imageView.transform = CGAffineTransformIdentity
            
        }) { (success) -> Void in
            self.bgView?.removeFromSuperview()
            self.windowView?.removeFromSuperview()
           // self.removeFromSuperview()
            self.mainWindow?.removeFromSuperview()
        }
    }
    
    func showMenu() {
        
        if isMenuVisible {
            
            //self.backgroundColor = UIColor(hex: 0x12767E, alpha: 1.0)
            //self.setTitle("+", forState: .Normal)
           // self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.dismissMenu()
            
        } else {
            
            //self.backgroundColor = UIColor.whiteColor()
            //self.setTitle("X", forState: .Normal)
            //self.setTitleColor(UIColor(hex: 0x12767E, alpha: 1.0), forState: .Normal)
            menuTable?.alpha = 1.0
            windowView!.addSubview(bgView!)
            windowView?.addSubview(menuTable!)
            mainWindow!.insertSubview(windowView!, belowSubview: self)
            mainWindow?.addSubview(self)
            menuTable?.reloadData()
            presentMenu()
            
        }
        
        isMenuVisible = !isMenuVisible
    }
    
    private func presentMenu() {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.bgView?.alpha = 0.7
            self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI + -M_PI_4))
        })
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension KKFloatingActionButton: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var delay = Double((indexPath.row * indexPath.row)) * 0.004
        
        let translation = -(indexPath.row + 1) * 50
        
        var scaleTransform = CGAffineTransformMakeScale(0.95, 0.95)
        var tranlationTransform = CGAffineTransformMakeTranslation(0, CGFloat(translation))
        
        cell.transform = CGAffineTransformConcat(scaleTransform, tranlationTransform)
        cell.alpha = 0.0
        
        UIView.animateWithDuration(0.20, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            cell.transform = CGAffineTransformIdentity
            cell.alpha = 1.0
        }, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableDelegate?.didTapCellAtIndexPath(indexPath)
        self.showMenu()
    }
    
}

extension KKFloatingActionButton: UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FloatCell") as! FloatTableViewCell
        
        let data = dataForIndexPath(indexPath)
        
        var attrString = NSMutableAttributedString(string: data.0)
        attrString.addAttribute(NSKernAttributeName, value: 2.0, range: NSMakeRange(0, attrString.length))
        cell.iconLabel.attributedText = attrString
        cell.iconImageView.image = UIImage(named: data.1)
        

        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    private func dataForIndexPath(indexPath: NSIndexPath) -> (String, String) {
        
        switch indexPath.row {
        case 0: return ("CONTACT", "contactImage")
        case 1: return ("EVENT", "eventImage")
        case 2: return ("ALBUM", "albumImage")
        case 3: return ("LIST", "listImage")
        default: return ("", "")
        }
    }
}
