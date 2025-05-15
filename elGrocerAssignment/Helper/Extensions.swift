//
//  extensions.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit


extension UITextField {
    
    func styleTextField(_ textField: UITextField) {
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.setLeftPaddingPoints(12)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
