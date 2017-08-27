//
//  RightSector.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 15.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Foundation

class RightSector {
    
    var places = [Place]()
    let width = 38
    let height = 18
    
    init() {
        var field = [Place]()
        var limitation = [Place]()
        let wLimit = 2
        let hLimit = 3
        var lim = false
        for i in 0..<height {
            for j in 0..<width {
                let p = Place.init(row: i, num: j)
                field.append(p)
            }
        }
        for i in 0..<hLimit {
            for j in 0..<wLimit {
                let pL = Place.init(row: i, num: j)
                limitation.append(pL)
            }
        }
        limitation.append(Place.init(row: 3, num: 0))
        limitation.append(Place.init(row: 4, num: 0))
        limitation.append(Place.init(row: 5, num: 0))
        
        var shiftNum = Array(repeating: 0, count: width*height)
        
        for p in field {
            for l in limitation {
                if p.isPlaceEqualTo(place: l) {
                    lim = true
                }
            }
            if !lim {
                p.num -= shiftNum[p.row] - 1
                places.append(p)
            } else {
                shiftNum[p.row] += 1
            }
            lim = false
        }
    }
}
