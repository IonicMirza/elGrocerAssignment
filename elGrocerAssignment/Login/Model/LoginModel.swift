//
//  LoginModel.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

struct LoginModel {
    
    let email: String
    let password: String
    
    /// Predefined list of valid users
    static let users: [LoginModel] = [
        LoginModel(email: "ibrar@elgrocer.com", password: "ibrar1234"),
        LoginModel(email: "anas@elgrocer.com", password: "ibrar1234"),
        LoginModel(email: "ali@elgrocer.com", password: "ibrar1234")
    ]
    
    /// Checks if the provided email and password match any valid user
    static func isValidUser(email: String, password: String) -> Bool {
        return users.contains {
            $0.email.lowercased() == email.lowercased() && $0.password == password
        }
    }
}
