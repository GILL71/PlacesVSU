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
import RealmSwift

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
    weak var AddAlertSaveAction: UIAlertAction?
    
    let segments: [SegmentType] = [.friend, .message]
    
    var groupStorage = GroupRealmDataSource()
    
    let friendCells: [FriendSectionType] = [.friend, .load]
    let messageCells: [MessageSectionType] = [.message, .load]
    let serverInstance = ServerManager()
    var friends = [Viewer]()
    var messages = [String]()

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
        listTableView.reloadData()
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
      
        //set up the alertcontroller
        let title = NSLocalizedString("New Prescription", comment: "")
        let message = NSLocalizedString("Insert a name for this prescription.", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("Save", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Add the text field with handler
        alertController.addTextField { textField in
            //listen for changes
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
        }
        func removeTextFieldObserver() {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: alertController.textFields?[0])
        }
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            removeTextFieldObserver()
        }
        let saveAction = UIAlertAction(title: otherButtonTitle, style: .default) { action in
            var viewers = [Viewer]()
            for index in self.selectedIndexes {
                viewers.append(self.friends[index.value])
            }
            let groupName = alertController.textFields?[0].text
            let color = self.getRandomColor()
            self.groupStorage.insert(item: Group(name: groupName!,
                                                 color: color.encode(),
                                                 places: self.selectedPlaces,
                                                 viewers: viewers))
            removeTextFieldObserver()
            self.navigationController?.popToRootViewController(animated: true)
        }
        // disable the 'save' button (otherAction) initially
        saveAction.isEnabled = false
        // save the other action to toggle the enabled/disabled state when the text changed.
        AddAlertSaveAction = saveAction
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
    }
    
    func configurationTextField(textField: UITextField!){
        textField.placeholder = "Name"
    }
    
    func handleTextFieldTextDidChangeNotification(sender: NSNotification) {
        let textField = sender.object as! UITextField
        AddAlertSaveAction!.isEnabled = (textField.text?.characters.count)! > 0
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed: CGFloat = CGFloat(drand48())
        
        let randomGreen: CGFloat = CGFloat(drand48())
        
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
