//
//  UserViewController.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.layer.cornerRadius = 70/2
        avatarImage.layer.borderWidth = 1.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.clipsToBounds = true
        
        if AccessToken.current != nil {
            FacebookManager.getUserData(completion: {
                self.userNameLabel.text = User.currentUser.name
                self.emailLabel.text = User.currentUser.email
                self.avatarImage.image = try! UIImage(data: Data(contentsOf: URL(string: User.currentUser.pictureURL!)!))
            })
        }
        
    }

    @IBAction func logoutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
}
