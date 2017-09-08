//
//  ListViewController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 17.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//
import VKSdkFramework
import UIKit
import Alamofire
import AlamofireImage

extension ListViewController {
    enum FriendSectionType {
        case friend
        case load
    }
}

extension ListViewController {
    enum MessageSectionType {
        case load
        case message
    }
}

extension ListViewController {
    enum SegmentType {
        case friend
        case message
    }
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let segments: [SegmentType] = [.friend, .message]
    
    let friendCells: [FriendSectionType] = [.friend, .load]
    let messageCells: [MessageSectionType] = [.message, .load]
    let serverInstance = ServerManager()
    var friends = [Viewer]()
    var messages = [String]()

    // var selectedFriends = [Friend]()
    var selectedIndexes: [String: Int] = [:]
    var selectedPlaces = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverInstance.loadMessages { response in
            self.messages = response
        }
        serverInstance.loadFriends { response in
            self.friends = response
        }
        self.listTableView.allowsMultipleSelection = true
        
        segmentedControl.tintColor = Constants.myColor
        cancelButton.tintColor = Constants.myColor
        
        listTableView.reloadData()
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        //UserDefaults.standard.set(Constants.PlaceAdded.no.rawValue, forKey: Constants.placeAdded)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sourceChanged(_ sender: Any) {
        listTableView.reloadData()
    }
    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
     }
     
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath)
     
     return cell
     
     }*/
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        let segmentType = segments[segmentedControl.selectedSegmentIndex]
        switch
        (segmentType) {
        case .friend:
            return friendCells.count
        case .message:
            return messageCells.count
        }
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segmentType = segments[segmentedControl.selectedSegmentIndex]
        switch
        (segmentType) {
        case .friend:
            let sectionType = friendCells[section]
            switch sectionType {
            case .friend:
                return friends.count
            case .load:
                return 1
            }
        case .message:
            let sectionType = messageCells[section]
            switch sectionType {
            case .message:
                return messages.count
            case .load:
                return 1
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FsectionType = friendCells[indexPath.section]
        let MsectionType = messageCells[indexPath.section]
        let model: CellViewAnyModel
        
        let segmentType = segments[segmentedControl.selectedSegmentIndex]
        
        switch
        (segmentType) {
        case .friend:
            switch FsectionType {
            case .friend:
                tableView.rowHeight = 71
                let friend = friends[indexPath.row]
                model = FriendTableViewCellModel(viewer: friend)
            case .load:
                model = LoadingTableViewCellModel()
            }
        case .message:
            switch MsectionType {
            case .load:
                model = LoadingTableViewCellModel()
            case .message:
                tableView.rowHeight = 110
                let message = messages[indexPath.row]
                model = MessageTableViewCellModel(message: message)
            }
        }
        return tableView.dequeueReusableRollingCell(withModel: model, for: indexPath)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segmentType = segments[segmentedControl.selectedSegmentIndex]
        switch
        (segmentType) {
        case .friend:
            let FsectionType = friendCells[indexPath.section]
            switch FsectionType {
            case .friend:
                if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
                    selectedIndexes[String("\(indexPath.row)")] = nil
                } else {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    selectedIndexes[String("\(indexPath.row)")] = indexPath.row
                }
            case .load:
                serverInstance.loadFriends() { response in
                    self.friends.append(contentsOf: response)
                }
                self.listTableView.reloadData()
            }
        case .message:
            let MsectionType = messageCells[indexPath.section]
            switch MsectionType {
            case .load:
                serverInstance.loadMessages() { response in
                    self.messages.append(contentsOf: response)
                }
                self.listTableView.reloadData()
            case .message:
                if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
                } else {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                }
            }
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        /*
         print(selectedIndexes)
         
         for index in selectedIndexes.values {
         selectedFriends.append(friends[index])
         dataController.seedFriend(friend: friends[index])
         }
         
         //UserDefaults.standard.setValue(selectedFriends, forKey: "friends")
         
         let row = UserDefaults.standard.object(forKey: Constants.rowKey) as? Int
         let num = UserDefaults.standard.object(forKey: Constants.numKey) as? Int
         
         let place = Place.init(row: row!, num: num!)
         dataController.seedPlace(place: place)
         
         //UserDefaults.standard.setValue(place, forKey: "places")
         
         dataController.seedGroup(with:
         UserDefaults.standard.object(forKey:
         Constants.groupNameKey) as! String, color: Constants.randomColor(), place: place, friends: selectedFriends)
         dismiss(animated: true, completion: nil)
         */}
}
