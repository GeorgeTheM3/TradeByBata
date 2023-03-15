//
//  LoginView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import UIKit

class LoginView: UIViewController {
    private var viewModel: LoginViewModelProtocol
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = .helveticaBold25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 17
        textField.backgroundColor = .textFieldColor
        textField.textAlignment = .center
        textField.placeholder = "First name"
        textField.addTarget(nil, action: #selector(editTextFields), for: .allEditingEvents)
        return textField
    }()
    
    private var  passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 17
        textField.backgroundColor = .textFieldColor
        textField.textAlignment = .center
        textField.placeholder = "Password"
        textField.addTarget(nil, action: #selector(editTextFields), for: .allEditingEvents)
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = 17
        button.setTitle("Login", for: .normal)
        button.addTarget(nil, action: #selector(showMainFlow), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(loginButton)
        stack.distribution = .fillProportionally
        stack.spacing = 40
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showMainFlow() {
        let mainFlow = TabBarController()
        mainFlow.modalPresentationStyle = .fullScreen
        present(mainFlow, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackgroundColor
        setViews()
        setConstraintsViews()
    }
    
    @objc private func editTextFields() {
        if let firstName = firstNameTextField.text, let password = passwordTextField.text {
            viewModel.enterFirstName(firstName)
            viewModel.enterPassword(password)
        }
    }
    
    private func setViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(mainStackView)
    }
    
    private func setConstraintsViews() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 70),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 35),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}
