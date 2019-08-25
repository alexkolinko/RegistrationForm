//
//  FacebookManager.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON


class FacebookManager {
    
    static let shared = LoginManager()
    
    public class func getUserData(completion: @escaping() -> Void) {
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(normal)"]).start { (connection, result, error) in
                if error == nil {
                    let json = JSON(result!)
                    print(json)
                    User.currentUser.setUser(json)
                    completion()
                }
            }
        }
    }
}

