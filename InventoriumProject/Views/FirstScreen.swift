//
//  ViewController.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FirstScreen: UIViewController {
    
    @IBOutlet weak var FSEmailTextField: UITextField!
    @IBOutlet weak var FSPasswordTextField: UITextField!
    @IBOutlet weak var FSLoginButton: UIButton!
    @IBOutlet weak var FSRegisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        addTextFields()
        addButtons()
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
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
    }
}



extension FirstScreen {
    func addButtons () {
        designButton(button: FSLoginButton, placegolder: "Login")
        designButton(button: FSRegisterButton, placegolder: "Register")
    }
    
    
    // one function to rule all the buttons in this view controller
    func designButton (button : UIButton, placegolder: String) {
        button.backgroundColor = .clear
        button.setTitle("\(placegolder)", for: .normal)
    }
}


extension FirstScreen {
    @IBAction func loginCliked(_ sender: Any) {
        let email = FSEmailTextField.text
        let password = FSPasswordTextField.text
        let db = Firestore.firestore()
        // find user from the database
        if email != nil && password != nil {
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, err) in
                if err != nil {
                    self.wrongInfoAlert()
                } else {
                    db.collection("Users").document((result?.user.uid)!).getDocument { (doc, err) in
                        if let user = doc?.data() {
                            self.enter_login_view(db: db, information: user)
                        }
                    }
                }
            }
        }
    }
    
    
    func enter_login_view (db: Firestore, information: [String:Any]) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let loginViewController = mainStoryboard.instantiateViewController(identifier: "login_storyboard") as? LoginView else {
            print("Could not find the view controller")
            return
        }
        loginViewController.user_info = information
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func wrongInfoAlert() {
        let alert = UIAlertController(title: "Error", message: "wrong info", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
