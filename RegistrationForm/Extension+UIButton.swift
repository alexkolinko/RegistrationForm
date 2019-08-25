//
//  Extension+UIButton.swift
//  RegistrationForm
//
//  Created by Alexandr on 8/25/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func layerWithFrame(sampleButton: UIButton!, title: String) {
        let borderAlpha : CGFloat = 0.7
        sampleButton.setTitle(title, for: UIControl.State.normal)
        sampleButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sampleButton.backgroundColor = UIColor.clear
        sampleButton.layer.borderWidth = 1.0
        sampleButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        sampleButton.layer.cornerRadius = sampleButton.frame.height/2.0
    }
    
    func layerWithoutFrame(sampleButton: UIButton!, title: String) {
        sampleButton.setTitle(title, for: UIControl.State.normal)
        sampleButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sampleButton.backgroundColor = UIColor.clear
        sampleButton.layer.cornerRadius = sampleButton.frame.height/2.0
    }
}
