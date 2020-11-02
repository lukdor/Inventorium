//
//  WarehouseRegisterView.swift
//  InventoriumProject
//
//  Created by John Demirci on 9/25/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WarehouseRegisterView: UIViewController {
    @IBOutlet weak var warehouseName : UITextField!
    @IBOutlet weak var phonNumber : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var address : UITextField!
    @IBOutlet weak var registerWarehouse : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        setupTextFields()
        configureButton()
    }
    

}

/*
 BUTTON AND TEXTFIELD CONFIGURATION
 */
extension WarehouseRegisterView : UITextFieldDelegate {
    func setupTextFields () {
        warehouseName.delegate = self
        phonNumber.delegate = self
        password.delegate = self
        address.delegate = self
        configureTextFields(textField: warehouseName, placeholder: "Warehouse Name")
        configureTextFields(textField: phonNumber, placeholder: "Email")
        configureTextFields(textField: password, placeholder: "Password")
        configureTextFields(textField: address, placeholder: "Address")
    }
    func configureButton () {
        registerWarehouse.layer.borderWidth = 1
        registerWarehouse.layer.borderColor = UIColor.white.cgColor
        registerWarehouse.backgroundColor = .clear
        registerWarehouse.titleLabel?.text = "Register Warehouse"
        registerWarehouse.setTitleColor(.white, for: .normal)
    }
}


// BUTTON CLICKED
extension WarehouseRegisterView {
    @IBAction func registerClicked(_ sender: Any) {
        /*
         make validations and add the warehouse to the database
         */
        let warehouse = WarehouseInfo(name: warehouseName.text!, address: address.text!, password: password.text!, email: phonNumber.text!, uid: nil)
        add_warehouse(warehouse: warehouse)
        navigationController?.popViewController(animated: true)
    }
}

extension WarehouseRegisterView {
    func phone_validation () -> Bool {
        if let number = phonNumber.text {
            if number.count != 10 { return false }
        }
        return true
    }
}


extension WarehouseRegisterView {
    func add_warehouse(warehouse: WarehouseInfo) {
        Auth.auth().createUser(withEmail: warehouse.email, password: warehouse.password) { (res, err) in
    
            
            if let error = err { print(error); return }
            let data = ["name": warehouse.name,
                        "address": warehouse.address,
                        "email": warehouse.email,
                        "tyoe": WarehouseInfo.userType,
                        "id":res!.user.uid]
            
            let db = Firestore.firestore()
            db.collection("Warehouses").document("\(res!.user.uid)").setData(data)
        }
    }
}
