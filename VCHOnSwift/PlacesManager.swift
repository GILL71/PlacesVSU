//
//  PlacesManager.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 27.08.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit
import Foundation

class PlacesManager {
    private let leftSector = LeftSector.init()
    var controller: HallViewController
    var pressedButtons = Set<PlaceButton>()

    init(with controller: HallViewController) {
        self.controller = controller
    }

    func createPlaces() {
        for place in leftSector.places {
            let button = PlaceButton(place: place)
            //button.addTarget(self, action: #selector(placeAction), for: .touchUpInside)
            button.addTarget(self, action: #selector(placeTap), for: .touchUpInside)
            button.backgroundColor = UIColor.clear
            controller.testView.addSubview(button)
        }
    }
    
    @objc func placeTap(sender: PlaceButton) {
        if sender.backgroundColor == UIColor.clear {
            sender.backgroundColor = UIColor.orange
            pressedButtons.insert(sender)
        } else {
            sender.backgroundColor = UIColor.clear
            pressedButtons.remove(sender)
        }
    }
    
    func createGroup() {
        if pressedButtons.isEmpty {
            let alert = UIAlertController(title: "Внимание! Вы не выбрали места для создания группы",
                                          message: "Выберите хотя бы одно место",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
        } else {
            let actionSheetController = UIAlertController(title: "", message: "Хотите использовать свои данные VK?", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { action -> Void in }
            actionSheetController.addAction(cancelAction)
            
            let createByVK = UIAlertAction(title: "Использовать данные VK", style: .default) { action -> Void in
                //надо пушить listVC
                self.controller.performSegue(withIdentifier: "segue_create_group", sender: self.controller)
            }
            actionSheetController.addAction(createByVK)
            
            let createManually = UIAlertAction(title: "Заполнить вручную", style: .default) { action -> Void in
            //выводить алерт, пока количество показов меньше количества мест
                // - надо как-то это решить - пока будут выводиться бесконечно
                let alert = UIAlertController(title: "",
                                              message: "Введите имя группы",
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addTextField(configurationHandler: self.configurationTextField)
                alert.addAction(UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default, handler: { (UIAlertAction)in
                    print("\(String(describing: alert.textFields?[0].text)) - added")
                    //ЗАНЕСТИ ИМЕНА В БАЗУ
                    self.controller.present(alert, animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.default, handler:nil))
                self.controller.present(alert, animated: true, completion: nil)
            }
            actionSheetController.addAction(createManually)
            controller.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
    func configurationTextField(textField: UITextField!){
        textField.placeholder = "Name"
    }
}
