//
//  GroupTableViewCell.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 08.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 1
            //font
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
