//
//  LoadingTableViewCell.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 10.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.textLabel?.font = UIFont(name: Constants.listCellFont, size: Constants.listCellSize)
        self.textLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
    }
}
