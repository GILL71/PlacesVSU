//
//  Parser.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 03.06.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct Parser {
    
    func parseFriends(json: [String:Any], numberOfFriends: Int) -> [Viewer] {
        var friendsReturn = [Viewer]()
        guard let friends = json["items"] as? [Any] else {
            return [Viewer]()
        }
        for i in 0..<numberOfFriends {
            guard let friend = friends[i] as? [String: Any] else {
                print("parse troubles on friend block")
                return [Viewer]()
            }
            guard let first_name = friend["first_name"] as? String else {
                print("parse troubles on first_name block")
                return [Viewer]()
            }
            guard let last_name = friend["last_name"] as? String else {
                print("parse troubles on last_name block")
                return [Viewer]()
            }
            if let photo = friend["photo_200"] as? String {
                let f = Viewer(first_name: first_name, last_name: last_name, imageURL: photo)
                friendsReturn.append(f)
            } else {
                let f = Viewer(first_name: first_name, last_name: last_name, imageURL: "https://pp.userapi.com/c630826/v630826134/276e1/cCcwmFLI2B0.jpg")
                friendsReturn.append(f)
            }
        }
        return friendsReturn
    }
    
    func parseMessages(json: [String:Any], numberOfMessages: Int) -> [String] {
        print(json)
        var messages = [String]()
        guard let items = json["items"] as? [Any] else {
            print("parse troubles on items block")
            return [String]()
        }
        
        for i in 0..<numberOfMessages {
            guard let item = items[i] as? [String: Any] else {
                print("parse troubles on item block")
                return [String]()
            }
            guard let body = item["body"] as? String else {
                print("parse troubles on body block")
                return [String]()
            }
            messages.append(body)
        }
        return messages
    }
}
