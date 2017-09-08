//
//  StartViewController.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 22.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import UIKit
import VKSdkFramework
import CoreData

class StartViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    //MARK: - Properties
    let serverInstance = ServerManager()
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var vkEnter: UIButton!
    @IBOutlet weak var noneEnter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()

        self.tabBarController?.tabBar.items?[1].isEnabled = false
        self.tabBarController?.tabBar.items?[2].isEnabled = false
        setUIProperties()
        
        UserDefaults.standard.set(Constants.GroupOrSingle.group.rawValue, forKey: Constants.groupOrSingleKey)
    }
    //MARK: - Actions
    @IBAction func exitAction(_ sender: Any) {
        VKSdk.forceLogout()
    }
    
    @IBAction func authorizeVK(_ sender: UIButton) {
        serverInstance.enterVK()
        unlockTabs()
        UserDefaults.standard.set(Constants.Authorize.yes.rawValue, forKey: Constants.authorizeKey)
        self.tabBarController?.selectedIndex = 1
    }
    
    func unlockTabs() {
        self.tabBarController?.tabBar.items?[1].isEnabled = true
        self.tabBarController?.tabBar.items?[2].isEnabled = true
    }

    @IBAction func noneAuthorize(_ sender: UIButton) {
        unlockTabs()
        UserDefaults.standard.set(Constants.Authorize.no.rawValue, forKey: Constants.authorizeKey)
        self.tabBarController?.selectedIndex = 1
        setDelegates()
    }
    
    func setDelegates() {
        serverInstance.sdkInstance?.register(self)
        serverInstance.sdkInstance?.uiDelegate = self as VKSdkUIDelegate
    }
    
    func setUIProperties() {
        imageView.image = UIImage(named: "ic_vk_logo_nb")
        vkEnter.tintColor = Constants.myColor
        noneEnter.tintColor = Constants.myColor
        exitButton.tintColor = Constants.myColor
        vkEnter.layer.borderColor = Constants.myColor.cgColor
        vkEnter.layer.borderWidth = 2
        vkEnter.layer.cornerRadius = 7
        noneEnter.layer.borderColor = Constants.myColor.cgColor
        noneEnter.layer.borderWidth = 2
        noneEnter.layer.cornerRadius = 7
    }
}

extension StartViewController {
    // MARK: - VKSdkUIDelegate
    public func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: true, completion: nil)
    }
    public func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc: VKCaptchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc.present(in: self)
    }
    // MARK: - VKSdkDelegate
    public func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard let result = result.token else {
            return
        }
        //UserDefaults.standard.set(result, forKey: "token")
    }
    public func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
}

