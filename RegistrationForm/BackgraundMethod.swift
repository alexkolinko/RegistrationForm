//
//  BackgraundMethod.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation

import UIKit

class BackgraundMethod: NSObject {
 
    static let sharedInstance = BackgraundMethod()
    private override init() {}
    
    func backgroundImage(view: UIView, image: String) {
        let imageView = UIImageView(image: UIImage(named: image)!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        let layer = CAGradientLayer()
        layer.frame = imageView.frame
        layer.colors = [UIColor.green.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.9).cgColor]
        imageView.layer.addSublayer(layer)
        view.insertSubview(imageView, at: 0)
    }
}
