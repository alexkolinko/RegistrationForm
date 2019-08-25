//
//  AuthViewController.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
        let login = LoginManager()
        login.logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if error == nil {
                GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET")).start { (nil, result, error) in
                    if error == nil {
                        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                        Auth.auth().signIn(with: credential, completion: { (result, error) in
                            if error == nil {
                                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                            }
                        })
                    }
                }
            }
        }
    }
}



