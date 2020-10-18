//
//  WarehouseStruct.swift
//  InventoriumProject
//
//  Created by John Demirci on 10/17/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import Foundation


struct WarehouseInfo {
    let name: String
    let address: String
    let password: String
    let email: String
    let uid: String?
    static let userType: String = "Warehouse"
}
