//
//  LastModels.swift
//  
//
//  Created by Михаил Нечаев on 25.08.17.
//
//

import Foundation
/*
//у одного зрителя может быть много мест

class Group {
    
    var name: String
    var viewers: [Friend]
    var places: [Place]
    var color: UIColor
    
    init(name: String, viewers: [Friend], places: [Place], color: UIColor) {
        self.name = name
        self.viewers = viewers
        self.places = places
        self.color = color
    }
    
    func addViewers(newViewers:[Friend]) {
        for v in newViewers {
            viewers.append(v)
        }
    }
    
    func addPlaces(newPlaces:[Place]) {
        for v in newPlaces {
            places.append(v)
        }
    }
}

extension Groupa {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groupa> {
        return NSFetchRequest<Groupa>(entityName: "Groupa")
    }
    
    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var placesRelation: NSSet?
    @NSManaged public var viewersRelation: NSSet?
    
}

// MARK: Generated accessors for placesRelation
extension Groupa {
    
    @objc(addPlacesRelationObject:)
    @NSManaged public func addToPlacesRelation(_ value: Placa)
    
    @objc(removePlacesRelationObject:)
    @NSManaged public func removeFromPlacesRelation(_ value: Placa)
    
    @objc(addPlacesRelation:)
    @NSManaged public func addToPlacesRelation(_ values: NSSet)
    
    @objc(removePlacesRelation:)
    @NSManaged public func removeFromPlacesRelation(_ values: NSSet)
    
}

// MARK: Generated accessors for viewersRelation
extension Groupa {
    
    @objc(addViewersRelationObject:)
    @NSManaged public func addToViewersRelation(_ value: Viewer)
    
    @objc(removeViewersRelationObject:)
    @NSManaged public func removeFromViewersRelation(_ value: Viewer)
    
    @objc(addViewersRelation:)
    @NSManaged public func addToViewersRelation(_ values: NSSet)
    
    @objc(removeViewersRelation:)
    @NSManaged public func removeFromViewersRelation(_ values: NSSet)
    
}

class Place {
    var row: Int
    var num: Int
    var x: Int
    var y: Int
    
    init(row: Int, num: Int) {
        self.row = row
        self.num = num
        self.x = num
        self.y = row
    }
    
    func isPlaceEqualTo(place:Place) -> Bool {
        return place.num == self.num && place.row == self.row
    }
}

@nonobjc public class func fetchRequest() -> NSFetchRequest<Placa> {
    return NSFetchRequest<Placa>(entityName: "Placa")
}

@NSManaged public var num: NSDecimalNumber?
@NSManaged public var row: NSDecimalNumber?
@NSManaged public var fromGroup: Groupa?

struct Friend {
    
    let first_name: String
    let last_name: String
    let imageURL: String
}

extension Viewer {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Viewer> {
        return NSFetchRequest<Viewer>(entityName: "Viewer")
    }
    
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var fromGroup: NSSet?
    
}

// MARK: Generated accessors for fromGroup
extension Viewer {
    
    @objc(addFromGroupObject:)
    @NSManaged public func addToFromGroup(_ value: Groupa)
    
    @objc(removeFromGroupObject:)
    @NSManaged public func removeFromFromGroup(_ value: Groupa)
    
    @objc(addFromGroup:)
    @NSManaged public func addToFromGroup(_ values: NSSet)
    
    @objc(removeFromGroup:)
    @NSManaged public func removeFromFromGroup(_ values: NSSet)
    
}
*/
