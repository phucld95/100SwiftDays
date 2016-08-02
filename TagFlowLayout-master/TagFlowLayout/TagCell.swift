//
//  TagCell.swift
//  TagFlowLayout
//
//  Created by Diep Nguyen Hoang on 7/30/15.
//  Copyright (c) 2015 CodenTrick. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.lightGrayColor()
        self.tagName.textColor = UIColor.blueColor()
//        self.layer.cornerRadius = self.frame.size.height / 2
        
        self.tagNameMaxWidthConstraint.constant = UIScreen.mainScreen().bounds.width - 8 * 2 - 8 * 2
    }
}
