//
//  ViewController.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    
    @IBOutlet weak var FSEmailTextField: UITextField!
    @IBOutlet weak var FSPasswordTextField: UITextField!
    @IBOutlet weak var FSLoginButton: UIButton!
    @IBOutlet weak var FSRegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addTextFields()
        /**
         purposely commenting addbuttons
         uncomment it when you want to make design changes to the buttons
         the buttons are still going to be visible when you run the project
         
         addButtons()
         */
    }
    
    
}


extension FirstScreen: UITextFieldDelegate {
    func addTextFields () {
        FSEmailTextField.delegate = self
        FSPasswordTextField.delegate = self
        configureTextFields(textField: FSEmailTextField, placeholder: "E-MAIL")
        configureTextFields(textField: FSPasswordTextField, placeholder: "PASSWORD")
    }
    
    // this is a special delegate function
    // every time a user hits return on the keybard
    // it will dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // if you want to modify the textfields use this function
    func configureTextFields (textField: UITextField, placeholder: String) {
        /// We can choose colors in different ways
        /**
         1) The hex value
        UIColor(rgb: 0x<hex value>)
         2) predefined value
        variable = .white / .black .....
         */
        /// changing the border color
        /**
         textField.layer.borderColor = UIColor.white.cgColor
         textField.layer.borderColor = UIColor(rgb: 0x234567).cgColor
         */
        /// changing the border width
        /**
         textField.layer.borderWidth = <int>
         */
        /// changing the background color
        /**
         textField.backgroundColor = .clear
         textField.backgroundColor = .blue / .white / whatever
         textField.backgroundColor = UIColor(rgb: 0x<hex color code>)
         */
        /// changing textfield placeholder and its color
        /**
         textField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         */
        /// Changing the typed text color
        /**
         textField.textColor = .white
         or
         textField.textColor = UIColor(rgb: 0x<color hex value>)
         */
    }
}



extension FirstScreen {
    // call this function whenever you want to make changed to the buttons
    func addButtons () {
        //designButton(button: FSLoginButton, placegolder: "Login")
    }
    
    
    // one function to rule all the buttons in this view controller
    func designButton (button : UIButton, placegolder: String) {
        /// rounded rectangle look
        /**
        button.layer.cornerRadius = 20
        */
        
        /// <changing border color>
        /**
         button.layer.borderColor = goldColor.cgColor
         */
        
        /// <changing the background color>
        /**
         button.backgroundColor = UIColor(add some coloring)
         */
        
        /// <changing border width>
        /**
         button.layer.borderWidth = 1
         */
        
        /// <to change the placeholder use this>
        /**
         button.setTitle("\(placegolder)", for: .normal)
         */
        
        /// <adding a shadow to the buttons>
        /**
         button.layer.shadowColor = goldColor.cgColor
         button.layer.shadowOffset = CGSize(width: 1, height: 1)
         button.layer.shadowOpacity = 1
         button.layer.shadowRadius = 6
         */
    }
}
