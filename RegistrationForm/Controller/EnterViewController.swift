//
//  EnterViewController.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
    
    let backgraund = BackgraundMethod.sharedInstance
    let imageBackgraund = "Background"
    let buttonCastom = UIButton()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enertButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupBackgraund()
        registerForKeyboardNotification()
    }
    
    override func viewDidLayoutSubviews() {
        setupTextField()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func setupBackgraund() {
        backgraund.backgroundImage(view: self.view, image: imageBackgraund)
    }
    
    func setupButton() {
        buttonCastom.layerWithFrame(sampleButton: enertButton, title: "Войти")
        buttonCastom.layerWithoutFrame(sampleButton: forgotPasswordButton, title: "Забыли пароль?")
        forgotPasswordButton.isEnabled = false
    }
    
    func setupTextField() {
        emailField.backgroundColor = UIColor.clear
        emailField.borderStyle = .none
        emailField.attributedPlaceholder = NSAttributedString(string:"введите почту", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField.addUnderline()
        passwordField.backgroundColor = UIColor.clear
        passwordField.borderStyle = .none
        passwordField.attributedPlaceholder = NSAttributedString(string:"введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.addUnderline()
    }
    
    @IBAction func enterAction(_ sender: UIButton) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        validate()
    }
}

extension EnterViewController {
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

extension EnterViewController {
    
    func validate() {
        do {
            let email = try emailField.validatedText(validationType: ValidatorType.email)
            let password = try passwordField.validatedText(validationType: ValidatorType.password)
            let data = RegisterData(email: email, password: password)
            save(data)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func save(_ data: RegisterData) {
        showAlert(for: "Данные введены успешно.")
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

