//
//  MessageTableViewCell.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 10.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    //вот эти вопросики всё сбили
    @IBOutlet weak var senderLabel: UILabel? {
        didSet {
            senderLabel?.font = UIFont(name: Constants.listCellFont, size: 14)
            senderLabel?.textAlignment = NSTextAlignment(rawValue: 0)!
        }
    }
    @IBOutlet weak var messageLabel: UILabel? {
        didSet {
            senderLabel?.font = UIFont(name: Constants.listCellFont, size: Constants.listCellSize)
            senderLabel?.textAlignment = NSTextAlignment(rawValue: 0)!
        }
    }
    @IBOutlet weak var avatarLabel: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
