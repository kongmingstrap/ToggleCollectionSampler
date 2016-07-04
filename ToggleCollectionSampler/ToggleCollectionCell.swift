//
//  ToggleCollectionCell.swift
//  ToggleCollectionSampler
//
//  Created by tanaka.takaaki on 2016/06/29.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import UIKit

class ToggleCollectionCell: UICollectionViewCell {
    
    private var savedItem: Item?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var nameLabelCenterXLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelCenterYLayoutConstraint: NSLayoutConstraint!
    
    func configureWithItem(item: Item, cellType: CellType) {
        savedItem = item
        updateConstraintsWithCellType(cellType)
    }
    
    func updateConstraintsWithCellType(cellType: CellType) {
        
        if let item = savedItem {
            idLabel?.text = item.id
            nameLabel?.text = item.name
        }
        
        switch cellType {
        case .List:
            backgroundColor = UIColor.whiteColor()
            idLabel.textColor = UIColor.redColor()
            nameLabel.textColor = UIColor.blackColor()
            nameLabelCenterXLayoutConstraint?.constant = -100
            nameLabelCenterYLayoutConstraint?.constant = 0
            bottomView.hidden = false
        case .Grid:
            backgroundColor = UIColor.darkGrayColor()
            idLabel.textColor = UIColor.blueColor()
            nameLabel.textColor = UIColor.brownColor()
            nameLabelCenterXLayoutConstraint?.constant = 0
            nameLabelCenterYLayoutConstraint?.constant = 50
            bottomView.hidden = true
        }
    }
}
