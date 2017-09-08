//
//  DrawViewController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 13.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit
import CoreData

class DrawViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
/*
    var pressedButton: UIButton?
    let dataController = DataController.shared
    //var groupsArray = [Groupa]()
    var currentGroupColor: String?
    let gradientColor1 = Constants.gradientColor1
    let gradientColor2 = Constants.gradientColor2
    let buttonFont = Constants.buttonFont
    
    var row: Int?
    var num: Int?
    
    let leftSector = LeftSector.init()
    let centralSector = CentralSector.init()
    // MARK: - Outlets
    @IBOutlet weak var testView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    // MARK: - Actions
    @IBAction func editMode(_ sender: UIBarButtonItem) {
        sender.tintColor = UIColor.lightGray
        addButton.tintColor = UIColor.blue
        
        UserDefaults.standard.set(Constants.Mode.edit.rawValue, forKey: Constants.modeKey)
    }
    
    @IBAction func addMode(_ sender: UIBarButtonItem) {
        sender.tintColor = UIColor.lightGray
        editButton.tintColor = UIColor.blue

        UserDefaults.standard.set(Constants.Mode.create.rawValue, forKey: Constants.modeKey)
    }
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        UserDefaults.standard.set(Constants.PlaceAdded.no.rawValue, forKey: Constants.placeAdded)
        
        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.view.bounds
        //btnGradient.frame = self.testView.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        
        createPlaces()
        scrollViewScale(view: self)
        
        self.testView.layer.insertSublayer(btnGradient, at: 0)
        self.view.backgroundColor = UIColor.white*/
        //self.view.layer.insertSublayer(btnGradient, at: 0)
        
        //self.testView.frame = CGRect(x: 50, y: 50, width: 2000, height: 2000)
        //self.testView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1600, height:1200))
        
        UserDefaults.standard.set(Constants.PlaceAdded.no.rawValue, forKey: Constants.placeAdded)
        
        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.testView.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        
        createPlaces()
        scrollViewScale(view: self)
        
        self.testView.layer.insertSublayer(btnGradient, at: 0)
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let s = String(describing: UserDefaults.standard.object(forKey: Constants.placeAdded)!)
        print(s)
        print(Constants.PlaceAdded.no.rawValue)
        if s == Constants.PlaceAdded.no.rawValue {
            if let buttonPressed = pressedButton {
                buttonPressed.backgroundColor = UIColor.clear
            }
        }
    }
    
    func scrollViewScale(view: DrawViewController) {
        view.scrollView.minimumZoomScale = 0.3
        view.scrollView.maximumZoomScale = 20.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.testView
    }
    // MARK: - Places
    func createPlaces() {
        for p in leftSector.places {
            let button = Constants.createPlaceButton(for: p)
            if checkPlace(place: p) {
                button.backgroundColor = Constants.colorForName(currentGroupColor!)
            } else {
                button.backgroundColor = UIColor.clear
            }
            if UserDefaults.standard.object(forKey: Constants.modeKey) as! String == Constants.Mode.create.rawValue {
                button.addTarget(self, action: #selector(createAction), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
            }
            row = p.row
            num = p.num
            button.addTarget(self, action: #selector(bHighltd), for: .touchDown)
            self.testView.addSubview(button)
        }
        for p in centralSector.places {
            let button = Constants.createPlaceButton(for: p)
            if checkPlace(place: p) {
                button.backgroundColor = Constants.colorForName(currentGroupColor!)
            } else {
                button.backgroundColor = UIColor.clear
            }
            if UserDefaults.standard.object(forKey: Constants.modeKey) as! String == Constants.Mode.create.rawValue {
                button.addTarget(self, action: #selector(createAction), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
            }
            row = p.row
            num = p.num
            button.addTarget(self, action: #selector(bHighltd), for: .touchDown)
            self.testView.addSubview(button)
        }
    }
    // MARK: - Edit/create
    func createAction(sender: UIButton!) {
        
        print("Button \(String(describing: sender.titleLabel!.text!)) tapped")
        print("\(Int((sender.frame.minY - 128) / 20 + 1)) - row of place")
        
        let row = Int((sender.frame.minY - 128) / 20) + 1
        let num = Int(sender.titleLabel!.text!)
        UserDefaults.standard.set(row, forKey: Constants.rowKey)
        UserDefaults.standard.set(num, forKey: Constants.numKey)
        
        let actionSheetController = UIAlertController(title: "\(String(describing: sender.titleLabel!.text!))", message: "Хотите добавить группу или одного человека?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { action -> Void in
            if let button = self.pressedButton {
                button.backgroundColor = UIColor.clear
            }
        }
        actionSheetController.addAction(cancelAction)
        
        //GROUP
        let createGroupAction = UIAlertAction(title: "Группа", style: .default) { action -> Void in
            UserDefaults.standard.set(Constants.GroupOrSingle.group.rawValue, forKey: Constants.groupOrSingleKey)
            if UserDefaults.standard.object(forKey: Constants.authorizeKey) as! String == Constants.Authorize.no.rawValue {
                self.createGroupForNonauthorizedState()
            } else {
                self.createGroupForAuthorizedState()
            }
        }
        actionSheetController.addAction(createGroupAction)
        
        //PLACE
        let createPlaceAction = UIAlertAction(title: "Один человек", style: .default) { action -> Void in
            UserDefaults.standard.set(Constants.GroupOrSingle.single.rawValue, forKey: Constants.groupOrSingleKey)
            if UserDefaults.standard.object(forKey: Constants.authorizeKey) as! String == Constants.Authorize.no.rawValue {
                self.createPlaceForNonauthorizedState()
            } else {
                self.performSegue(withIdentifier: "segue_create_group", sender: self)
            }
        }
        actionSheetController.addAction(createPlaceAction)
        
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func editAction(sender: UIButton) {
        
        let actionSheetController = UIAlertController(title: "\(String(describing: sender.titleLabel!.text!))", message: "Хотите добавить это место в группу?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { action -> Void in
            let row = Int((sender.frame.minY - 128) / 20) + 1
            let num = Int(sender.titleLabel!.text!)
            let place = Placa()
            place.num = num as? NSDecimalNumber
            place.row = row as? NSDecimalNumber
            self.dataController.seed(place: place, to: UserDefaults.standard.object(forKey: "currentGroup") as! Groupa)
            
            sender.backgroundColor = Constants.colorForName(self.currentGroupColor!)
        }
        actionSheetController.addAction(addAction)
    }
    // MARK: - GroupAction
    func createGroupForNonauthorizedState() {
        let alert = UIAlertController(title: "", message: "Введите имя группы", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: self.configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            
            print("\(String(describing: alert.textFields?[0].text)) - added")
            
            //добавление в базу
            
            self.present(alert, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.default, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createGroupForAuthorizedState() {
        let alert = UIAlertController(title: "", message: "Введите имя группы", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: self.configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            
            print("\(String(describing: alert.textFields?[0].text)) - added")
            
            //self.dataController.seedGroup(with: (alert.textFields?[0].text)!, color: self.randomColor())
            //больше это не здесь, я передумал
            UserDefaults.standard.setValue(alert.textFields?[0].text, forKey: Constants.groupNameKey)
            
            self.performSegue(withIdentifier: "segue_create_group", sender: self)
            
        }))
        alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.default, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - PlaceAction
    func createPlaceForNonauthorizedState() {
        let alert = UIAlertController(title: "", message: "Введите имя", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: self.configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
            print("User click Ok button")
            //здесь надо передать номер места (в кнопке) и ряд (как????)
            //  let p = Place.init(row: row, num: num)
        }))
        alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.default, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    //  MARK: - Helpers
    func configurationTextField(textField: UITextField!){
        textField.placeholder = "Name"
    }
    
    func bHighltd(sender: UIButton) {
        
        //если кнопка-место уже закреплено за группой (проверка)
        //то её в прессдБатон не запоминать
        //а вообще надо сделать так, чтобы по нажатию на неё выводилось имя группы и список людей в ней, как и в
        //GroupVC
        
        groupsArray = dataController.fetchGroup()
        for group in groupsArray {
            for p in group.placesRelation! {
                if (p as! Placa).row! as Int == row && (p as! Placa).num! as Int == num {
                    //вывести информацию о группе
                }
            }
        }
        
        sender.backgroundColor = UIColor.orange
        pressedButton = sender
    }
    
    func checkPlace(place: Place) -> Bool {
        groupsArray = dataController.fetchGroup()
        for group in groupsArray {
            currentGroupColor = group.color!
            for p in group.placesRelation! {
                if (p as! Placa).row! as Int == place.row && (p as! Placa).num! as Int == place.num {
                    return true
                }
            }
        }
        return false
    }
    */
}
