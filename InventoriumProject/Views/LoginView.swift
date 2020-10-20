//
//  LoginView.swift
//  InventoriumProject
//
//  Created by John Demirci on 10/19/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    var warehouse_found: Bool = false
    @IBOutlet weak var warehouse_id: UITextField!
    @IBOutlet weak var enter_inventory: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        // search for the given warehouse id
        // if found, load the inventory,
        // if not then show an alert message
        
        
        
    }
    

}
