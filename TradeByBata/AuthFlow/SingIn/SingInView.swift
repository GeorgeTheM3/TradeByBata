//
//  SingInView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 15.03.2023.
//

import UIKit

class SingInView: UIViewController {
    private var viewModel: SignInViewModelProtocol
    
    private var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sing in"
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
    
    private var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 17
        textField.backgroundColor = .textFieldColor
        textField.textAlignment = .center
        textField.placeholder = "Last name"
        textField.addTarget(nil, action: #selector(editTextFields), for: .allEditingEvents)
        return textField
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 17
        textField.backgroundColor = .textFieldColor
        textField.textAlignment = .center
        textField.placeholder = "Email"
        textField.addTarget(nil, action: #selector(editTextFields), for: .allEditingEvents)
        return textField
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = 17
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(lastNameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(signInButton)
        stack.distribution = .fillProportionally
        stack.spacing = 40
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var haveAccLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.numberOfLines = 2
        label.textColor = .grayTextColor
        label.textAlignment = .left
        label.font = .helvetica11
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBackgroundColor
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.buttonColor, for: .normal)
        button.addTarget(nil, action: #selector(showLoginScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var signInWithAppleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sing in with Apple"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .helvetica15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var signInWithGoogleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sing in with Google"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .helvetica15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var appleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "apple.logo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private var googleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "g.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var appleStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(appleLogoImageView)
        stack.addArrangedSubview(signInWithAppleLabel)
        stack.distribution = .fill
        stack.spacing = 10
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var googleStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(googleLogoImageView)
        stack.addArrangedSubview(signInWithGoogleLabel)
        stack.distribution = .fill
        stack.spacing = 10
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(googleStackView)
        stack.addArrangedSubview(appleStackView)
        stack.distribution = .fill
        stack.spacing = 30
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackgroundColor
        setViews()
        setConstraintsViews()
    }
    
    @objc private func editTextFields() {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text {
            viewModel.enterFirstName(firstName)
            viewModel.enterLastName(lastName)
            viewModel.enterEmail(email)
        }
    }
    
    @objc private func showLoginScreen() {
        let loginScreen = LoginView(viewModel: LoginViewModel())
        navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    private func setViews() {
        view.addSubview(signInLabel)
        view.addSubview(mainStackView)
        view.addSubview(haveAccLabel)
        view.addSubview(logInButton)
        view.addSubview(bottomStackView)
    }
    
    private func setConstraintsViews() {
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 70),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 35),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 35),
            emailTextField.heightAnchor.constraint(equalToConstant: 35),
            
            haveAccLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            haveAccLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            
            logInButton.leadingAnchor.constraint(equalTo: haveAccLabel.trailingAnchor, constant: 10),
            logInButton.topAnchor.constraint(equalTo: haveAccLabel.topAnchor),
            logInButton.heightAnchor.constraint(equalTo: haveAccLabel.heightAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 90),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalToConstant: 180),
            
            appleLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            appleLogoImageView.widthAnchor.constraint(equalToConstant: 30),
            googleLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            googleLogoImageView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
