//
//  UserType.swift
//  InventoriumProject
//
//  Created by John Demirci on 10/16/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import Foundation
struct User {
    let name: String
    let email: String
    let password: String
    let role: String
    let uid: String
    static let userType: String = "User"
}
