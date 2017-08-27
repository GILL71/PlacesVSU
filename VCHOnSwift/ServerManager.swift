//
//  ServerManager.swift
//  VCHOnSwift
//
//  Created by Михаил Нечаев on 25.05.17.
//  Copyright © 2017 Михаил Нечаев. All rights reserved.
//

import Foundation
import VKSdkFramework

class ServerManager {
    
    let VK_APP_ID = "5982662" // Идентификатор Вашего VK-приложения
    let SCOPE = [VK_PER_FRIENDS, VK_PER_MESSAGES]
    var accessToken: VKAccessToken?
    var sdkInstance: VKSdk?
    let parser = Parser()
    
    var messages = [String]()
    let numberOfMessages = 6
    let numberOfFriends = 11
    var friends = [Viewer]()
    
    func enterVK () {
        sdkInstance = VKSdk.initialize(withAppId: VK_APP_ID)
        
        VKSdk.wakeUpSession(SCOPE) { (state, error) -> Void in
            
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState = Authorized")
                let request: VKRequest = VKApi.users().get()
                request.execute(resultBlock: { (response) in
                    print(response?.json ?? "response")
                }, errorBlock: { (error) in
                    print(error?.localizedDescription ?? "error in authorized")
                })
            } else if error != nil {
                print(error?.localizedDescription ?? "error not authorized")
            } else {
                print(self.sdkInstance?.apiVersion ?? "api version")
                VKSdk.authorize(self.SCOPE)
            }
        }
    }
    
    func loadMessages() {
        let messagesParams = ["access_token":VKSdk.accessToken().accessToken, "out": "1", "count":numberOfMessages, "filters":"0", "offset": messages.count + 1] as [AnyHashable : Any]
        
        let mRequest: VKRequest = VKRequest.init(method: "messages.get", parameters: messagesParams)
        mRequest.execute(resultBlock: { (response) in
            let ms = self.parser.parseMessages(json: response?.json as! [String : Any], numberOfMessages: self.numberOfMessages)
            for message in ms {
                self.messages.append(message)
            }
        }) { (error) in
            print("error messages response - \(String(describing: error?.localizedDescription))")
        }
    }
    
    func loadFriends() {
        let friendsParams = ["access_token": VKSdk.accessToken().accessToken, "user_id": "44778251", "order":"hints", "fields": "photo_200", "count": numberOfFriends, "offset": friends.count + 1] as [AnyHashable : Any]
        let fRequest: VKRequest = VKRequest.init(method: "friends.get", parameters: friendsParams)
        fRequest.execute(resultBlock: { (response) in
            let fr = self.parser.parseFriends(json: response?.json as! [String : Any], numberOfFriends: self.numberOfFriends)
            for friend in fr {
                self.friends.append(friend)
            }
        }) { (error) in
            print("error messages response - \(String(describing: error?.localizedDescription))")
        }
    }
}
