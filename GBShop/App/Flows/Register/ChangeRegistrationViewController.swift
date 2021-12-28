//
//  ChangeRegistrationViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/24/21.
//

import UIKit

class ChangeRegistrationViewController: UIViewController {

    //MARK: IBoutlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var creditcardTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!

    //MARK: IBactions

    @IBAction func goBackToLoginAndSave(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.unwindToLogin, sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
