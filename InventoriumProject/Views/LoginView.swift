//
//  LoginView.swift
//  InventoriumProject
//
//  Created by John Demirci on 10/19/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit
import FirebaseFirestore


class LoginView: UIViewController {
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var warehouse_button: UIButton!
    @IBOutlet weak var warehouse_id_textfield: UITextField!
    
    var user_info : [String:Any]?
    var warehouse_found: Bool = false
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x333333), colorTwo: UIColor(rgb: 0x666666))
        configure_text_field()
        configure_button()
        configure_label()
    }
    
    @IBAction func button_tapped(_ sender: Any) {
        let db = Firestore.firestore()
        let ware_id = warehouse_id_textfield.text
        db.collection("Warehouses").document(ware_id!).addSnapshotListener { (snapshot, err) in
            if err == nil {
                let warehouse_data = snapshot?.data()
                self.enter_warehouse_view(information: warehouse_data!)
            }
        }
    }
    
    func enter_warehouse_view (information: [String:Any]) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let warehouseController = mainStoryboard.instantiateViewController(identifier: "warehouse_screen") as? WarehouseScreen else {
            print("Could not find the view controller")
            return
        }
        warehouseController.products = information["Products"] as! [[String: Any]]
        navigationController?.pushViewController(warehouseController, animated: true)
    }
    
    
}

extension LoginView {
    func configure_label() {
        name_label.text = "warehouse id"
    }
    
    func configure_text_field() {
        warehouse_id_textfield.backgroundColor = .clear
        warehouse_id_textfield.layer.borderColor = UIColor.white.cgColor
        warehouse_id_textfield.layer.borderWidth = 1
        warehouse_id_textfield.textColor = .white
    }
    
    func configure_button() {
        warehouse_button.setTitle("Enter", for: .normal)
        warehouse_button.layer.borderWidth = 1
        warehouse_button.layer.borderColor = UIColor.white.cgColor
    }
}
