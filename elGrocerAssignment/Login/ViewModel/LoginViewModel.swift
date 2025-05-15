//
//  File.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

class LoginViewModel {
    
    /// Attempts to login with provided email and password.
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Validate email format and password length
        guard isValidEmail(email), password.count >= 6 else {
            completion(false)
            return
        }
        
        // Simulate API call delay (2 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Check user credentials with model
            if LoginModel.isValidUser(email: email, password: password) {
                // Save a mock token securely in keychain
                KeychainService.shared.saveToken("mock-token")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    /// Validates email using regular expression
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
