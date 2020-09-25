//
//  RegisterView.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

class UserRegisterView: UIViewController {
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var role: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        addTextFields()
    }
    
    

    
    
}


extension UserRegisterView : UITextFieldDelegate {
    func addTextFields () {
        name.delegate = self
        email.delegate = self
        password.delegate = self
        configureTextFields(textField: name, placeholder: "Name")
        configureTextFields(textField: email, placeholder: "Email")
        configureTextFields(textField: password, placeholder: "Password")
    }
}

extension UserRegisterView {
    @IBAction func roleClicked(_ sender: Any) {
    }
    
    @IBAction func registerClicked(_ sender: Any) {
    }
}

