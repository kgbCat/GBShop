//
//  RegisterViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/24/21.
//

import UIKit

class RegisterViewController: UIViewController {

    let requestFactory = RequestFactory()

    //MARK: IBoutlets
    @IBOutlet weak var usernameTextField: UITextField! { didSet { configureTextField(textField: usernameTextField)} }
    @IBOutlet weak var passwordTextField: UITextField! { didSet { configureTextField(textField: passwordTextField)} }
    @IBOutlet weak var emailTextField: UITextField! { didSet { configureTextField(textField: emailTextField)} }
    @IBOutlet weak var creditcardTextField: UITextField! { didSet { configureTextField(textField: creditcardTextField)} }
    @IBOutlet weak var registerButon: UIButton!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButon.isEnabled = false
        registerButon.backgroundColor = .systemGray
        textfieldsSetup()
    }

    //MARK: IBactions
    @IBAction func toRegisterNewAccount(_ sender: UIButton) {

        self.register(user: Constants.sharedUser.user)

    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        registerButon.isEnabled = false
        registerButon.backgroundColor = .systemGray
        if isFormFilled() {
            registerButon.isEnabled = true
            registerButon.backgroundColor = .systemTeal
            Constants.sharedUser.user = UserDataRequest(
                userName: usernameTextField.text!,
                password: passwordTextField.text!,
                email: emailTextField.text!,
                creditCard: creditcardTextField.text!
            )}
    }
}
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension RegisterViewController {
    // MARK: API methods
    func register(user:UserDataRequest) {
        let newUser = requestFactory.makeUserDataRequestFatory()
        newUser.register(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let user):
                    if user.result == 1 {
                        self.showAlert(message: user.userMessage)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.performSegue(withIdentifier: Constants.registerThenUnwindToLogin, sender: self)
                        }
                    } else {
                        self.showAlert(message: user.userMessage)
                        print(user.userMessage)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    //MARK: Private methods
    private func textfieldsSetup() {
        [usernameTextField, passwordTextField, emailTextField, creditcardTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    private func showAlert(message: String = "Ошибка регистрации пользователя") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
            creditcardTextField.text != "",
            emailTextField.text != "",
            passwordTextField.text != ""
        else { return false }
        return true
    }
}

