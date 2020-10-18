//
//  RegisterView.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserRegisterView: UIViewController {
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var role: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    let warehouse_worker = UIButton()
    
    let agent = UIButton()
    
    let role_popup_view : UIView = {
        let popup_view = UIView()
        popup_view.translatesAutoresizingMaskIntoConstraints = false
        popup_view.backgroundColor = UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.5)
        popup_view.clipsToBounds = true
        popup_view.layer.cornerRadius = 20
        return popup_view
    }()
    
    let dismiss_popup_view_button: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismiss_pop_up), for: .touchUpInside)
        return button
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        addTextFields()
    }
}


/* TEXT FIELD EXTENSION*/
extension UserRegisterView : UITextFieldDelegate {
    func addTextFields () {
        name.delegate = self
        email.delegate = self
        password.delegate = self
        configureTextFields(textField: name, placeholder: "Name")
        configureTextFields(textField: email, placeholder: "Email")
        configureTextFields(textField: password, placeholder: "Password")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

/* BUTTON CLICKS */
extension UserRegisterView {
    @IBAction func roleClicked(_ sender: Any) {
        resignFirstResponder()
        setPopUpConstraints()
        addpopupbuttons()
        configurePopupView()
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        // do checks
        let emailCheck = email_check(YourEMailAddress: email.text)
        let passwordCheck = password_check(mypassword: password.text)
        let roleCheck = role_check()
        if emailCheck && passwordCheck && roleCheck{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (result, err) in
                if err != nil {
                    print(err.debugDescription)
                    return
                }
                let usr = User(name: self.name.text!,
                               email: self.email.text!,
                               password: self.password.text!,
                               role: self.role.currentTitle!,
                               uid: (result?.user.uid)!)
                
                let data = ["name": usr.name,
                            "email": usr.email,
                            "role": usr.role,
                            "type": User.userType,
                            "uid" : usr.uid]
                
                let db = Firestore.firestore()
                db.collection("Users").document("\(usr.uid)").setData(data)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}


/*
    POPUP VIEW
 */
extension UserRegisterView {
    func setPopUpConstraints () {
        view.addSubview(role_popup_view)
        role_popup_view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        role_popup_view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        role_popup_view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        role_popup_view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
    func configurePopupView () {
        role_popup_view.addSubview(dismiss_popup_view_button)
        dismiss_popup_view_button.rightAnchor.constraint(equalTo: role_popup_view.rightAnchor, constant: -10).isActive = true
        dismiss_popup_view_button.topAnchor.constraint(equalTo: role_popup_view.topAnchor, constant: 10).isActive = true
        dismiss_popup_view_button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dismiss_popup_view_button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        role_popup_view.addSubview(warehouse_worker)
        warehouse_worker.centerXAnchor.constraint(equalTo: role_popup_view.centerXAnchor).isActive = true
        warehouse_worker.centerYAnchor.constraint(equalTo: role_popup_view.centerYAnchor).isActive = true
        warehouse_worker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        warehouse_worker.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        role_popup_view.addSubview(agent)
        agent.centerXAnchor.constraint(equalTo: role_popup_view.centerXAnchor).isActive = true
        agent.topAnchor.constraint(equalTo: warehouse_worker.bottomAnchor, constant: 10).isActive = true
        agent.widthAnchor.constraint(equalToConstant: 200).isActive = true
        agent.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func dismiss_pop_up() {
        role_popup_view.removeFromSuperview()
    }
}

extension UserRegisterView {
    func addpopupbuttons() {
        configure_popup_view_buttons(button: warehouse_worker, user_role: "Warehouse Worker")
        configure_popup_view_buttons(button: agent, user_role: "Agent")
    }
    
    func configure_popup_view_buttons(button: UIButton, user_role: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(user_role, for: .normal)
        button.addTarget(self, action: #selector(button_action(sender:)), for: .touchUpInside)
    }
    
    @objc func button_action(sender: UIButton) {
        role.setTitle(sender.currentTitle, for: .normal)
        role_popup_view.removeFromSuperview()
    }
}

extension UserRegisterView {
    func email_check (YourEMailAddress: String?) -> Bool {
        if YourEMailAddress == nil {return false}
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    
    func password_check(mypassword: String?) -> Bool {
        if mypassword == nil {return false}
        let passed = mypassword!
        if passed.count < 8 {return false}
        if passed.range(of: #"\s+"#, options: .regularExpression) != nil {
            return false
        }
        return true
    }
    
    func role_check() -> Bool {
        if role.currentTitle == "Role" || role.currentTitle == "role" {
            return false
        }
        return true
    }
}

