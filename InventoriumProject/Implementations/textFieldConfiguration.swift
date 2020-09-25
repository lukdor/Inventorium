//
//  textFieldConfiguration.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/25/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

func configureTextFields (textField: UITextField, placeholder: String) {
    textField.layer.borderColor = UIColor.white.cgColor
    textField.layer.borderWidth = 1
    textField.backgroundColor = .clear
    textField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    textField.textColor = .white
}

