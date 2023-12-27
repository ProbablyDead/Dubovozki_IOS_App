//
//  AuthViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 03.12.2023.
//

import UIKit
import GoogleSignIn

// MARK: - Login service protocol
protocol LoginServiceProtocol {
    func checkAuth() -> Bool
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func loginViaGoogle(presentingView: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) 
    func signOut()
}

// MARK: - Nework data service initializer protocol
protocol NetworkDataInitializerProtocol {
    func configure()
}

// MARK: - Nework data service protocol
protocol NetworkDataServiceProtocol {
    func getData(completion: @escaping ((Data) -> Void))
}

// MARK: - Login service view protocol
protocol LoginViewControllerProtocol {
    func loginUser(email: String, password: String)
    func success()
    func failure(error: Error)
}

// MARK: - Login service view 
class LoginViewController: UIViewController, UITextFieldDelegate {
    private enum Constants {
        static let logoImageName: String = "LogoImage"
        
        static let emailPlaceholder: String = "Email".localized()
        static let passwordPlaceholder: String = "Password".localized()
        static let restorePasswordButtonText: String = "Forgot password?".localized()
        static let loginButtonText: String = "Login/Register".localized()
        
        static let buttonCornerRadius: CGFloat = 5
        
        static let topConstant:CGFloat = -180
        static let sidesConstant: CGFloat = 10
        static let restorePasswordButtonTopConstant: CGFloat = 10
        static let loginButtonTopConstant: CGFloat = 50
        static let loginViaGoogleButtonTopConstant: CGFloat = 20
        
        static let logoImageConstant: CGFloat = -250
    }
    
    var router: RouterProtocol!
    var loginService: LoginServiceProtocol!
    
    private lazy var emailTextField: UITextField = {
        let controller = UITextField()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.backgroundColor = .white
        controller.attributedPlaceholder = NSAttributedString(
            string: Constants.emailPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
            )
        controller.isUserInteractionEnabled = true
        controller.autocapitalizationType = .none
        controller.autocorrectionType = .no
        controller.borderStyle = .roundedRect
        controller.clipsToBounds = true
        controller.delegate = self
        controller.addTarget(self, action: #selector(removeBorder), for: .editingDidBegin)
        controller.textContentType = .username
        controller.keyboardType = .emailAddress
        controller.textColor = .black
        
        controller.becomeFirstResponder()
        return controller
    }()
    
    private lazy var passwordTextField: UITextField = {
        let controller = UITextField()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.attributedPlaceholder = NSAttributedString(
            string: Constants.passwordPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
            )
        controller.backgroundColor = .white
        controller.isSecureTextEntry = true
        controller.autocapitalizationType = .none
        controller.autocorrectionType = .no
        controller.delegate = self
        controller.borderStyle = .roundedRect
        controller.clipsToBounds = true
        controller.addTarget(self, action: #selector(removeBorder), for: .editingDidBegin)
        controller.textContentType = .password
        controller.textColor = .black
        return controller
    }()
    
    @objc private func removeBorder(_ sender: UITextField) {
            sender.layer.borderWidth = 0
    }
    
    private lazy var restorePassword: UIButton = {
        let controller = UIButton()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.setTitle(Constants.restorePasswordButtonText, for: .normal)
        controller.backgroundColor = .clear
        controller.setTitleColor(.cyan, for: .normal)
        controller.layer.cornerRadius = Constants.buttonCornerRadius
        controller.addTarget(self, action: #selector(restorePasswordButtonPressed), for: .touchUpInside)
        return controller
    }()
    
    @objc
    private func restorePasswordButtonPressed(_ sender: UIButton) {
        if (emailTextField.text!.isEmpty) {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailTextField.layer.cornerRadius = 5
            emailTextField.layer.borderWidth = 1
            return
        }
        
        resetPassword()
    }
    
    private lazy var loginButton: UIButton = {
        let controller = UIButton()
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.setTitle(Constants.loginButtonText, for: .normal)
        controller.backgroundColor = .systemGreen
        controller.layer.cornerRadius = Constants.buttonCornerRadius
        controller.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return controller
    }()
    
    @objc
    private func loginButtonPressed(_ sender: Any) {
        if (emailTextField.text!.isEmpty) {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailTextField.layer.cornerRadius = 5
            emailTextField.layer.borderWidth = 1
            return
        }
        
        if (passwordTextField.text!.isEmpty) {
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.cornerRadius = 5
            passwordTextField.layer.borderWidth = 1
            return
        }
        
        loginUser(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    private lazy var loginViaGoogleButton: GIDSignInButton = {
        let controller = GIDSignInButton()
        controller.addTarget(self, action: #selector(signInViaGoogleButtonPressed), for: .touchUpInside)
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    @objc
    private func signInViaGoogleButtonPressed(sender: GIDSignInButton) {
        loginViaGoogle()
    }
    
    private let logoImageView: UIImageView = {
        let controller = UIImageView(image: UIImage(named: Constants.logoImageName))
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .app
        view.tintColor = .systemBlue
        navigationItem.hidesBackButton = true
        
        hideKeyboardWhenTappedAround()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(loginViaGoogleButton)
        view.addSubview(logoImageView)
        view.addSubview(restorePassword)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.logoImageConstant).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.topConstant).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesConstant).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sidesConstant).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.sidesConstant).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesConstant).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sidesConstant).isActive = true
        
        restorePassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.restorePasswordButtonTopConstant).isActive = true
        restorePassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sidesConstant).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.loginButtonTopConstant).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesConstant).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sidesConstant).isActive = true
        
        loginViaGoogleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Constants.loginViaGoogleButtonTopConstant).isActive = true
        loginViaGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesConstant).isActive = true
        loginViaGoogleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.sidesConstant).isActive = true
    }
}

