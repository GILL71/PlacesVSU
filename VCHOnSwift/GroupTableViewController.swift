//
//  GroupTableViewController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 26.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit
import CoreData

extension GroupTableViewController {
    enum SectionType {
        case slider
        case group
    }
}

class GroupTableViewController: UITableViewController {
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    
    var groupsArray = [Groupa]()
    var selectedGroup: Int?
    var sections: [SectionType] = [.slider, .group]
    var sliderColor: String?
    
    //let moc = DataController().managedObjectContext
    let dataController = DataController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsArray = dataController.fetchGroup()
        colorButton.tintColor = UIColor.lightGray
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .slider:
            return 1
        case .group:
            return groupsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .slider:
            model = SliderTableViewCellModel()
        case .group:
            let group = groupsArray[indexPath.row]
            model = GroupTableViewCellModel(group: group)
        }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        
        infoButton.tintColor = UIColor.blue
        colorButton.tintColor = UIColor.blue
        
        selectedGroup = indexPath.row
        //UserDefaults.standard.set(indexPath, forKey: "indexPath")
        //UserDefaults.standard.set(groupsArray[selectedGroup! - 1], forKey: "currentGroup")
    }
    
    //проблема с чекмарком пока мне не по силам, но решить её нужно
    //выделяем группу - переходим на другую вкладку - возвращаемся = можно выделить ещё одну группу, те на обеих отметки
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
    @IBAction func colorButtonPressed(_ sender: Any) {
        
        if let groupSelected = selectedGroup {
            dataController.updateGroup(with: groupsArray[groupSelected], and: sliderColor!)
        } else {
            print("SMTHNG WRONG: no selected group")
        }
        tableView.reloadData()
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        infoButton.tintColor = UIColor.gray
        colorButton.tintColor = UIColor.blue
        
        var list = ""
        var f: Viewer
        for y in groupsArray[selectedGroup!].viewersRelation! {
            f = y as! Viewer
            list += String("\(f.first_name!) \(f.last_name!), ")
        }
        
        let alert = UIAlertController(title: "Информация о группе:", message: list, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler:nil))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertActionStyle.destructive, handler: {
            (UIAlertAction)in
            self.dataController.removeGroupWith(name: self.groupsArray[self.selectedGroup! - 1])
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        //если группу выделена - свич кейс
        //иначе - надо зафризить слайдер, чтбы не двигался
        
        if selectedGroup != nil  {
            sender.isEnabled = true
            sliderColor = Constants.colorFrom(value: sender.value)
        } else {
            sender.isEnabled = false
        }
    }
 }
