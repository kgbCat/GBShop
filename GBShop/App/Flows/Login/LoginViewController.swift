//
//  ViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/1/21.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {

    let requestFactory = RequestFactory()

    // MARK: IBoutlets
    @IBOutlet weak var usernameTextField: UITextField! { didSet{configureTextField(textField: usernameTextField)}}
    @IBOutlet weak var passwordTextField: UITextField! { didSet{configureTextField(textField: passwordTextField)}}
    @IBOutlet weak var signInButton: UIButton!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defineAccessibilityId() // define accessibilityIdentifiers for UITesting
        signInButton.isEnabled = false
        signInButton.backgroundColor = .systemGray
        textfieldsSetup()
    }

    // MARK: IBActions
    @IBAction func toSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToRegisterVC, sender: self)
    }
    @IBAction func toSignIn(_ sender: UIButton) {
        if Constants.sharedUser.user.userName == usernameTextField.text &&
            Constants.sharedUser.user.password == passwordTextField.text {
                self.performSegue(withIdentifier: Constants.goToCatalogVC, sender: self)
        } else {
            self.auth(request: AuthRequest(userName: usernameTextField.text!, password: passwordTextField.text!))
        }
    }
    @IBAction func unwind( _ seg: UIStoryboardSegue) { }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        signInButton.isEnabled = false
        signInButton.backgroundColor = .systemGray
        if isFormFilled() {
            signInButton.isEnabled.toggle()
            signInButton.backgroundColor = .systemPink
        }
    }
}
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension LoginViewController {
    
    // MARK: API methods
    func auth(request: AuthRequest) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(request: request) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let usersData):
                    if usersData.result == 1 {
                        self.saveUsersDataFromServer(usersData: usersData)
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self.showAlert(message: usersData.userMessage)
                        }
                        self.clearTextFields()
                        self.performSegue(withIdentifier: Constants.goToCatalogVC, sender: self)

                    } else {
                        self.showAlert(message: usersData.userMessage)
                        self.clearTextFields()
                        self.signInButton.isEnabled.toggle()
                        self.signInButton.backgroundColor = .systemGray
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    //MARK: Private methods
    private func defineAccessibilityId() {
        usernameTextField.isAccessibilityElement = true
        usernameTextField.accessibilityIdentifier = "login"

        passwordTextField.isAccessibilityElement = true
        passwordTextField.accessibilityIdentifier = "password"

        signInButton.isAccessibilityElement = true
        signInButton.accessibilityIdentifier = "enter"
    }
    private func clearTextFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    private func saveUsersDataFromServer(usersData: CustomerResponse) {
        Constants.sharedUser.user.userName = usersData.userName!
        Constants.sharedUser.user.password = usersData.password!
        Constants.sharedUser.user.email = usersData.email!
        Constants.sharedUser.user.creditCard = usersData.creditCard!
    }
    private func showAlert(message: String = "Ошибка валидации пользователя!") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "myAlert"
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    private func textfieldsSetup() {
        [usernameTextField, passwordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    private func configureTextField(textField: UITextField) {
        textField.delegate = self
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
    }
    private func isFormFilled() -> Bool {
        guard
            usernameTextField.text != "",
            passwordTextField.text != ""
        else { return false }
        return true
    }
}
