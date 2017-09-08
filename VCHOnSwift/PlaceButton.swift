//
//  PlaceButton.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 05.09.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class PlaceButton: UIButton {

    var place: Place
    dynamic var pressed = false
    
    required init(place: Place) {
        self.place = place
        
        super.init(frame: CGRect(x: 20*place.x + 98, y: 20*place.y + 128, width: 20, height: 20))
        
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont(name: "Verdana", size: 11)
        self.titleLabel?.textColor = UIColor.orange
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
        self.setTitle("\(place.num)", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
