//
//  RegisterView.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

class RegisterView: UIViewController {
    @IBOutlet weak var RVNameTxtField: UITextField!
    
    @IBOutlet weak var RVEmailTxtField: UITextField!
    
    @IBOutlet weak var RVPassword: UITextField!
    
    @IBOutlet weak var RVConfirmPassword: UITextField!
    
    @IBOutlet weak var RVOrganization: UITextField!
    
    @IBOutlet weak var RVRole: UISwitch!
    
    @IBOutlet weak var Register: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        // Do any additional setup after loading the view.
        initTextFields(textField: RVNameTxtField, placeholder: "Full Name")
        initTextFields(textField: RVEmailTxtField, placeholder: "E-mail")
        initTextFields(textField: RVPassword, placeholder: "Password")
        initTextFields(textField: RVConfirmPassword, placeholder: "Confirm Password")
        initTextFields(textField: RVOrganization, placeholder: "Organazitation Name")
        
        
    }
}



extension RegisterView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func initTextFields (textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
    }
    
    func initSwitch () {
        if RVRole.isOn {
            //warehouse worker
        } else {
            // agent
        }
    }
}


extension RegisterView {
    func initButton () {
        Register.backgroundColor = .clear
    }
}

