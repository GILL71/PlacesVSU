//
//  HallViewController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 27.08.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit

class HallViewController: UIViewController, UIScrollViewDelegate {
    
    let gradientColor1 = Constants.gradientColor1
    let gradientColor2 = Constants.gradientColor2
    var placesManager: PlacesManager?
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    // MARK: - Actions
    @IBAction func changeAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func createAction(_ sender: UIBarButtonItem) {
        //placesManager?.createGroup()
        self.performSegue(withIdentifier: "segue_create_group", sender: self)
            //пушим liistVC, передавая ему количество выбраных мест - placesManager.pressedButtons.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segue_create_group" {
        if let destinationViewController = segue.destination as? ListViewController {
            for button in (placesManager?.pressedButtons)! {
                destinationViewController.selectedPlaces.append(button.place)
            }
        }
        }
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        placesManager = PlacesManager.init(with: self)
        UserDefaults.standard.set(Constants.PlaceAdded.no.rawValue, forKey: Constants.placeAdded)
        
        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.testView.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        
        //createPlaces()
        placesManager!.createPlaces()
        scrollViewScale(view: self)
        
        self.testView.layer.insertSublayer(btnGradient, at: 0)
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func scrollViewScale(view: HallViewController) {
        view.scrollView.minimumZoomScale = 0.3
        view.scrollView.maximumZoomScale = 20.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.testView
    }
}

extension UIColor {
    class func color(withData data:Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}