// MARK: - Login
extension LoginViewController: LoginViewControllerProtocol {
    func userLogged() {
        router.popToRoot()
    }
    
    func success() {
        userLogged()
    }
    
    func failure(error: Error) {
        switch error {
        case LoginNetworkError.userNotFound:
            let alert = UIAlertController(title: "No such user".localized(),
                                          message: "Create an account?".localized(),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue".localized(), style: .default) {[weak self] _ in
                self?.createUser()
            })
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        case LoginNetworkError.invalidEmail:
            let alert = UIAlertController(title: "Invalid email".localized(),
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        case LoginNetworkError.wrongPassword:
            let alert = UIAlertController(title: "Wrong password".localized(),
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        case LoginNetworkError.emailExists:
            let alert = UIAlertController(title: "Email exists".localized(),
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        default:
            return
        }
    }
    
    func createUser() {
        loginService.createAccount(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {[weak self] result in
            switch result {
            case .success():
                self?.userLogged()
            case .failure(let error):
                let alert = UIAlertController(title: "Registration error".localized(),
                                              message: "\(error)",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        loginService.loginUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(()):
                success()
            case .failure(let error):
                self.failure(error: error)
            }
        }
    }
    
    func loginViaGoogle() {
        loginService.loginViaGoogle(presentingView: self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(()):
                success()
            case .failure(let error):
                self.failure(error: error)
            }
        }
    }
    
    func resetPassword() {
        let alert = UIAlertController(title: "Reset password".localized(),
                                      message: "Send email with a password reset link?".localized(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue".localized(), style: .default) {[weak self] _ in
            self?.loginService.resetPassword(email: self?.emailTextField.text ?? "") { [weak self] result in
                switch result {
                case .success(()):
                    return
                case .failure(let error):
                    self?.failure(error: error)
                }
            }
        })
        self.present(alert, animated: true)
    }
}

// MARK: - Moving focus
extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
            return false
        }
        
        if (textField == passwordTextField) {
            loginButton.sendActions(for: .touchUpInside)
            textField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - Hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
