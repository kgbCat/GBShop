//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Anna Delova on 12/27/21.
//

import UIKit

class CatalogViewController: UIViewController {

    var name: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }


    @IBAction func toChangeUserProfile(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.goToChangeRegistrationVC, sender: self)
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
