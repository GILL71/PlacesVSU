//
//  DataController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 26.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//
/*
import UIKit
import CoreData
class DataController: NSObject {
    static let shared = DataController()
    
    var managedObjectContext: NSManagedObjectContext
    
    var persistentContainer: NSPersistentContainer? =
    (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override init() {
        managedObjectContext = (persistentContainer?.viewContext)!

    }
    
    func removeCD() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Placa")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            
            // Save Changes
            try managedObjectContext.save()
            
        } catch {
            // Error Handling
            // ...
            print("error - \(error)")
        }
    }
    
    func check(place:Place) -> Bool {
        let placeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Placa")
        var row, num: Int
        do {
            let fetchedPlace = try managedObjectContext.fetch(placeFetch)
            let places = fetchedPlace as! [Placa]
            for p in places {
                row = p.row! as Int + 1
                num = p.num! as Int + 1
                if row == place.row && num == place.num {
                    return false
                }
            }
        } catch {
            fatalError("bad things happened : \(error)")
        }
        return true
    }
    
    func seedGroup(with name: String, color: String, place: Place, friends: [Friend]) {
        
        //получить массив мест из юзердефолтс, массив объектов друзей
        //и по ним делать проверку того, какие объекты 
        
        let placesFetchRequest = NSFetchRequest<Placa>(entityName: "Placa")
        let allPlaca = try! managedObjectContext.fetch(placesFetchRequest)
        var arrayF = [Viewer]()
        var arrayP = [Placa]()
        
        let p = allPlaca.filter({ (z: Placa) -> Bool in
            return z.num! as Int == place.num && z.row! as Int == place.row
        }).first
        arrayP.append(p!)
        
        let friendsFetchRequest = NSFetchRequest<Viewer>(entityName: "Viewer")
        let allViewers = try! managedObjectContext.fetch(friendsFetchRequest)
        
        for f in friends {
            let friend = allViewers.filter({ (y: Viewer) -> Bool in
                return y.first_name == f.first_name && y.last_name == f.last_name
            }).first
            arrayF.append(friend!)
        }

        let group = NSEntityDescription.insertNewObject(forEntityName: "Groupa", into: managedObjectContext) as! Groupa
        
        group.setValue(name, forKey: "name")
        let color = color
        group.setValue(color, forKey: "color")
        group.viewersRelation = NSSet(array: arrayF)
        group.placesRelation = NSSet(array: arrayP)
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failure to save context: \(error)")
        }
    }
    
    func fetchViewer() {
        let viewerFetch = NSFetchRequest<Viewer>(entityName: "Viewer")
        
        do {
            let fetchedViewer = try managedObjectContext.fetch(viewerFetch)
            print(fetchedViewer[0].first_name!)
        } catch {
            fatalError("bad things happened : \(error)")
        }
    }
    
    func seedPlace(place: Place) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Placa", into: managedObjectContext) as! Placa
        
        entity.setValue(place.num, forKey: "num")
        entity.setValue(place.row, forKey: "row")
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failure to save context: \(error)")
        }
    }
    
    func seedFriend(friend: Friend) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Viewer", into: managedObjectContext) as! Viewer
        
        entity.setValue(friend.first_name, forKey: "first_name")
        entity.setValue(friend.last_name, forKey: "last_name")
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failure to save context: \(error)")
        }
    }
    
    func fetchPlace() {
        let placeFetch = NSFetchRequest<Placa>(entityName: "Placa")
        
        do {
            let fetchedPlace = try managedObjectContext.fetch(placeFetch)
            for p in fetchedPlace {
                print("\(String(describing: p.row)) \(String(describing: p.num))")
            }
        } catch {
            fatalError("bad things happened : \(error)")
        }
    }
    
    func fetchGroup() -> [Groupa] {
        let groupFetch = NSFetchRequest<Groupa>(entityName: "Groupa")
        
        do {
            let fetchedGroup = try managedObjectContext.fetch(groupFetch)
            var p: Placa
            var f: Viewer
            for g in fetchedGroup {
                for x in g.placesRelation! {
                    p = x as! Placa
                    print("\(p.num) \(p.row) MESTAAAA")
                }
                for y in g.viewersRelation! {
                    f = y as! Viewer
                    print("\(f.first_name) \(f.last_name) VIEWERSRSRS")
                }
                print("\(String(describing: g.color)) \(String(describing: g.name))")
                return fetchedGroup
            }
        } catch {
            fatalError("bad things happened : \(error)")
        }
        return [Groupa]()
    }
    
    //не проверял
    func removeGroupWith(name: Groupa) {
        managedObjectContext.delete(name as Groupa)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("error : \(error)")
        }
    }
    
    func seed(place: Placa, to group: Groupa) {
        do {
            group.placesRelation?.adding(place)
        } catch {
            fatalError("bad things happened : \(error)")
        }
    }
    
    func updateGroup(with group: Groupa, and color: String) {
        group.setValue(color, forKey: "color")
        do {
            try managedObjectContext.save()
        }
        catch {
            print(error)
        }
    }
    //вот вроде работает всё, но если не дебажить, результаты не выводятся, мб они сохранятся, если мне нужно будет
    //а пока всё сработало
}
*/
