//
//  FriendTableViewCell.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 09.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.init(name: Constants.listCellFont, size: Constants.listCellSize)
            nameLabel.textAlignment = NSTextAlignment(rawValue: 0)!
        }
    }
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
