//
//  CentralSector.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 15.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Foundation

class CentralSector {
    var places = [Place]()
    let width = 25
    let height = 18
    
    //чтобы ориентироваться на левый сектор, нужно иметь ссылку на него и 
    init() {
        
        for i in 0..<18 {
            for j in 9..<32 {
                places.append(Place.init(row: i, num: j))
            }
        }
        
    }
}
