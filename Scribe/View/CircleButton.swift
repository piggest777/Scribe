//
//  CircleButton.swift
//  Scribe
//
//  Created by Denis Rakitin on 2019-10-03.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable  var cornerRadius: CGFloat = 30.0 {
        didSet {
            setUpView()
        }
       
    }
    
    override func prepareForInterfaceBuilder() {
       setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }

}
