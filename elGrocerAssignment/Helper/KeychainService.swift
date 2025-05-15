//
//  File.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

class KeychainService {
    static let shared = KeychainService()
    private let tokenKey = "userToken"

    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }

    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }

    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
