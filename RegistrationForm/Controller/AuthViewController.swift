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
    
    let backgraund = BackgraundMethod.sharedInstance
    let imageBackgraund = "Background"
    let buttonCastom = UIButton()
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupButton()
        backgraund.backgroundImage(view: self.view, image: imageBackgraund)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
    func setupButton() {
        buttonCastom.layerWithFrame(sampleButton: loginButton, title: "Войти")
        buttonCastom.layerWithFrame(sampleButton: registrationButton, title: "Регистрация")
        buttonCastom.layerWithoutFrame(sampleButton: facebookButton, title: "Войти через Facebook")
        buttonCastom.layerWithoutFrame(sampleButton: googleButton, title: "Войти через Google")
        buttonCastom.layerWithoutFrame(sampleButton: forgotPasswordButton, title: "Забыли пароль?")
        registrationButton.isEnabled = false
        googleButton.isEnabled = false
        forgotPasswordButton.isEnabled = false
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
        let login = LoginManager()
        login.logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if result!.isCancelled {
                print("is cancelled")
            } else {
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
}



