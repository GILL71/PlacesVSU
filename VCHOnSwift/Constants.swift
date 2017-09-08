//
//  Constants.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 04.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

struct Constants {
    static let myColor = UIColor(red:0.44, green:0.55, blue:0.83, alpha:1.0)
    static let gradientColor1 = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 200.0 / 255.0, alpha: 1).cgColor
    static let gradientColor2 = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
    static let buttonFont = "Verdana"
    static let listCellFont = "Noteworthy"
    static let listCellSize: CGFloat = 24
    
    //var defaults = UserDefaults.standard
    static let authorizeKey = "authorize"
    static let groupOrSingleKey = "grp"
    static let modeKey = "mode"
    static let rowKey = "row"
    static let numKey = "num"
    static let groupNameKey = "groupName"
    static let currentGroupKey = "currentGroup"
    static let placeAdded = "placeAdded"
    
    enum PlaceAdded: String {
        case yes = "yes"
        case no = "no"
    }
    
    enum Authorize: String {
        case yes = "yes"
        case no = "no"
    }
    
    enum GroupOrSingle: String {
        case group = "group"
        case single = "single"
    }
    
    static func colorForName(_ color: String)-> UIColor {
        switch color {
        case "yellow":
            return UIColor.yellow
        case "white":
            return UIColor.white
        case "red":
            return UIColor.red
        case "green":
            return UIColor.green
        case "gray":
            return UIColor.gray
        case "blue":
            return UIColor.blue
        case "orange":
            return UIColor.orange
        case "purple":
            return UIColor.purple
        default:
            return UIColor.brown
        }
    }
    
    static func randomColor() -> String {
        
        switch arc4random_uniform(5) {
        case 0:
            return "yellow"
        case 1:
            return "white"
        case 2:
            return "red"
        case 3:
            return "green"
        case 4:
            return "gray"
        default:
            return "brown"
        }
    }
    
    static func colorFrom(value: Float) -> String {
        switch  value{
        case 0..<0.5:
            return "yellow"
        case 0.5..<1:
            return "white"
        case 1..<1.5:
            return "red"
        case 1.5..<2:
            return "green"
        case 2..<2.5:
            return "gray"
        case 2.5..<3:
            return "blue"
        case 3..<3.5:
            return "orange"
        case 3.5..<4:
            return "purple"
        default:
            return "brown"
        }
    }
}
