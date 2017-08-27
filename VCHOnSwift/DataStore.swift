//
//  DataStore.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 26.08.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Foundation
import RealmSwift

struct Viewer {
    var first_name: String
    var last_name: String
    var imageURL: String
}

class RealmViewer: Object {
    dynamic var first_name = ""
    dynamic var last_name = ""
    dynamic var imageURL = ""
    
    override static func primaryKey() -> String? {
        return "imageURL"
    }
    
    convenience init(_ viewer: Viewer) {
        self.init()
        first_name = viewer.first_name
        last_name = viewer.last_name
        imageURL = viewer.imageURL
    }
    
    var entity: Viewer {
        return Viewer(first_name: first_name,
                      last_name: last_name,
                      imageURL: imageURL)
    }
}

class ViewerRealmDataSource: DataSource {
    func update(by id: String, with name: String) {
        <#code#>
    }
    
    typealias T = Viewer
    private let realm = try! Realm()
    
    func getAll() -> [T] {
        return realm.objects(RealmViewer.self).map {$0.entity}
    }
    func getById(id: String) -> T {
        return Viewer(first_name: "", last_name: "", imageURL: "")
    }
    func insert(item: T) {
        try! realm.write {
            realm.add(RealmViewer(item))
        }
    }
    //func update(by id: String, with first_name: String, last_name: String) {
    //    try! realm.write {
    //        let predicate = NSPredicate(format: "imageURL = %@", id)
    //        let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
    //        targetViewer[0].first_name = first_name
    //        targetViewer[0].last_name = last_name
    //    }
    //}
    func clean() {
        try! realm.write {
            realm.delete(realm.objects(RealmViewer.self))
        }
    }
    func delete(item: T) {
        //realm.delete(RealmRecord(item))
    }
    func deleteById(id: String) {
        try! realm.write {
            let predicate = NSPredicate(format: "imageURL = %@", id)
            let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
            realm.delete(targetViewer)
        }
    }
    func checkBy(first_name: String) -> Bool {
        let predicate = NSPredicate(format: "first_name = %@", first_name)
        let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
        if targetViewer.count == 0 {
            return false
        }
        return true
    }
}

// MARK: - PlaceEntity

struct Place {
    var row: Int
    var num: Int
    var x: Int {
        return row
    }
    var y: Int {
        return num
    }
}

class RealmPlace: Object {
    dynamic var row = 0
    dynamic var num = 0
    var x: Int {
        return row
    }
    var y: Int {
        return num
    }
    
    convenience init(_ place: Place) {
        self.init()
        row = place.row
        num = place.num
    }
    
    var entity: Place {
        return Place(row: row, num: num)
    }
}

class PlaceRealmDataSource: DataSource {
    func update(by id: String, with name: String) {
        <#code#>
    }
    
    typealias T = Place
    private let realm = try! Realm()
    
    func getAll() -> [T] {
        return realm.objects(RealmPlace.self).map {$0.entity}
    }
    func getById(id: String) -> T {
        return Place(row: 0, num: 0)
    }
    func insert(item: T) {
        try! realm.write {
            realm.add(RealmPlace(item))
        }
    }
    //func update(by id: String, with first_name: String, last_name: String) {
    //    try! realm.write {
    //        let predicate = NSPredicate(format: "imageURL = %@", id)
    //        let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
    //        targetViewer[0].first_name = first_name
    //        targetViewer[0].last_name = last_name
    //    }
    //}
    func clean() {
        try! realm.write {
            realm.delete(realm.objects(RealmPlace.self))
        }
    }
    func delete(item: T) {
        //realm.delete(RealmRecord(item))
    }
    func deleteById(id: String) {
        //try! realm.write {
         //   let predicate = NSPredicate(format: "imageURL = %@", id)
           // let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
            //realm.delete(targetViewer)
        //}
    }
    func checkBy(first_name: String) -> Bool {
        //let predicate = NSPredicate(format: "first_name = %@", first_name)
        //let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
        //if targetViewer.count == 0 {
        //    return false
        //}
        return true
    }
}

// MARK: - GroupEntity

struct Group {
    var name: String
    var color: Data
    var places: [Place]
    var viewers: [Viewer]
}

class RealmGroup: Object {
    dynamic var name = ""
    dynamic var color = Data()
    var places = List<RealmPlace>()
    var viewers = List<RealmViewer>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(_ group: Group) {
        self.init()
        name = group.name
        color = group.color
        places = List(group.places.map { RealmPlace($0) })
        viewers = List(group.viewers.map { RealmViewer($0) })
    }
    
    var entity: Group {
        return Group(name: name,
                     color: color,
                     places: places.map {$0.entity},
                     viewers: viewers.map {$0.entity} )
    }
}

class GroupRealmDataSource: DataSource {
    func update(by id: String, with name: String) {
        <#code#>
    }
    
    typealias T = Group
    private let realm = try! Realm()
    
    func getAll() -> [T] {
        return realm.objects(RealmGroup.self).map {$0.entity}
    }
    func getById(id: String) -> T {
        return Group(name: "", color: Data(), places: [], viewers: [])
    }
    func insert(item: T) {
        try! realm.write {
            realm.add(RealmGroup(item))
        }
    }
    //func update(by id: String, with first_name: String, last_name: String) {
    //    try! realm.write {
    //        let predicate = NSPredicate(format: "imageURL = %@", id)
    //        let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
    //        targetViewer[0].first_name = first_name
    //        targetViewer[0].last_name = last_name
    //    }
    //}
    func clean() {
        try! realm.write {
            realm.delete(realm.objects(RealmGroup.self))
        }
    }
    func delete(item: T) {
        //realm.delete(RealmRecord(item))
    }
    func deleteById(id: String) {
        try! realm.write {
            let predicate = NSPredicate(format: "name = %@", id)
            let targetViewer = realm.objects(RealmViewer.self).filter(predicate)
            realm.delete(targetViewer)
        }
    }
    func checkBy(name: String) -> Bool {
        let predicate = NSPredicate(format: "name = %@", name)
        let targetGroup = realm.objects(RealmGroup.self).filter(predicate)
        if targetGroup.count == 0 {
            return false
        }
        return true
    }
}

protocol DataSource {
    associatedtype T
    
    func getAll() -> [T]
    func getById(id: String) -> T
    func insert(item: T)
    func update(by id: String, with name: String)
    func clean()
    func delete(item: T)
    func deleteById(id: String)
}
