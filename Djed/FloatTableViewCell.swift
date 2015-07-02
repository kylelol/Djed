//
//  FloatTableViewCell.swift
//  Djed
//
//  Created by Kyle Kirkland on 7/2/15.
//  Copyright (c) 2015 Kyle Kirkland. All rights reserved.
//

import UIKit

class FloatTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
        self.selectionStyle = .None
        self.iconView.layer.cornerRadius = 15.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
