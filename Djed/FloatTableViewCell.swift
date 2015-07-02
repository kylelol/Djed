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
        iconView.layer.shadowOpacity = 0.7
        iconView.layer.shadowRadius = 3.5
        iconView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        iconView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        labelView.layer.shadowOpacity = 0.7
        labelView.layer.shadowRadius = 3.5
        labelView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        labelView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
