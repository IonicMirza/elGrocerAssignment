//
//  LoginViewController.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    var onLoginSuccess: (() -> Void)?
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let loader = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        configureUI()
    }
    
    // MARK: - UI Setup
    
    private func configureUI() {
        configureEmailField()
        configurePasswordField()
        configureLoginButton()
        configureStackView()
        configureLoader()
    }
    
    private func configureEmailField() {
        emailField.placeholder = "Email"
        emailField.styleTextField(emailField) // Assuming this is an extension method styling the text field
    }
    
    private func configurePasswordField() {
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.styleTextField(passwordField)
    }
    
    private func configureLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowRadius = 4
        
        // Set fixed height
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add button action
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func configureLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func loginTapped() {
        // Start loader animation while logging in
        loader.startAnimating()
        
        // Attempt login via ViewModel
        viewModel.login(email: emailField.text ?? "", password: passwordField.text ?? "") { [weak self] success in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                if success {
                    // Notify success callback
                    self?.onLoginSuccess?()
                } else {
                    // Show error alert on failure
                    let alert = UIAlertController(title: "Error", message: "Invalid credentials", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
