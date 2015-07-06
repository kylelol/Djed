//
//  FloatTableViewCell.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/2/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit

class FloatTableViewCell: UITableViewCell {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var iconView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
        self.selectionStyle = .None
        self.iconView.layer.cornerRadius = 20.0
        iconView.layer.shadowOpacity = 0.3
        iconView.layer.shadowRadius = 5.5
        iconView.layer.shadowColor = UIColor.blackColor().CGColor
        iconView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        labelView.layer.cornerRadius = 4.0
        labelView.layer.shadowOpacity = 0.3
        labelView.layer.shadowRadius = 1
        labelView.layer.shadowColor = UIColor.blackColor().CGColor
        labelView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
