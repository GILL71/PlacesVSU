//
//  CustomButton.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 16.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = UIColor.orange
        let disabledColor = color.withAlphaComponent(0.3)
        
        let gradientColor1 = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1).cgColor
        let gradientColor2 = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        
        let btnFont = "Verdana"
        let bthWidth = 20
        let btnHeight = 20
        //TODO: Code for our button
        self.frame.size = CGSize(width: bthWidth, height: btnHeight)
        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        self.titleLabel?.font = UIFont(name: btnFont, size: 9)
        self.titleLabel?.adjustsFontSizeToFitWidth = true

        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        self.layer.insertSublayer(btnGradient, at: 0)
    }
}
