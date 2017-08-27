//
//  SliderTableViewCell.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 08.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sliderView: UISlider! {
        didSet {
            sliderView.clipsToBounds = true
            sliderView.value = 3.9
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

