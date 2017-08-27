//
//  CellViewModel.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 07.07.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

protocol CellViewAnyModel {
    static var cellAnyType: UIView.Type { get }
    func setupAny(cell: UIView)
}

protocol CellViewModel: CellViewAnyModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

extension CellViewModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    
    func setupAny(cell: UIView) {
        setup(cell: cell as! CellType)
    }
}

extension UITableView {
    func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: model).cellAnyType)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        model.setupAny(cell: cell)
        
        return cell
    }
    
    func dequeueReusableRollingCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: model).cellAnyType)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        model.setupAny(cell: cell)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = Constants.myColor
        }
        
        return cell
    }
    //в груптейблвьюконтроллере я загружаю цвет ячейки из модели, поэтому можно здесь оставить чередующеся цвета для всех по умолчанию, а в дальнейшем, если надо, чтобы ячейки были других цветов, переопределять цвета в моделях ячеек
    
    //не получилось(((
}

struct SliderTableViewCellModel {
    
}

extension SliderTableViewCellModel: CellViewModel {
    func setup(cell: SliderTableViewCell) {
        
    }
}

struct GroupTableViewCellModel {
    let group: Group
}

extension GroupTableViewCellModel: CellViewModel {
    func setup(cell: GroupTableViewCell) {
        cell.nameLabel.text = group.name
        //cell.backgroundColor = Constants.colorForName(group.color!)
        cell.backgroundColor = UIColor.color(withData: group.color)
    }
}

struct FriendTableViewCellModel {
    let viewer: Viewer
    
    var fullName: String{
        return viewer.first_name + " " + viewer.last_name
    }
}

extension FriendTableViewCellModel: CellViewModel {
    func setup(cell: FriendTableViewCell) {
        cell.nameLabel.text = fullName
        Alamofire.request(viewer.imageURL).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                cell.avatarImage.image = image
            }
        }
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
    }
}

struct LoadingTableViewCellModel {

}

extension LoadingTableViewCellModel: CellViewModel {
    func setup(cell: LoadingTableViewCell) {
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
    }
}

struct MessageTableViewCellModel {
    let message: String
}

extension MessageTableViewCellModel: CellViewModel {
    func setup(cell: MessageTableViewCell) {
        cell.messageLabel?.text = message
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
    }
}
