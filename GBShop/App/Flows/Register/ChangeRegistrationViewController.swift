//
//  ChangeRegistrationViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/24/21.
//

import UIKit

class ChangeRegistrationViewController: UIViewController {

    let requestFactory = RequestFactory()

    //MARK: IBoutlets

    @IBOutlet weak var passwordTextField: UITextField! { didSet { configureTextField(textField: passwordTextField)}}
    @IBOutlet weak var emailTextField: UITextField! { didSet { configureTextField(textField: emailTextField)} }
    @IBOutlet weak var creditcardTextField: UITextField! { didSet { configureTextField(textField: creditcardTextField)}}
    @IBOutlet weak var currentPasswordLbl: UILabel! { didSet {
        currentPasswordLbl.text = "Your current password \(Constants.sharedUser.user.password)"}}
    @IBOutlet weak var currentEmailLbl: UILabel! { didSet {
        currentEmailLbl.text = "Your current email \(Constants.sharedUser.user.email)" }}
    @IBOutlet weak var saveButton: UIButton!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldsSetup()
    }

    //MARK: IBactions
    @IBAction func goBackToLoginAndSave(_ sender: UIButton) {
        self.changeUsersData(user: Constants.sharedUser.user)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        saveButton.isEnabled = false
        saveButton.backgroundColor = .systemGray
        if isFormFilled() {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .systemTeal
            let userEdited = UserDataRequest(
                userName: Constants.sharedUser.user.userName,
                password: passwordTextField.text!,
                email: emailTextField.text!,
                creditCard: creditcardTextField.text!)
            Constants.sharedUser.user = userEdited
        }
    }
}
extension ChangeRegistrationViewController {

    func changeUsersData(user:UserDataRequest) {
        let newUser = requestFactory.makeUserDataRequestFatory()
        newUser.changeData(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let user):
                    if user.result == 1 {
                        self.showErrorAlert(message: user.userMessage)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.performSegue(withIdentifier: Constants.unwindToLogin, sender: self)
                        }
                    } else {
                        self.showErrorAlert(message: user.userMessage)
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
        [passwordTextField, emailTextField, creditcardTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    private func showErrorAlert(message: String = "Ошибка регистрации пользователя"){
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
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
            creditcardTextField.text != "",
            emailTextField.text != "",
            passwordTextField.text != ""
        else { return false }
        return true
    }
}
extension ChangeRegistrationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
